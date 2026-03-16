#!/bin/bash

# --- Update these to match your actual file names ---
MAIN_BUNDLE="dotvim.bundle"      # Matches the folder name in your screenshot
TARGET_DIR="dotvim"              # The folder name you want on Linux
BUNDLE_DIR=$(pwd)                # Assumes script is run from the transfer folder

echo "--- Step 1: Cloning Main Repository ---"
git clone "$MAIN_BUNDLE" "$TARGET_DIR"
cd "$TARGET_DIR" || exit

echo "--- Step 2: Initializing Submodules ---"
git submodule init

# This extracts the paths like 'pack/dist/start/fugitive.vim'
submodule_paths=$(git config --file .gitmodules --get-regexp path | awk '{ print $2 }')

echo "--- Step 3: Re-linking Submodules to Local Bundles ---"
for sm_path in $submodule_paths; do
    # This matches the PowerShell logic: pack/dist/start/fugitive.vim -> pack_dist_start_fugitive.vim.bundle
    bundle_name="${sm_path//[\/\\]/_}.bundle"
    bundle_full_path="$BUNDLE_DIR/$bundle_name"

    if [ -f "$bundle_full_path" ]; then
        echo "Linking $sm_path to $bundle_full_path"
        git config "submodule.$sm_path.url" "$bundle_full_path"
    else
        echo "Warning: Bundle not found: $bundle_full_path"
    fi
done

echo "--- Step 4: Updating Submodules from Bundles ---"
# The --no-fetch flag tells git to rely entirely on the local bundle file
git submodule update --no-fetch

echo "--- Done! Repository restored offline. ---"
