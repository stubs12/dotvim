#!/bin/bash

# Configuration - Change these to match your file names
MAIN_BUNDLE="my-repo.bundle"
TARGET_DIR="my-project-restored"
BUNDLE_DIR=$(pwd)

echo "--- Step 1: Cloning Main Repository ---"
git clone "$MAIN_BUNDLE" "$TARGET_DIR"
cd "$TARGET_DIR" || exit

echo "--- Step 2: Initializing Submodules ---"
git submodule init

# Get the list of submodule paths from the local .gitmodules file
submodule_paths=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

echo "--- Step 3: Re-linking Submodules to Local Bundles ---"
for sm_path in $submodule_paths; do
    # Replace slashes with underscores to match the Windows script's naming convention
    bundle_name="${sm_path//[\/\\]/_}.bundle"
    bundle_full_path="$BUNDLE_DIR/$bundle_name"

    if [ -f "$bundle_full_path" ]; then
        echo "Linking $sm_path to $bundle_full_path"
        # Update the git config to point to the local file instead of a URL
        git config "submodule.$sm_path.url" "$bundle_full_path"
    else
        echo "Warning: Bundle for $sm_path not found at $bundle_full_path"
    fi
done

echo "--- Step 4: Updating Submodules from Bundles ---"
git submodule update

echo "--- Done! Repository restored offline. ---"

