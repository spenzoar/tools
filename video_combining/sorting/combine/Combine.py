import os
import sys
import glob
import time
import subprocess


#================================================
def Combine(files, ext):

	rc = 0

	#keep empty for autoname based on date
	output_file_name = ""

	file_list_name = "temp.txt"
	file_list = open(file_list_name, "a", encoding="utf8")
	file_names = []

	for file in files:
			
			if(len(output_file_name) == 0):
				timestamp = os.path.getctime(file)
				output_file_name = time.strftime("%Y-%m-%d", time.localtime(timestamp))
			
			#seems to work better to ffmpeg each file before combining them
			#ffmpeg -i "concat:%IN_FILE_5%.%EXT%" -c copy %IN_FILE_5%-temp.%EXT%
			pre, e = os.path.splitext(file)
			temp_name = pre + "-temp." + ext
			subprocess.call([
				"ffmpeg",
				"-i",
				file,
				"-c",
				"copy",
				temp_name,
			])
			
			file_list.write("file " + temp_name + "\n")
			file_names.append(temp_name)

	#done writing the list to file. close before passing to ffmpeg.	
	file_list.close()

	#combine the file into single file
	subprocess.call([
				"ffmpeg",
				"-f", "concat",
				"-safe", "0",
				"-i", file_list_name,
				"-c", "copy",
				output_file_name + "." + ext,
			])

	#cleanup
	os.remove("temp.txt")
	for name in file_names:
		os.remove(name)

	return rc

#================================================
def SortByCreated(files):
	files.sort(key=lambda x: os.path.getctime(x))

#================================================
def SortByModified(files):
	files.sort(key=lambda x: os.path.getmtime(x))

#================================================
def SortByName(files):
	files.sort(key=lambda x: os.path.splitext(x)[0])

#================================================
def SortByChunklist(files):

	file_dict = dict()

	for file in files:

		#left-most index of the substring otherwise -1
		start_index = file.find("w") + 1
		stop_index  = file.find("b") - 1

		#convert chunklist to number and use as key for the dictionary
		chunk_num = int(file[start_index:stop_index])
		if chunk_num in file_dict:
			file_dict[chunk_num].append(file)
		else:
			file_dict[chunk_num] = [file]

	#check results of the built dictionary
	for key in file_dict:
		print(key)
		for file in file_dict[key]:
			print("\t" + file)

	return file_dict

#================================================
def main():

	rc = 0

	#ffmpeg supports several video file extensions
	ext = "mp4"
	files = glob.glob("*." + ext)

	#change depending on how video sequence should be determined
	SortByCreated(files)

	rc = Combine(files, ext)

	return rc

#================================================
if __name__ == "__main__":
	rc = main()
	sys.exit(rc)