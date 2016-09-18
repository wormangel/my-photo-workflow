# my-photo-workflow
Description of my usual workflow for storing, organizing and backing up my personal photo/video collection.

## Vision
To build the perfect personal memories album, by taking advantage of the digital tools we have today.
To achieve this goal, the collection must be:

0. **Personal**: Aggregating everything that's **relevant** to me - not only photos I take but also photos people taken of me, photos of moments I was in, photos from ancestors and photos from dear people - everything that's part of my history.
1. **Complete**: Containing **every picture or video** I can put my hands on, from the past (by scanning old photos or scavenging old hard drives) to the future (by defining a process in which I can make sure any content produced from now on will be part of the collection).
2. **Chronological**: Making sure that every item in the collection is in its correct place in history, **date and time**.
3. **Contextual**: Being organized by **recognizable moments** and providing means of **searching** for people, places, events, things, details.
4. **Presentable**: Avoiding the tedious 'directories-and-files' approach by allowing for a navigation that focus on the media itself - a **scrollable timeline of moments**.
5. **Shareable**: Giving means for **easily sharing** the moments that may be relevant to others - as well as **avoiding the exposure of the things that are private**.

## My media sources
- Photos and videos taken with iPhone 6S (usual setup: HDR on; LivePhotos on; Videos 1080p @ 60fps)
- Videos taken with the GoPro HERO 3 Black (various settings)
- Scans of old photos
- Photos and videos found around old hard drives, the internet, etc

## The core process
1. **Cloud Repository/Backup**: Photos are uploaded automatically to some cloud storage so the phone is not the single point of failure anymore.
2. **Staging**: Some app is used to import the photos and split then into events. At this point any needed fix is done (specially timestamp ones).
3. **Archiving**: The event is saved to a definitive location in the cloud storage (and whatever other backup mechanism)

## Choice of software
 1. **Cloud Repository/Backup**: Dropbox Camera Upload
 2. **Staging**: iPhoto 9.6.4 (plus some scripts found in this repository)
 3. **Archiving**: Dropbox  (premim account with 1TB storage)
 
## The process outline
1. **Cloud Repository/Backup**
* Let Dropbox upload the pictures from the iPhone to `Camera Uploads`
* Manually grab the LivePhotos' videos and put them in `Camera Uploads`
2. **Staging**
3. **Archiving**

## The process in detail
 1. **Cloud Repository/Backup**
 
 * Dropbox puts the pictures inside a `Camera Uploads` folder, no subdirectories
 * Instead of the regular `IMG_xyz.jpg` naming system used by iPhone, the images get stored with a timestamp format: `yyyy-mm-dd hh.mm.ss`. **I think** this comes from the EXIF of the image and falls back to the upload date if needed. Dropbox takes care of appending some extras to the filename to identify different versions of the picture:
  * The regular picture: `yyyy-mm-dd hh.mm.ss.jpg`
  * The Instagram version: `yyyy-mm-dd hh.mm.ss-1.jpg`
  * The HDR version: `yyyy-mm-dd hh.mm.ss HDR.jpg`
  * Movies: `yyyy-mm-dd hh.mm.ss.mov`
  * Screenshots: `yyyy-mm-dd hh.mm.ss.png`
 * Dropbox still lacks support for iPhone's LivePhotos, so a manual process is needed:
  * Connect the iPhone to the Macbook and launch `Image Capture`
  * The LivePhotos are actually a pair of an image and a video file, saved with the same `IMG_xyz` name in the iPhone, only differing by extension (jpg/mov). So the idea is to visually identify the LivePhotos by scrolling the list (sorted by filenmae), paying attention to the repeated entries, selecting all the video ones (they are usually around 3 MB, keeping that in mind helps doing this process more efficiently) and importing them to some folder. I use `~/_TMP/livephotos`. Since I don't delete pictures from the iPhone very often, I keep track of where I stopped last time by leaving the last two files in that folder always, so when I do a new import I only look for LivePhotos taken after that point.
  * The image files will also be imported, so the folder will have both JPG and MOV files, with the default `IMG_xyz` names. We can't simply drop them in the Dropbox folder otherwise we will have duplicate pictures (remember Dropbox already imported the image file for the LivePhotos). We could simply copy the MOV files but they would be in the wrong filename format. In order to fix that, I use this software called `DupeGuru` to find duplicates between two folders. Launch it, choose the `Camera Uploads` folder and the LivePhotos staging folder and fire it: it should match exactly half of the files in the LivePhotos folder (the pictures, not the videos). Now to rename them, DupeGuru offers this nice feature of exporting a CSV with information about the duplicates found. I serve that to a Ruby script of mine that takes care of renaming both the images and videos files in the LivePhotos staging folder to the proper names found in the Dropbox folder. Then we can move the videos to `Camera Upload` and delete the images (remember to leave the last ones so you can start from where you left off the next time you need to do that).

### TODO

- Detail the workflow
- Upload the ruby scripts
- Point the drawbacks (not really contextual yet, etc)
- Revisit history of this process (Photo Stream, etc)
