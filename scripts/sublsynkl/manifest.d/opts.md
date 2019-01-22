# options-extract-description
Extract packages default setting files to **$SUBLIME_DIR/Packages**.

# options-blank-description
Blank extracted default files. (only have effect if `--extract` is used)

# options-sync-description
Sync files in *PACKAGE_DIRECTORY* with files in **$SUBLIME_DIR/Packages**.
Works both ways, the newest file will overwrite the oldest.

# options-force-description
Force files from PACKAGE_DIRECTORY to overwrite,
no matter if target file exists (when used with `--packages`) 
or is newer (when used with `--sync`).

# options-clean-description
Clean install. Move the current **$SUBLIME_DIR/Packages** to *$SUBLIME_DIR/backup* before any other operations.  

# options-packages-description
Copy files withing *PACKAGE_DIRECTORY* before any other operations.  


# options-version-description
Show version and exit.

# options-help-description
Show help and exit.
