# “Global” git hooks

## Rationale

The hooks in the `global-githooks` folder are proposed to be used as [githooks](https://git-scm.com/docs/githooks) in each and every one of your projects.

These must be copied into the respective `.git/hooks` directory in each repository. If you are using the setup scripts from this project, this will be automatically done, every time you start a shell with a project.

## Hooks in this project

* `pre-commit` – check the content of each commit, rejecting binaries, UTF-BOMs and common "incomplete" tags
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
* `prepare-commit-msg` – prepare each commit message (prefixing based on ideas from Gitflow)
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
      * `<project-prefix>-<ticket-number>: (bugfix) ` for bugfix branches (e.g., `JIRA-123: (bugfix) My message`)
      * `<project-prefix>-<ticket-number>: (hotfix) ` for hotfix branches (e.g., `JIRA-123: (hotfix) My message`)
      * `release <version>: ` for release branches (e.g., `release 1.2.3.: My message`)
* `commit-msg` – check the text of each commit message based on https://cbea.ms/git-commit/
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

There is also a helper script `reject` – with the help of Dot Matrix, we can reject a commit in style.