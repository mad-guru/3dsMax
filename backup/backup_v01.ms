root=@"D:\projects\pd\"
dir_ary = GetDirectories (root + "\\*")
for d in dir_ary do
(
join dir_ary (getDirectories (d + "\\*"))
)
--print dir_ary
--append dir_ary  (root + "\\") -- Need to include the original top level directory
	
	
for num in 1 to dir_ary.count do
(
cur_dir=dir_ary[num]
--if (findString (cur_dir as string) "archive")!=undefined then
	(
	str_command=("C:\\\"Program Files\"\\WinRAR\\rar.exe a -df "+ cur_dir+"files.rar *.* "+cur_dir)
	DosCommand str_command
	--print cur_dir
	)
)


