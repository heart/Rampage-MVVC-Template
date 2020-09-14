DEST_PATH="$HOME/Library/Developer/Xcode/Templates"
FILE_TEMPLATE_PATH="File Templates"

if [[ ! -e $DEST_PATH ]]; then
    echo "Error $DEST_PATH not exists maybe you not install xcode yet." 1>&2
elif [[ ! -d $dir ]]; then
    mkdir -p "$DEST_PATH/$FILE_TEMPLATE_PATH"
    cp -R RPMVVM.xctemplate "$DEST_PATH/$FILE_TEMPLATE_PATH"
    echo "Install success!"
fi