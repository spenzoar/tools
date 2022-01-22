import os
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