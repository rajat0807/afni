#!/bin/tcsh

#######################################################################
#
#   Build and push AFNI et al. documentation. Umcomment/comment as you
#   desire, and run using: 
#
#     $  sudo do_doc_build_and_copy.tcsh
#
#   A backup doc dir from the server can be removed later.
#
#######################################################################
setenv PYTHONPATH /home/ptaylor/afni_src/linux_ubuntu_12_64

set here = $PWD
set thedate = `date +%Y_%m_%d`
set backup_dir = htmldoc.auto_backup.$thedate

echo "Backup directory called: $backup_dir"

### Make preliminary stuff from helpfiles: will open both AFNI and SUMA
### this way
#tcsh @gen_all -phelp -suma -afni

# ---------------------------------
cd python_help_scripts

# Make list of All Program Helps
#python help2sphinx.py -OutFolder ../programs

echo "python path: $PYTHONPATH"

# Make classified/groupings stuff
set fieldfile = list_STYLED_NEW.txt
python convert_list_to_fields_pandas.py        \
    list_AFNI_PROGS_classed.txt                \
    $fieldfile
python convert_fields_to_rst.py                \
    $fieldfile                                 \
    ../educational/classified_progs.rst

# make AFNI startup tips RST
python make_file_of_startup_tips.py            \
    all_startup_tips.txt                       \
    ../educational/startup_tips.rst

cd ..
# ---------------------------------

### Build Sphinx.
sudo make html

### move old documentation to a backupdir
#mv  /mnt/afni/var/www/html/pub/dist/doc/htmldoc     \
#    /mnt/afni/var/www/html/pub/dist/doc/$backup_dir



### new documentation ----> slow to RSYNC!
sudo rsync -av --delete _build/html/                              \
    /mnt/afni/pub/dist/doc/htmldoc

# OLD
#rsync -av --delete _build/html/                              \
#    /mnt/afni/var/www/html/pub/dist/doc/htmldoc



exit



### make a tarball for the new documentation?  Is this really so much
### faster than rsync?
echo "++ Make tarball of directory"
cd _build/
tar -cf html.tar html/
gzip html.tar
echo "++ Copy the tarball to the AFNI server"
mv html.tar.gz /mnt/afni/var/www/html/pub/dist/doc/.
cd /mnt/afni/var/www/html/pub/dist/doc/
echo "++ Unwrap the tarball and put it in the right location (-> a couple min)"
tar -xf html.tar.gz
mv html htmldoc


### If all is well, can delete the backupdir
cat << EOF
    If all went well, which can be verified by checking and clicking 
    around on the website:

    firefox -new-window https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/index.html

    then you should be able to remove the backup directory:

        /mnt/afni/var/www/html/pub/dist/doc/$backup_dir

EOF
