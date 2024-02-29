# Various useful utility scripts

# `pedit`
Use your favorite text editor to modify and update your `$PATH`

## Installation

1. Copy or move `pedit.sh` to whatever permanent installation location you want.
2. Add an alias to your `.profile`, `.bashrc`, *etc*. that *sources* `pedit.sh`:

```
alias pedit='source /path/to/pedit.sh'
```

## Usage

When you run your `pedit` alias from a shell, your `$EDITOR` will launch with a
temp file containing all directories on your `$PATH`, one per line. Make
changes to the order, remove directories, *etc*. When you are happy with the
changes, save the file and exit the editor. Your `$PATH` will be updated with
the new list of directories.

If you exit your editor without saving, or there are no valid entries, the
`$PATH` is not updated.

You can optionally specify a different path-like environment variable to edit
as the first argument on the command line, e.g.,

    pedit PYTHONPATH


# `bak`

Create and restore simple file/directory backups

## Installation

`bak` is a simple bash script. Put it anywhere on your path and ensure it has
executable permissions.

## Usage

`bak` will copy a local file/directory with a timestamped suffix:

    % ls -l
    ls -l
    total 0
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 bc
    % bak a
    % ls -l
    total 0
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a.240217-225351.bak
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 bc

Running `bak` on a `bak`-generated backup file will restore that backup to the
original filename. If the original filename already exists, it will first be
`bak`ed up.

    % bak a.240217-225351.bak
    % ls -l
    total 0
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a.240217-225521.bak
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 bc

Because `bak` uses timestamp suffixes, you can create several local backups.
`bak` is simple and only timestamps to the second, which should be more than
sufficient for its intended usage.

    % bak a
    % bak a
    total 0
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 a.240217-225521.bak
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:58 a.240217-225813.bak
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:58 a.240217-225815.bak
    -rw-r--r--  1 drootang  staff     0B Feb 17 22:53 bc

## Advantages of `bak` over `cp`

`bak` will never overwrite anything. Unless you have `cp` aliased to `cp -i`,
you run the risk of accidentally overwriting something important while using
`cp` to manage local file versions.

When restoring a previously backed-up file, `bak` only requires one command
where `cp` would require two.

## Notes

The existence of this script should not be taken as an endorsement of haphazard
backup strategies nor inefficient workflows. Sometimes you just need to be
*sure* a copy of a file is around, or need quick old-school local versioning.


# `swap`

Swap the names of two files

## Installation

`swap` is a simple bash script. Put it anywhere on your path and ensure it has
executable permissions.

## Usage

`swap` will swap the names of two files using a local temporary file:

    % ls
    a.txt  b.txt
    % cat a.txt
    aaa
    % cat b.txt
    bbb
    % swap a.txt b.txt
    % cat a.txt
    bbb
    % cat b.txt
    aaa


# `csvtab`

## Installation

`csvtab` is a simple bash script. Put it anywhere on your path and ensure it
has executable permissions.

## Usage

Read a CSV file into neatly organized columns into `$EDITOR` or vim. `$EDITOR`
must support using `-` to read from stdin.

You may pass the CSV filename as an argument to `csvtab` or pipe it in:

    % csvtab input.csv
    % cat input.csv | csvtab
