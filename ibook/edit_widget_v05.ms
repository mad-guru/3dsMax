dir_ary=getDirectories @"f:\unedited\gul*.wdgt"
for cur_dir in dir_ary do
(
cur_file=(getfiles(cur_dir+@"gul*.wdgt.html"))[1]
cur_filename_str=filenamefrompath cur_file
cur_fileb=(getfiles(cur_dir+"Info.plist"))[1]
	
pg_str=substring cur_filename_str 1 (cur_filename_str.count-10)
pg_strb=substituteString pg_str "_" ""

add_str="<!DOCTYPE html>
<html>
  <head>
	<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />
	<meta http-equiv=\"X-UA-Compatible\" content=\"chrome=1,IE=9\" />
	<meta name=\"viewport\" content=\"user-scalable=yes, width=1012\" />
	<title>"+pg_str+"</title>
	<style>
		body {
			background-color: #000000;
			margin: 0px;
		}
	</style>

<script type=\"text/javascript\">
      widget.pauseAudioVisual = function() {
        HYPE.documents[\""+pg_str+".wdgt\"].showSceneNamed(\"quiet\");
      };

      widget.didEnterWidgetMode = function() {
        HYPE.documents[\""+pg_str+".wdgt\"].showSceneNamed(\""+pg_str+"\");
      };
    </script>

<script type=\"text//javascript\" src=\"AppleClasses//AppleWidget.js\"> </script>
<script type=\"text//javascript\">
window.onload = function ()
{
widget.notifyContentIsReady();
}
</script>

  </head>
  <body>
	<div style =\"margin:auto;width:1012px\">


	
	<!-- copy these lines to your document: -->

	<div id=\""+pg_strb+"_hype_container\" style=\"position:relative;overflow:hidden;width:1012px;height:680px;\">
		<script type=\"text/javascript\" charset=\"utf-8\" src=\""+pg_str+".wdgt_Resources/"+pg_strb+"_hype_generated_script.js?20626\"></script>
	</div>

	<!-- end copy -->
	


	</div>
  </body>
</html>"

add_strb="
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-////Apple////DTD PLIST 1.0////EN\" \"http:////www.apple.com//DTDs//PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
	<key>AllowNetworkAccess</key>
	<true/>
	<key>IBNotifiesOnReady</key>
	<true/>
	<key>CFBundleDevelopmentRegion</key>
	<string>English</string>
	<key>CFBundleDisplayName</key>
	<string>"+pg_str+"</string>
	<key>CFBundleIdentifier</key>
	<string>com.tumult.hype.widget."+pg_strb+"</string>
	<key>CFBundleName</key>
	<string>"+pg_str+"</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1.0</string>
	<key>Height</key>
	<string>680</string>
	<key>MainHTML</key>
	<string>"+pg_str+".wdgt.html</string>
	<key>Width</key>
	<string>1012</string>
</dict>
</plist>
"
cur_html = openfile cur_file mode: "w+"
format add_str to: cur_html
flush cur_html
close cur_html

cur_plist = openfile cur_fileb mode: "w+"
format add_strb to: cur_plist
flush cur_plist
close cur_plist

src_file=(getfiles (cur_dir+pg_str+@".wdgt_Resources\*jpg"))[1]
cur_src=openBitmap @"f:\unedited\Default.png"
cur_png=copy cur_src
cur_png.filename=(cur_dir+"Default.png")
save cur_png
	
/*
--takes first image and saves Default.png
jpg_file=(getfiles (cur_dir+pg_str+@".wdgt_Resources\*jpg"))[1]
cur_jpg=openBitmap jpg_file
cur_png=copy cur_jpg
cur_png.filename=(cur_dir+"Default.png")
save cur_png
*/
)
/*
HiddenDOSCommand <command string to execute> [  startpath:unsupplied] [  prompt:unsupplied] [  donotwait:false] [  ExitCode:&variable] 

rar <command> -<switch 1> -<switch N> <archive> <files...>
               <@listfiles...> <path_to_extract\>
			   
			   
fileopen etc

cur_file
skipToString cur_file "</style>"

pg_str

add_str="
<script type=\"text/javascript\">
      widget.pauseAudioVisual = function() {
        HYPE.documents[\""+pg_str+"\"].showSceneNamed(\"quiet\");
      };

      widget.didEnterWidgetMode = function() {
        HYPE.documents[\""+pg_str+".wdgt\"].showSceneNamed(\""+pg_str+"\");
      };
    </script>
"

--open the first jpg

-- copy it so you can write the copy
<bitmap>copy <bitmap> 

--rename copy
<bitmap>.filename="addpathhere/Default.png" --add path too?

save copy as a file
<bool>save <bitmap> [frame:<integer>][quiet:<bool>] 









F:\gul_page01.wdgt

*/