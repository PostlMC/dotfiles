# dotfiles

Q: What's all this junk?  
A: All the configuration files I want to keep in sync across my various systems.

## Setup

1. Add the names of files that shouldn't be symlinked in the **nolink** file
2. Execute `mklinks` to symlink everything else in `${HOME}` by default, or in the directory specified with the `-p`
flag if provided

Executing `mklinks -f ...` will overwrite any existing symlinks.

## Configuration

TODO: Write this part once all the pieces work
