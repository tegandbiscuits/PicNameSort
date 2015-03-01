#PicNameSort
PicNameSort is a script utility to change the file name for pictures to sort them, and help identify them.

Say you have a folder of pictures with names like "IMG_0281.jpg".
It keeps them in sequential order, but it's not very descriptive.
What PicNameSort does is grabs the date the picture was taken, then changes the file name to the date.

The date format based on ISO format, and would look like "2014-03-06_14-12-39.jpg".
This keeps your pictures in sequential order, can help you identify the picture, and also would retain the date if a copy loses the date in the metadata.

If there's already a file with the same name as the picture then the name of the file will be the same, but with "_X" added to it, where X is the lowest number that makes it original (i.e. "2014-03-06_14-12-39_1.jpg")

PicNameSort also creates a file called "Picture-Descriptions.txt", which will have the new names of your pictures in it.
Note that if a file named Picture-Descriptions.txt already exists in the same directory, it won't be erased, but will be appended.

**WARNING:** Back up your pictures, and make sure they all made it!
PicNameSort does its should not overwrite pictures, and should just move on if there's an error making a new name or copying a file.
It will also make a folder with copies of your pictures just in case.
But you should still verify came out right before deleting the backups.

**Note:** There's a small glitch where if you use PicNameSort on a picture with the same name as it would become, then it will be changed to the "_X" format.
This should still be safe for you pictures.


##How to use
###Dependencies
PicNameSort is fairly simple to use.
It depends on Bash, and <a href="http://owl.phy.queensu.ca/~phil/exiftool/">ExifTool</a> being installed.
For the AppleScript wrapper, ExifTool needs to be installed in the default path\*.
The ExifTool installer and installing through Homebrew will both be fine.

Because it uses Bash, it'll be a bit trickier to get it to work with Windows.

###Command Line
Usage for the command line version looks like this:

`$ ./PicNameSort.sh [path]`

Path can be the path to a single image or a directory.
A directory path isn't recursive, and only does images at that level.

PicNameSort uses ExifTool to check if the file is an image, and wont attempt to convert images without a mimetype that doesn't include "image".

To update use the `--update` flag instead of a path.
This checks the current version on GitHub, and will download and replace PicNameSort.sh if it's a lower version.

###AppleScript App
The AppleScript version is essentially just an interface for the command line version.
It can be easier to use for someone who'd rather use a GUI instead of a terminal

> If you downloaded just the source, then you'll need to compile the app yourself.
> This is easily done by running `./PrepApp.sh`.
> Developers: this needs to be done if you're working with the .app.

The app was made to be pretty self explanatory.
To use it, launch the PicNameSort.app, then select if you want to rename a single picture or all the pictures in a folder.
If you select a folder, then it will only format the pictures at that level.
It won't touch any files in a subfolder.

The clicking the more button shows a small blurb with some more options.
There's a quit button (other ways to quit also exist), and an update button.
A small problem with the update is that it only updates the script, not the app.
Meaning if something on the interface changes, it wont be updated through this.
On the bright side, the interface will probably never be updated.

You wont see anything while it's working, but when it's done you'll have the option to see the output log, rename more pictures, or quit.

The output log is what you would see if you would see if you were running this through the command line.
If everything works right, you won't really need to bother with it.

\* Default path is `/usr/local/bin`, `/usr/bin`, `/bin`, `/usr/sbin/`, `/sbin`


##Contributing and Help
If you have any problems then open a request on GitHub.

If you have any code contributions then feel free to submit a pull request.


##License
Copyright (c) 2015 Nate Rauh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
