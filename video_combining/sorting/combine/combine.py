import os
import sys
import time
import glob
import subprocess
import uuid
import shutil

#================================================
#check for VLC created file based on filename
def IsVLCFile(name):
	vlc = name.find("vlc-record")
	if vlc == -1:
		return False
	else:
		return True

#================================================
#return chunklist part of the filename
def GetChunklist(name):
	start_index = name.find("w") + 1
	stop_index  = name.find("b") - 1
	chunklist = name[start_index:stop_index]
	return chunklist

#================================================
#return timestamp part of the filename
def GetTimestamp(name):

	#parse VLC generated vs python generated files differently
	if IsVLCFile(name):
		start_index = name.find("d-") + 2
		stop_index = name.find("-c") - 2
	else:
		start_index = 0
		stop_index  = name.find("_") - 1

	timestamp =  name[start_index:stop_index]
	return timestamp


#================================================
def Combine(files, ext):

	rc = 0

	#if not combining or processing then skip everything
	if len(files) == 0:
		return rc
	if len(files) == 1 and not IsVLCFile(files[0]):
		return rc

	#use timestamp from the first file but chunklist from that last if stream has moved
	output_file_uuid = str(uuid.uuid4())
	output_file_name = GetTimestamp(files[0]) + "_w" + GetChunklist(files[-1]) + "_b" + "__" + output_file_uuid + "." + ext

	file_list_name = "temp.txt"
	file_list = open(file_list_name, "a", encoding="utf8")
	file_names = []

	for file in files:

		pre, e = os.path.splitext(file)
		temp_name = pre + "-temp." + ext

		#seems to work better to ffmpeg each file before combining them
		if IsVLCFile(file):
			subprocess.call([
				"ffmpeg",
				"-i",
				file,
				"-c",
				"copy",
				temp_name,
			])

		#just create temp copy if already gone through ffmpeg. assume this is faster?
		else:
			shutil.copyfile(file, temp_name)
		
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
				output_file_name,
			])

	#cleanup
	os.remove("temp.txt")
	for name in file_names:
		os.remove(name)

	#delete when know combine succeeded
	move_dir = "processed"
	if not os.path.exists(move_dir):
		os.mkdir(move_dir)
	for file in files:
		os.rename(file, move_dir + "/" + file)

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
def DictionaryByChunklist(files):

	file_dict = dict()

	for file in files:
		#convert chunklist to number and use as key for the dictionary
		chunk_num = int(GetChunklist(file))
		if chunk_num in file_dict:
			file_dict[chunk_num].append(file)
		else:
			file_dict[chunk_num] = [file]

	return file_dict

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

	#change depending on how video sequence should be determined. VLC prepends sortable timestamp.
	SortByName(files)
	rc = Combine(files, ext)

	return rc

#================================================
if __name__ == "__main__":
	try:
		rc = main()
		sys.exit(rc)
	except:
		sys.exit(69)