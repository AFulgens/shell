# shellmagick

A collection of basic shell/CLI setup in my acquired taste.

The essence of the idea is to have a standard “developer shell” set up with some quirks added to different kinds of projects (git, Java, Maven, etc.).
This is achieved through having an entry point chained through `.bash_profile` doing some tweaks in the shell and then invoking `BOOTSTRAP_SCRIPT`.
That should be defaulted to `rc-shellmagick.d-bootstrap.sh`, which then will iterate through all your projects in your projects directory and you can then select a project to jump into in that specific shell.
For that project than `rc-shellmagick.d.sh` will set up everything below, in a similar sence then `rc` is setting up your *nix just after booting.

## Setup

### Cygwin

* Clone this repository to `C:/projects/tools/shellmagick`.
* Create (even empty) default project folder `C:/projects/git/sandbox`.
* Install Cygwin (vanilla should be enough, no additional packages should be enforced through this utility collection).
* Replace your `.bash_profile` with the `.bash_profile` from this repository.
* Set up the environment variables that are expected in `cygwin-bootstrap.cmd`
* Start `cygwin-bootstrap.cmd` (either by double-clicking, through CMD or for best results via [Windows Terminal](https://github.com/microsoft/terminal), feel free to use the `logo.png` from this project 😉).
* Enjoy.

### Customization

* We assume that the environment variable `BOOTSTRAP_SCRIPT` is set.
  * In case you are starting in Windows through `cygwin-bootstram.cmd`, this is set up to be `C:/projects/tools/shellmagick/rc-shellmagick.d-bootstrap.sh`. In case you have this repository under a different path, adjust it in the `.cmd` file accordingly.
* Consult the part marked `BASE CUSTOMIZATION` and `TOOL CUSTOMIZATION` in `rc-shellmagick.s-bootstrap.sh` in case you want to adjust paths or default values for control variables.

## Note about control variables

The control variables have to be _set_ (declaration in itself is not enough), but their value is unused, unless otherwise noted (e.g., git message length controls).  
You can thus use any value you see fit (`1` is used in tests), and can use _unset_ in case you want to remove the "flag".

## “Global” githooks

The directory `global-githooks` contains [githooks](https://git-scm.com/docs/githooks), which will be automatically copied into projects that you open through shellmagick.

For rationale and detailed description of hooks in this project see the documentation [“Global” git hooks](./global-githooks/README.md).

## Open TODOs

* Rework as part of https://projectenv.io/?
* Add "global" .gitignore
  * Ability to "merge" .mailmap, .gitattributes, .gitignore, i.e., copy only entries still missing
* Extend this README.md with:
  * Setup (for !Cygwin)
* Write README.md in rc-shellmagick.d
* Do proper setup and testing on MingW
* Do proper setup and testing on Darwin
* Do proper setup and testing on a native Linux command line
* Do proper setup and testing on WSL2
* Provide bootstrapping for
  * maven-wrapper (copy it from this project)
  * scan .gitattributes for sane defaults, if missing WARN
  * scan .gitignore for sane defaults (e.g., .fork), if missing WARN
* MAVEN_DEBUG_PORT=8000
* MAVEN_SETTINGS_FILE cygpath?
* Check all `if`s so that there are no naked `if`s...
* Check all paths for cygpath (mingw? darwin? etc.)
* Check all paths for Windows example bins and make them dynamic/configurable

## Appendix A: About exit codes

Why not just use `0` or `1` but some weird exit codes? Cf. https://tldp.org/LDP/abs/html/exitcodes.html

## Appendix B: Why tabs? What's wrong with you? Who hurt you?

Because the only acceptable way is "tabs for indentation, spaces for alignment".  
The reasoning is easy, once you had a colleague (or you yourself have to live) with impaired visuals: when using any kind of zoom function, you can easily descrease the "tab size" (roughly: "how many pace's space should a tab take?"), but you cannot _easily_ reduce the amount of space at the beginning of each and every line.  
If it would be up to me, I would just implement fibonacci indentation with tabs as mandatory, everywhere.
