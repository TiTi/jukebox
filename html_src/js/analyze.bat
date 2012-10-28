@ECHO OFF

SET log=analyze.txt
DEL %log%

:: Download Ajax Minifier here: http://ajaxmin.codeplex.com/
SET ajaxmin="C:\Program Files (x86)\Microsoft\Microsoft Ajax Minifier\AjaxMin.exe"

:: Also checkout UglifyJS (require nodejs): https://github.com/mishoo/UglifyJS
:: Also checkout YUI Compressor: http://developer.yahoo.com/yui/compressor/

:: 1>NUL		Dismiss minification result
:: 2>>%log%		Add analysis infos to log

%ajaxmin% -analyze tab/tabs.js ^
	-global:$,Class,Element ^
	1>NUL 2>>%log%
%ajaxmin% -analyze tab/search.js ^
	-global:$,$$,$R,Class,Control,Tab,TableKit,Draggable,Element,genres,FormatTime,sort_unique ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze tab/upload.js ^
	-global:$,$$,JSON,qq,Class,Tab,TableKit,MusicFieldEditor,Notifications,genres,Element ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze tab/debug.js ^
	-global:$,Class,Tab,JsonPrettyPrint ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze tab/customQueries.js ^
	-global:$,Class,Tab,JSON,Notifications,Action,Query ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze tab/notification.js ^
	-global:$,Element,Notifications,Class,Tab ^
	1>NUL 2>>%log%%

%ajaxmin% -analyze genres.js 1>NUL 2>>%log%
%ajaxmin% -analyze tools.js -global:JSON 1>NUL 2>>%log%%
%ajaxmin% -analyze action.js -global:Extend 1>NUL 2>>%log%%
%ajaxmin% -analyze query.js -global:Action 1>NUL 2>>%log%%
%ajaxmin% -analyze notifications.js ^
	-global:$,Effect,Event ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze musicFieldEditor.js ^
	-global:$,$$,Event,TableKit,genres,genresOrdered ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze jukebox.js ^
	-global:Query,Ajax,Extend,Notifications,Action,JukeboxUI,Sound ^
	1>NUL 2>>%log%%
%ajaxmin% -analyze jukeboxUI.js ^
	-global:$,$$,$R,Control,Extend,Event,Element,Droppables,Draggable,Tabs,SearchTab,UploadTab,DebugTab,NotificationTab,CustomQueriesTab,FormatTime,genresOrdered ^
	1>NUL 2>>%log%%

:: Analyze the concatenated file generated by gruntjs
%ajaxmin% -analyze ../../html/js/jukebox.js ^
	-global:Ajax,Notifications,Sound,$,$$,$R,Effect,Element,Event,JSON,Draggable,Droppables,Control,Class,TableKit,qq ^
	1>NUL 2>>%log%%

:: Analyze the CSS
%ajaxmin% -analyze ../css/style.css 1>NUL 2>>%log%%

ECHO Analysis done in %log%