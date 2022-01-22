import os
import sys
import glob
import time
from CombineCommon import *

#================================================
def main():

	rc = 0

	#ffmpeg supports several video file extensions
	ext = "mp4"

	#get list of files in this directory then sort it
	files = glob.glob("*." + ext)
	files.sort(key=lambda x: os.path.splitext(x)[0])

	rc = Combine(files, ext)

	return rc

#================================================
if __name__ == "__main__":
	rc = main()
	sys.exit(rc)