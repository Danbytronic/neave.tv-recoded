function hideIntroMenu()
{
   mouse_mc.mt = 5;
   fadeMovieClip(menu_mc,0,100,-25);
}
stop();
bmp_mc.beep.stop();
delete bmp_mc.beep;
bmp_mc.mc = video_mc;
bmp_mc.bmp0.fillRect(bmp_mc.bmp0.rectangle,4278190080);
volume_mc.c = new Color(volume_mc);
tv_mc.c = new Color(tv_mc);
tv_mc.r = rnd() * 255;
tv_mc.g = rnd() * 255;
tv_mc.b = rnd() * 255;
tv_mc.s = 64;
tv_mc.n = 191;
tv_mc.colorTint = colorTint;
tv_mc.colorTint();
this.createEmptyMovieClip("dot_mc",this.getNextHighestDepth());
dot_mc.init = function(t, s)
{
   this.t = t;
   this.s = s;
   this.n = 0;
   this.mod = 0;
   this.up = true;
   this.onEnterFrame = this.dotHandler;
};
dot_mc.cancel = function()
{
   delete this.onEnterFrame;
};
dot_mc.dotHandler = function()
{
   this.mod = this.mod + 1;
   this.mod %= 2;
   if(this.mod > 0)
   {
      return undefined;
   }
   if(this.up)
   {
      this.n = this.n + 1;
      if(this.n > 2)
      {
         this.up = false;
      }
   }
   else
   {
      this.n = this.n - 1;
      if(this.n < 1)
      {
         this.up = true;
      }
   }
   var _loc3_ = "";
   var _loc2_ = this.n;
   while(true)
   {
      _loc2_;
      if(!_loc2_--)
      {
         break;
      }
      _loc3_ += ".";
   }
   this.t.htmlText = this.s + _loc3_;
};
strapline_mc._visible = true;
strapline_mc.VOLUME = "Press + or - to adjust volume";
strapline_mc.PAUSE = "Press Space Bar to pause TV";
strapline_mc.FULL = "Press \'F\' key to watch in ";
strapline_mc.WATCH = "You\'re watching ";
strapline_mc.LINK = "";
strapline_mc.COPYRIGHT = "Video created by ";
strapline_mc.HOST = "Video powered by ";
strapline_mc.PAUSED = "TV paused... Click or press Space Bar to resume";
strapline_mc.list = new Array("Creativity in a telly stylee","WATCH","LINK","COPYRIGHT","HOST","It\'s like television but nicer","Bobbins-free creativity","VOLUME","FULL","PAUSE","May contain scenes of a visual nature","You look lovely today, by the way");
strapline_mc.line_txt.condenseWhite = true;
dot_mc.init(strapline_mc.line_txt,":: Loading");
strapline_mc.num = 0;
strapline_mc.mod = 0;
strapline_mc.over = false;
strapline_mc.ts = new TextScrambler(strapline_mc.line_txt,5,20,false);
strapline_mc.ts.onComplete = function()
{
   strapline_btn._yscale = ceil((strapline_mc.line_txt.textWidth + 16) / 1.8);
};
strapline_mc.paused = true;
strapline_mc.showLine = function(str)
{
   dot_mc.cancel();
   this.ts.scramble(":: " + str);
};
strapline_mc.onEnterFrame = function()
{
   if(this.paused)
   {
      return undefined;
   }
   if(this.mod == 0)
   {
      var _loc2_ = this.list[this.num];
      strapline_btn.useHandCursor = false;
      var _loc3_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
      switch(_loc2_)
      {
         case "VOLUME":
            _loc2_ = this.VOLUME;
            break;
         case "PAUSE":
            _loc2_ = this.PAUSE;
            break;
         case "FULL":
            _loc2_ = this.FULL + (!fullScreen ? "full-screen" : "small-screen");
            break;
         case "WATCH":
            _loc2_ = this.WATCH + _loc3_.name;
            strapline_btn.useHandCursor = true;
            break;
         case "LINK":
            var _loc4_ = _loc3_.linkBasic;
            _loc2_ = this.LINK + _loc4_;
            if(_loc4_.length > 0)
            {
               strapline_btn.useHandCursor = true;
               break;
            }
            this.num = this.num + 1;
         case "COPYRIGHT":
            _loc4_ = _loc3_.copyright;
            _loc2_ = this.COPYRIGHT + _loc4_;
            if(_loc4_.length > 0)
            {
               strapline_btn.useHandCursor = true;
               break;
            }
            this.num = this.num + 1;
         case "HOST":
            _loc2_ = this.HOST + _loc3_.flvHost;
            strapline_btn.useHandCursor = true;
      }
      this.showLine(_loc2_);
      this.num = this.num + 1;
      this.num %= this.list.length;
   }
   this.mod = this.mod + 1;
   this.mod %= 120;
};
strapline_btn.onRollOver = function()
{
   strapline_mc.over = true;
};
strapline_btn.onRollOut = strapline_btn.onDragOut = function()
{
   strapline_mc.over = false;
};
strapline_btn.onRelease = function()
{
   if(strapline_mc.paused)
   {
      return undefined;
   }
   var _loc1_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
   switch(strapline_mc.num)
   {
      case 2:
      case 3:
      case 4:
         video_mc.stopVideo();
         getURL(_loc1_.link,"_blank");
         break;
      case 5:
         video_mc.stopVideo();
         getURL(_loc1_.flvLink,"_blank");
   }
};
strapline_btn.useHandCursor = false;
bufferMsg_mc._visible = false;
bufferMsg_mc.cont_btn.onRelease = function()
{
   fadeMovieClip(bufferMsg_mc,0,100,-25);
   if(!videoPaused)
   {
      video_mc.pauseVideo(false);
   }
};
bufferMsg_mc.next_btn.onRelease = function()
{
   fadeMovieClip(bufferMsg_mc,0,100,-25);
   video_mc.loadVideo(video_mc.num + 1);
};
var vol = new Object();
vol.timeoutID = 0;
vol.sound = new Sound();
vol.setVolume = function(v)
{
   if(v < 0)
   {
      v = 0;
   }
   if(v > 10)
   {
      v = 10;
   }
   var _loc2_ = 10;
   while(_loc2_ > 0)
   {
      volume_mc[_loc2_].w = _loc2_ <= v ? 10 : 1.5;
      volume_mc[_loc2_].onEnterFrame = this.barAdjuster;
      _loc2_ = _loc2_ - 1;
   }
   if(v > 4)
   {
      v -= 2;
      v *= 50;
   }
   else
   {
      v *= 25;
   }
   this.sound.setVolume(v);
};
vol.getVolume = function()
{
   var _loc2_ = this.sound.getVolume();
   if(_loc2_ > 100)
   {
      _loc2_ /= 50;
      _loc2_ += 2;
   }
   else
   {
      _loc2_ /= 25;
   }
   return _loc2_;
};
vol.barAdjuster = function()
{
   this._width += (this.w - this._width) / 1.5;
   if(abs(this._width - this.w) < 0.5)
   {
      this._width = this.w;
      delete this.onEnterFrame;
   }
};
vol.showBar = function()
{
   clearTimeout(this.timeoutID);
   strapline_btn.useHandCursor = false;
   strapline_mc.paused = true;
   strapline_mc.showLine(strapline_mc.VOLUME);
   fadeMovieClip(volume_mc,0,100,25);
   this.timeoutID = setTimeout(this,"hideBar",2000);
};
vol.hideBar = function()
{
   if(videoPaused)
   {
      strapline_btn.useHandCursor = false;
      strapline_mc.showLine(strapline_mc.PAUSED);
   }
   else
   {
      strapline_mc.paused = false;
   }
   fadeMovieClip(volume_mc,0,100,-25);
};
vol.setVolume(4);
introTimeout = setTimeout(hideIntroMenu,7000);
if(introShow && tvList.length > 0)
{
   fadeMovieClip(menu_mc,0,100,25);
   menu_mc.holder_mc.bg_mc[0][0].onRelease();
}
introShow = false;
this.createEmptyMovieClip("mouse_mc",this.getNextHighestDepth());
mouse_mc.onEnterFrame = function()
{
   if(this.mt > 0)
   {
      this.mt = this.mt - 1;
      if(this.mt == 0 && !menu_mc._visible && !strapline_mc.over && !this.context)
      {
         Mouse.hide();
      }
   }
};
var mouse = new Object();
mouse.onMouseMove = function()
{
   mouse_mc.mt = 75;
   Mouse.show();
   if(!bufferMsg_mc._visible && tvList.length > 0)
   {
      var _loc1_ = menu_mc.over;
      menu_mc.over = _ymouse > menu_mc._y - 190 && _ymouse < menu_mc._y + 20;
      if(menu_mc.over && !_loc1_)
      {
         fadeMovieClip(menu_mc,0,100,25);
         clearTimeout(introTimeout);
      }
      if(!menu_mc.over && _loc1_)
      {
         fadeMovieClip(menu_mc,0,100,-25);
         clearTimeout(introTimeout);
      }
   }
};
mouse.onMouseDown = function()
{
   if(!menu_mc._visible && !bufferMsg_mc._visible)
   {
      if(videoStopped)
      {
         video_mc.loadVideo(video_mc.num);
      }
      else if(videoPaused)
      {
         video_mc.pauseVideo(false);
      }
   }
   mouse_mc.context = false;
   mouse.onMouseMove();
};
mouse.onMouseWheel = function(d)
{
   if(menu_mc._visible && !bufferMsg_mc._visible)
   {
      menu_mc.wx = d * 3;
   }
};
mouse.onMouseDown();
Mouse.addListener(mouse);
stage.onResize();
