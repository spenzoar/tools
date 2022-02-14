import os
import sys
import glob
import shutil
from combine import combine


#================================================
def main():

	rc = 0

	#ffmpeg supports several video file extensions
	ext = "mp4"
	files = glob.glob("*." + ext)
	
	#delete when know combine succeeded
	move_dir = "processed"
	if os.path.exists(move_dir):
		shutil.rmtree(move_dir)

	#create several output files based on matching chunklists
	file_dict = combine.DictionaryByChunklist(files)
	for key in file_dict:
		print(key)
		for file in file_dict[key]:
			print("\t" + file)

		rc = combine.Combine(file_dict[key], ext)
		if rc != 0:
			break

	return rc


#================================================
if __name__ == "__main__":
	try:
		rc = main()
		sys.exit(rc)
	except:
		sys.exit(69)