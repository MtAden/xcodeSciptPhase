#This script can be used as prior build phase script of dynamicIcons
#This script will check installation of brew and imagemagick. if they are not found then it will install them.

if ! type "brew" > /dev/null; then
   echo "[****] Didn’t find brew. Installing ..."
   /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
   echo "[****] brew is installed"
   if ! type "convert" > /dev/null; then
       echo "install ImageMagick with: brew install imagemagick"
       brew install imagemagick
   else
       if ! type "composite" > /dev/null; then
           echo "imagick installed, can run covnert and composite"
       else
           echo "something wrong with ImageMagick. please reinstall"
           ## Harsh news xcode project compilation would fail.
           ## comment exit below if you dont want your compilation to be failed
           exit 1  
       fi
   fi
fi