# Split each path on PATH onto its own line and allow user to edit.
# Then join and assign to PATH.
# This script must be *sourced* not executed, e.g., `alias pedit="~/sw/bin/pedit.sh"`
# Optionally specify a different env, e.g.,
#   pedit PYTHONPATH
if [[ -n "$1" ]] ; then
    VAR=$1
else
    VAR=PATH
fi
TMP=$(mktemp $USER-pedit.XXXXXXXXXX)
eval "echo \$$VAR" | sed 's/:/\n/g' > $TMP
${EDITOR:-vi} $TMP
DATA=$(paste -sd : $TMP)
CURRENT=$(eval echo -n \$$VAR)
if [[ -z ${DATA// /} ]] || [[ "$CURRENT" == "$DATA" ]] ; then
    eval "echo $VAR not changed"
else
    eval "$VAR=\"$DATA\""
    eval "echo $VAR updated"
fi
rm -f "$TMP"
