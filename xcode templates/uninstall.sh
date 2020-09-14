DEST_PATH="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATE_PATH="File Templates"

if [[ ! -e $DEST_PATH ]]; then
    rm -rf "$DEST_PATH/$FILE_TEMPLATE_PATH/RPMVVM.xctemplate"
fi