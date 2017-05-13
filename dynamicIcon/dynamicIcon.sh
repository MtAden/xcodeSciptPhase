# This script create the icon as per need 
# Used case is sending the DEBUG build internally to the team where Icon clear says in bold that its debug build 

# Prerequsites for this script to work : 
# Homebrew : https://brew.sh/
# Homebew package : ImageMagick 
# To install :  brew install ImageMagick
# Debug image : 


echo "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
echo "${SRCROOT}"
buildNumber=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" "${PROJECT_DIR}/${INFOPLIST_FILE}")

PATH=${PATH}:/usr/local/bin
IFS=$'\n'

function generateIcon () {
    BASE_IMAGE_NAME=$1
    PACKAGE_IMAGE_NAME=$2
    
    TARGET_PATH="${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${PACKAGE_IMAGE_NAME}"
    BASE_IMAGE_PATH=$(find ${SRCROOT} -name ${BASE_IMAGE_NAME})
    
    WIDTH=$(identify -format %w ${BASE_IMAGE_PATH})
    FONT_SIZE=$(echo "$WIDTH * .15" | bc -l)
    
    convert DebugLabel.png -resize $WIDTHx$WIDTH resizedDebugLabel.png
    convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize $FONT_SIZE -gravity south -annotate 0 $buildNumber - | composite resizedDebugLabel.png - ${TARGET_PATH}
    echo "convert response"
    echo $?
}

# first param is the actual image name in your  assets
# All numbered images 180,76 ... should be replaced to with there actual name inside of your project. 
# Please remember that they are actual name not name in xcasset file. location these file on the disk to get actual name

generateIcon "180.png" "AppIcon60x60@3x.png"
generateIcon "76.png" "AppIcon76x76~ipad.png"
generateIcon "152.png" "AppIcon76x76@2x~ipad.png"
generateIcon "58.png" "AppIcon29x29@2x.png"
generateIcon "58.png" "AppIcon29x29@2x~ipad.png"
generateIcon "87.png" "AppIcon29x29@3x.png"
generateIcon "29.png" "AppIcon29x29~ipad.png"
generateIcon "80.png" "AppIcon40x40@2x.png"
generateIcon "80.png" "AppIcon40x40@2x~ipad.png"
generateIcon "120.png" "AppIcon40x40@3x.png"
generateIcon "40.png" "AppIcon40x40~ipad.png"
generateIcon "120.png" "AppIcon60x60@2x.png"
generateIcon "167.png" "AppIcon83.5x83.5@2x~ipad.png"

