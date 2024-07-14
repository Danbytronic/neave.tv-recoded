function contextHandler(o, item)
{
   var _loc1_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
   switch(item.caption)
   {
      case cm.customItems[0].caption:
         video_mc.stopVideo();
         getURL(_loc1_.link,"_blank");
         break;
      case cm.customItems[1].caption:
         video_mc.stopVideo();
         getURL(_loc1_.flvLink,"_blank");
         break;
      case cm.customItems[2].caption:
         if(videoStopped)
         {
            video_mc.loadVideo(video_mc.num);
         }
         else
         {
            video_mc.pauseVideo(!videoPaused);
         }
         break;
      case cm.customItems[3].caption:
         video_mc.toggleFullScreen();
         break;
      case cm.customItems[4].caption:
         video_mc.stopVideo();
         getUrl("http://www.neave.com/", "_top");
   }
}
function menuHandler(o, item)
{
   mouse_mc.context = true;
   for(var _loc2_ in cm.customItems)
   {
      cm.customItems[_loc2_].visible = !introShow;
   }
   if(!introShow)
   {
      cm.customItems[2].caption = !videoPaused ? "Pause TV" : "Unpause TV";
      cm.customItems[2].enabled = !strapline_mc.paused || videoPaused;
      cm.customItems[3].caption = !fullScreen ? "Watch in full-screen" : "Watch in small-screen";
      if(tvList.length > 0)
      {
         var _loc1_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
         if(cm.customItems[0].visible = _loc1_.linkBasic.length > 0)
         {
            cm.customItems[0].caption = "Go to " + _loc1_.linkBasic;
         }
         if(cm.customItems[1].visible = _loc1_.flvHost.length > 0)
         {
            cm.customItems[1].caption = strapline_mc.HOST + _loc1_.flvHost;
         }
      }
   }
}
var hash = _level0.hash;
var cm = new ContextMenu(menuHandler);
cm.hideBuiltInItems();
cm.customItems = new Array(new ContextMenuItem("Go to ",contextHandler),new ContextMenuItem(strapline_mc.HOST,contextHandler),new ContextMenuItem("Pause TV",contextHandler),new ContextMenuItem("Watch in small-screen",contextHandler),new ContextMenuItem("Go to Neave.com",contextHandler));
cm.customItems[2].separatorBefore = true;
cm.customItems[0].visible = cm.customItems[1].visible = false;
_level1.menu = _level0.menu = cm;
