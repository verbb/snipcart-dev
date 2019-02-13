#!/bin/bash

# Require a parameter that points to the local plugin working copy.
if [[ $# -eq 0 ]] ; then
    echo 'Usage: sync-plugin path/to/plugin/folder'
    exit 1;
fi

# Get the path this script is running from, no matter where it's called.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Assume the parent *of this script* is our project folder.
PROJECT_DIR="$( cd "${SCRIPT_DIR}/../" ; pwd -P )"

# Change to the parent directory, step into the plugin project directory, and output the full path.
PLUGIN_SRC_DIR="$( cd ${1}; pwd -P )/"

if [ ! -d "$PLUGIN_SRC_DIR" ]; then
    echo "Plugin source directory doesn't exist: ${PLUGIN_SRC_DIR}";
    exit 1;
fi

TARGET_DIR="$PROJECT_DIR/plugin/"

# Make our target directory if it doesn't already exist.
if [[ ! -d "${TARGET_DIR}" ]] ; then
    mkdir -p "${TARGET_DIR}"
fi

run_rsync() {
    # Sync the plugin source into our target directory here.
    rsync -av $PLUGIN_SRC_DIR $TARGET_DIR --exclude 'vendor/' --exclude '.git/' --exclude 'node_modules/'
}

echo "Watching $PLUGIN_SRC_DIR, changes rsync → $TARGET_DIR..."

# Use fswatch to keep this running until a command+C
run_rsync; fswatch -or $PLUGIN_SRC_DIR | while read f; do run_rsync; done