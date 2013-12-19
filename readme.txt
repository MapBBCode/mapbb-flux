##
##
##        Mod title:  MapBBCode
##
##      Mod version:  1.0.0
##  Works on FluxBB:  1.4.8, 1.5.5
##     Release date:  2013-12-15
##      Review date:  YYYY-MM-DD (Leave unedited)
##           Author:  Ilya Zverev (zverik@textual.ru)
##
##      Description:  This mod adds maps to a forum, using MapBBCode library.
##                    Supported toolbar mods: Easy BBCode, FluxToolbar,
##                    EZBBC Toolbar (last one is untested).
##
##   Repository URL:  http://fluxbb.org/resources/mods/xxx (Leave unedited)
##
##   Affected files:  header.php
##                    include/parser.php
##                    mod_easy_bbcode.php (for Easy BBCode mod)
##                    plugins/ezbbc/ezbbc_head.php (for EZBBC Toolbar mod)
##                    plugins/ezbbc/style/Default/ezbbc.css (for EZBBC Toolbar mod)
##                    include/toolbar_func.js (for FluxToolbar mod)
##
##       Affects DB:  No
##
##       DISCLAIMER:  Please note that "mods" are not officially supported by
##                    FluxBB. Installation of this modification is done at 
##                    your own risk. Backup your forum database and any and
##                    all applicable files before proceeding.
##
##


#
#---------[ 1. UPLOAD ]-------------------------------------------------------
# copy ezbbc and fluxtoolbar files only if you have those modifications installed
#

files/include/mapbbcode/* to include/mapbbcode/
files/plugins/ezbbc/style/Default/images/map.png to plugins/ezbbc/style/Default/images/map.png
files/img/fluxtoolbar/smooth/bt_map.png to img/fluxtoolbar/smooth/bt_map.png

#
#---------[ 2. OPEN ]---------------------------------------------------------
#

header.php

#
#---------[ 3. FIND (line: 87) ]---------------------------------------------
#

<link rel="stylesheet" type="text/css" href="style/<?php echo $pun_user['style'].'.css' ?>" />

#
#---------[ 4. AFTER, ADD ]-------------------------------------------------
#

<script type="text/javascript" src="include/mapbbcode/MapBBCodeLoader.min.js"></script>
<script type="text/javascript">mapBBCodeLoaderOptions.set({
	path: "include/mapbbcode/",
	language: "<?php echo $lang_common['lang_identifier'] ?>"
});</script>

#
#---------[ 5. OPEN ]---------------------------------------------------------
#

include/parser.php

#
#---------[ 6. FIND (line: 226) ]---------------------------------------------
#

	$open_tags = array('fluxbb-bbcode');

#
#---------[ 7. BEFORE, ADD ]-------------------------------------------------
#

	array_push($tags, 'map', 'mapid');
	array_push($tags_opened, 'map', 'mapid');
	array_push($tags_closed, 'map', 'mapid');
	array_push($tags_block, 'map', 'mapid');
	array_push($tags_trim, 'map', 'mapid');
	$tags_quotes[] = 'map';
	$tags_inline[] = 'mapid';
	$tags_limit_bbcode['mapid'] = array();

#
#---------[ 8. FIND (line: 777) ]---------------------------------------------------------
#

	$pattern[] = '%\[b\](.*?)\[/b\]%ms';

#
#---------[ 9. BEFORE, ADD ]---------------------------------------------
#

	$pattern[] = '%\[map(=[0-9,.]+)?\](.+?)\[/map\]%ms';
	$pattern[] = '%\[mapid\]([a-z]+)\[/mapid\]%';
	$replace[] = '<div class="mapbbcode" map="$1">$2</div>';
	$replace[] = '<div class="mapbbcode_shared">$1</div>';

#
# (for Easy BBCode modification)
#---------[ 10. OPEN ]---------------------------------------------------------
#

mod_easy_bbcode.php

#
#---------[ 11. FIND (line: 111) ]---------------------------------------------
#

							<input type="button" value="IMG" name="IMG" onclick="insert_text('[img]','[/img]')" />

#
#---------[ 12. AFTER, ADD ]-------------------------------------------------
#

							<input type="button" value="MAP" name="MAP" class="mapbbcode_edit" />

#
# (for EZBBC Toolbar modification)
#---------[ 13. OPEN ]---------------------------------------------------------
#

plugins/ezbbc/ezbbc_head.php

#
#---------[ 14. FIND (line: 332) ]---------------------------------------------
#

	<?php if ($pun_config['p_message_img_tag'] == '1' && $ezbbc_config['img'] == 'img'): ?>

#
#---------[ 15. AFTER, ADD ]-------------------------------------------------
#

	toolbar += '<a href="#" id="mapbb" title="Edit a map" class="mapbbcode_edit"><span>Map<\/span><\/a>';

#
#---------[ 16. OPEN ]---------------------------------------------------------
# repeat this for all styles used, and copy plugins/ezbbc/style/Default/images/map.png to all style directories
#

plugins/ezbbc/style/Default/ezbbc.css

#
#---------[ 17. FIND (line: 76) ]---------------------------------------------
#

#ezbbctoolbar a#image {

#
#---------[ 18. BEFORE, ADD ]-------------------------------------------------
#

#ezbbctoolbar a#mapbb {
    background: url(images/map.png) no-repeat 0 0;
}

#
# (for FluxToolbar modification)
#---------[ 19. OPEN ]---------------------------------------------------------
#

include/toolbar_func.js

#
#---------[ 20. FIND (line: 202) ]---------------------------------------------
#

		addButton(img, label, function() { singleTag(tag) });
	}

#
#---------[ 21. REPLACE WITH ]-------------------------------------------------
#

		if( tag === 'map' ) btMap(img, label); else
		addButton(img, label, function() { singleTag(tag) });
	}

	function btMap(src, title)
	{
		var i = document.createElement('img');
		i.id = 'but_' + numbut;
		i.src = bt_img_path + src;
		i.title = title.replace(/&quot;/g, '"');
		i.tabIndex = 400;
		i.style.padding = '0 5px 0 0';
		var li = document.createElement('a');
		li.className = 'mapbbcode_edit';
		li.appendChild(i);
		toolbar.appendChild(li);
		tabbut[numbut] = function() { singleTag('map') };
		numbut++;
	}

#
#---------[ 22. ACTION ]--------------------------------------------------
#

Open FluxToolbar panel in Administration page.
Click "Create new tag / Add or remove button image" at the bottom of the page.
Type:
 - Name: map
 - Button image: bt_map.png
 - BBCode Tag: map
 - Function: 0
 - Position: 18
Click "Save".

#
#---------[ 23. SAVE/UPLOAD ]--------------------------------------------------
#
