# shell

A collection of basic shell/CLI setup in my acquired taste.

# “Global” git hooks

The git-hooks in the `global-git-hooks` folder are proposed to be used as git hooks in each and every one of your projects.

These must be copied into each `.git/hooks` directory. If you are using the setup scripts from this project, this will be
automatically done, every time you start a shell with a project.

* `pre-commit` -- check the content of each commit, rejecting binaries, UTF-BOMs and common TODO tags
  * rejecting all kinds of UTF BOMs, unless they are allowed via an environment variable:
    * `COMMIT_ALLOW_UTF8_BOM` means that UTF-8 BOMs are allowed in commits; exit status `64` denotes failed commits because of UTF-8 BOMs
    * `COMMIT_ALLOW_UTF16_BOM` means that UTF-16 BOMs (big-endian and little-endian) are allowed in commits; exit status `65` denotes failed commits because of UTF-16 BOMs
    * `COMMIT_ALLOW_UTF32_BOM` means that UTF-32 BOMs (big-endian and little-endian) are allowed in commits; exit status `66` denotes failed commits because of UTF-32 BOMs
  * rejecting common "code incomplete" comment tags, unless they are allowed via an environment variable:
    * `COMMIT_ALLOW_FIXME` means that FIXME comments are allowed in commits; exit status `67` denotes failed commits due to FIXME tags
    * `COMMIT_ALLOW_TODO` means that TODO comments are allowed in commits; exit status `68` denotes failed commits due to TODO tags
    * `COMMIT_ALLOW_XXX` means that XXX comments are allowed in commits; exit status `69` denotes failed commits due to XXX tags
  * rejecting non-text files (i.e., binary files), unless they are allowed via an environment variable:
    * `COMMIT_ALLOW_BINARY` means that binary files can be committed; exit status `70` denotes failed commits due to binary files
* `prepare-commit-msg` -- prepare each commit message (prefixing based on ideas from Gitflow)
  * expected format is `<type>/<project prefix>-<ticket number>(-optional-human-readable-comments)` whereby:
    * `<type>` is either `feature`, `bugfix`, `hotfix`, or `release`
      * `release` branche should have a `<version number>` instead of `<project prefix>-<ticket number>`
    * `<project prefix>` is an ALLCAPS ticketing reference (e.g., corresponding JIRA project key)
    * `<ticket number>` is the number of the ticket in the referenced projeect
    * `(-optional-humand-readable-comments)` in order to keep your feature branch digestible for human consumers
    * full example: `feature/JIRA-123-add-attachments`
  * prefixing happens with the following logic:
    * if prefix already present: NOP
    * if the branch name does not start with `feature/`, `bugfix/`, `hotfix/`, or `release/` of the above: NOP
    * if the branch name does not correspond to the expected naming scheme: exit status `96` and thus abort the commit
    * otherwise take the commit message
    * make the first character uppercase
    * add prefix as follows:
      * `<project-prefix>-<ticket-number>: ` for feature branches (e.g., `JIRA-123: My message`)
      * `<project-prefix>-<ticket-number> (bugfix): ` for bugfix branches (e.g., `JIRA-123 (bugfix): My message`)
      * `<project-prefix>-<ticket-number> (hotfix): ` for hotfix branches (e.g., `JIRA-123 (hotfix): My message`)
      * `release <version>: ` for release branche (e.g., `release 1.2.3.: My message`)
* `commit-msg` -- check the text of each commit message based on https://cbea.ms/git-commit/
  * Rule 0: There must be a commit message
    * violations are denoted by exit status `80`
  * Rule 1: Separate the subject line and the body with an empty line
    * violations are denoted by exit status `81`
  * Rule 2: Subject line is limited to 50 characters
    * violations are denoted by exit status `82`
    * can be relaxed by setting `COMMIT_SUBJECT_LINE_LENGTH` to the desired length to be checked
  * Rule 3: Capitalize the subject line
    * done transparently by `prepare-commit-msg`, thus exit status `83` is unused
  * Rule 4: Do not end the subject line with a period
    * violations are denoted by exit status `84`
  * Rule 5: Use imperative mood in the subject line
    * is not checked thus exit status `85` is ununsed
  * Rule 6: Wrap the lines of the body at 72 characters
    * violations are denoted by exit status `86`
    * can be relaxed by setting `COMMIT_BODY_LINE_LENGTH` to the desired length to be checked
  * Rule 7: Use the body to explain what and why vs. how
    * is not checked thus exit status `87` is ununsed

There is also a helper script `reject` -- with the help of Dot Matrix, we can reject a commit in style

## Note about control variables

The control variables have to be _set_ (declaration is not enough), but their value is unused.  
You can thus use any value you see fit (`1` is used in tests), and can use _unset_ in case you want to remove the "flag".

# Open TODOs

* Extend this README.md with:
  * Rationale
  * Setup (for Cygwin)
* Write README.md in global-git-hooks
* Write README.md in rc-shellmagick.d
* Do proper setup and testing on MingW
* Do proper setup and testing on Darwin
* Do proper setup and testing on a native Linux command line
* Do proper setup and testing on WSL2
* MAVEN_DEBUG_PORT=8000
* MAVEN_SETTINGS_FILE...
* Check all `if`s so that there are no naked `if`s...
* Check all paths for cygpath (mingw? darwin? etc.)

# Appendix A: About exit codes

Why not just use `0` or `1` but some weird exit codes? Cf. https://tldp.org/LDP/abs/html/exitcodes.html

# Appendix B: Why tabs? What's wrong with you? Who hurt you?

Because the only acceptable way is "tabs for indentation, spaces for alignment".

The reasoning is easy, once you had a colleague (or you yourself have to live) with impaired visuals:  
when using any kind of zoom function, you can easily descrease the "tab size" (roughly: "how many  
space's space should a tab take?"), but you cannot easily reduce the amount of space at the  
beginning of each and every line.

If it would be up to me, I would just implement fibonacci indentation with tabs as mandatory, everywhere.
