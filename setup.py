import sys
import os
import shutil
import json
import errno

SUBSTITUTION_TAG = "<<<<%s>>>>"
HOME = os.environ['HOME']
PROFILE_FILE = 'profiles.json'

def log(message, tabs=0):
    print '    ' * tabs + message

def create_directories(module_name, module):
    """ Create directories necessary for program (including directories for files)"""
    for directory in module["directories"]:
        path = os.path.join(HOME, directory)

        try:
            os.makedirs(path)
            log("Creating %s/" % path, tabs=1)

        except OSError as e:
            if e.errno != errno.EEXIST:
                raise

def copy_files(module_name, module):
    """ Copy over the configuration files """
    for path in module["files"]:
        destination = os.path.join(HOME, path)

        destination_dir = os.path.dirname(destination)

        try:
            os.makedirs(destination_dir)

        except OSError as e:
            if e.errno != errno.EEXIST:
                raise

        try:
            shutil.copyfile(
                os.path.join(module_name, path),
                os.path.join(destination)
            )

            log("Copying %s to %s" % (os.path.join(module_name, path), destination), tabs=1)

        except shutil.Error, e:
            pass

def make_substitutions(module_name, module, current_os):
    """ Fill in OS-specific content """
    for source, substitutions in module["substitutions"].items():
        path = os.path.join(HOME, source)

        log("Editing " + path, tabs=1)

        with open(path, 'r') as read_file:
            contents = read_file.read()

        for tag_name, substitution in substitutions.items():
            replacement = substitution[current_os]
            contents = contents.replace(str(SUBSTITUTION_TAG % tag_name), str(replacement))

        with open(path, 'w') as write_file:
            write_file.write(contents)

def deploy(modules, current_os):
    """ Make all changes """

    for module_name, module in modules.items():
        log(module_name)

        if "directories" in module:
            create_directories(module_name, module)

        copy_files(module_name, module)

        if "substitutions" in module:
            make_substitutions(module_name, module, current_os)

def usage():
    print "Usage: %s {osx|linux}" % sys.argv[0]
    exit(1)
        
def main():
    if len(sys.argv) != 2:
        usage()
    if sys.argv[1] not in ('osx', 'linux'):
        usage()

    deploy(
        json.load(open(PROFILE_FILE, 'r')),
        sys.argv[1]
    )

main()
