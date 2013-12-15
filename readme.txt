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
##                    Easy BBCode mod is supported, instructions for other
##                    toolbar mods is in separate files.
##
##   Repository URL:  http://fluxbb.org/resources/mods/xxx (Leave unedited)
##
##   Affected files:  header.php
##                    include/parser.php
##                    mod_easy_bbcode.php (for Easy BBCode mod)
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
#

files/mapbbcode/* to mapbbcode/

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

<script type="text/javascript" src="mapbbcode/MapBBCodeLoader.min.js"></script>
<script type="text/javascript">mapBBCodeLoaderOptions.set({
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
#---------[ 10. OPEN ]---------------------------------------------------------
# (for Easy BBCode modification)
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
#---------[ 13. SAVE/UPLOAD ]--------------------------------------------------
#
