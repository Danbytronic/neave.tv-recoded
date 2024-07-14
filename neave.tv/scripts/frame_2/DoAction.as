function fadeMovieClip(mc, min, max, step)
{
   var _loc2_ = mc.fader_mc;
   if(_loc2_ == undefined)
   {
      _loc2_ = mc.createEmptyMovieClip("fader_mc",mc.getNextHighestDepth());
   }
   _loc2_.min = min;
   _loc2_.max = max;
   _loc2_.step = step;
   _loc2_.onEnterFrame = function()
   {
      this._parent._alpha += this.step;
      this._parent._visible = this._parent._alpha > 0;
      if(this.step > 0 && this._parent._alpha >= this.max)
      {
         this._parent._alpha = this.max;
         this.removeMovieClip();
      }
      if(this.step < 0 && this._parent._alpha <= this.min)
      {
         this._parent._alpha = this.min;
         this.removeMovieClip();
      }
   };
}
function colorTint()
{
   var _loc4_ = rnd();
   this.r += _loc4_ * _loc4_ / this.s;
   var _loc5_ = rnd();
   this.g += _loc5_ * _loc5_ / this.s;
   var _loc3_ = rnd();
   this.b += _loc3_ * _loc3_ / this.s;
   var _loc2_ = sin(this.r) * 64 + this.n << 16 | sin(this.g) * 64 + this.n << 8 | sin(this.b) * 64 + this.n;
   this.c.setRGB(_loc2_);
   volume_mc.c.setRGB(_loc2_);
}
function updateFlash(h)
{
   introShow = false;
   gotoAndStop(3);
   var _loc2_ = video_mc.num;
   var _loc1_ = tvList.length;
   while(true)
   {
      _loc1_;
      if(!_loc1_--)
      {
         break;
      }
      if(tvList[_loc1_].hash == h)
      {
         _loc2_ = _loc1_;
         break;
      }
   }
   if(_loc2_ != video_mc.num)
   {
      menu_mc.holder_mc.panel_mc.tab1_mc.onRelease();
      video_mc.loadVideo(_loc2_);
   }
   else if(video_mc.num == 0)
   {
      video_mc.loadVideo(0);
   }
}
function __com_mochibot__(swfid, mc, lv, trk)
{
   var x;
   var g;
   var s;
   var fv;
   var sb;
   var u;
   var res;
   var mb;
   var mbc;
   mb = "__mochibot__";
   mbc = "mochibot.com";
   g = !_global ? _level0._root : _global;
   if(g[mb + swfid])
   {
      return g[mb + swfid];
   }
   s = System.security;
   x = mc._root.getSWFVersion;
   fv = !x ? (!_global ? 5 : 6) : mc.getSWFVersion();
   if(!s)
   {
      s = {};
   }
   sb = s.sandboxType;
   if(sb == "localWithFile")
   {
      return null;
   }
   x = s.allowDomain;
   if(x)
   {
      s.allowDomain(mbc);
   }
   x = s.allowInsecureDomain;
   if(x)
   {
      s.allowInsecureDomain(mbc);
   }
   u = "http://" + mbc + "/my/core.swf?mv=7&fv=" + fv + "&v=" + escape(getVersion()) + "&swfid=" + escape(swfid) + "&l=" + lv + "&f=" + mc + (!sb ? "" : "&sb=" + sb) + (!trk ? "" : "&t=1");
   lv = fv <= 6 ? (!g[mb + "level"] ? lv : g[mb + "level"] + 1) : mc.getNextHighestDepth();
   g[mb + "level"] = lv;
   if(fv == 5)
   {
      res = "_level" + lv;
      if(!eval(res))
      {
         getURL(u,"_level" add lv);
      }
   }
   else
   {
      res = mc.createEmptyMovieClip(mb + swfid,lv);
      res.loadMovie(u);
   }
   return res;
}
stop();
_quality = "BEST";
Stage.scaleMode = "noScale";
Stage.align = "TL";
System.security.allowDomain("*");
var BASE_URL = "";
var GOOGLE_URL = "http://vp.video.google.com/videodownload?version=0&secureurl=";
var VIDEO_TIMEOUT = 8000;
var BUFFER_TIMEOUT = 12000;
var MENU_IMG_WIDTH = 136;
var MENU_IMG_HEIGHT = 102;
var MENU_SPACING = 140;
var MENU_NAME_LIST = new Array("All","Short films","Technology","Subversive","Music","Weird");
var menuList = new Array([],[],[],[],[],[]);
var menuOffset = new Array(0,0,0,0,0,0);
var bufferCount = 0;
var bufferTimer = 0;
var BUFFER_MSG1 = "Sorry, it seems that the video for \'";
var BUFFER_MSG2 = "\' is on a slow connection at the moment.";
var BUFFER_MSG3 = "This may be due to your connection (1 meg broadband or above is recommended) or a slow connection with ";
var introShow = true;
var introTimeout = 0;
var videoPaused = false;
var videoStopping = false;
var videoStopped = false;
var round = Math.round;
var ceil = Math.ceil;
var rnd = Math.random;
var abs = Math.abs;
var sin = Math.sin;
var tv_so = SharedObject.getLocal("neaveTV");
var fullScreen = tv_so.data.fullScreen != undefined ? tv_so.data.fullScreen : true;
_level0.l_mc._visible = false;
strapline_mc._visible = false;
var stage = new Object();
stage.onResize = function()
{
   var _loc1_ = Stage.width;
   var _loc2_ = Stage.height;
   bmp_mc._width = video_mc._width = !fullScreen ? 640 : _loc1_;
   bmp_mc._height = video_mc._height = !fullScreen ? 440 : _loc2_;
   bmp_mc._x = video_mc._x = !fullScreen ? (_loc1_ - 640) / 2 : 0;
   bmp_mc._y = video_mc._y = !fullScreen ? (_loc2_ - 440) / 2 : 0;
   menu_mc._y = _loc2_ - 30;
   if(_loc1_ < 730)
   {
      _loc1_ = 730;
   }
   menu_mc.holder_mc.panel_mc.white_mc._width = _loc1_ - 80;
   menu_mc.holder_mc.mask_mc._width = menu_mc.mask_mc._width = _loc1_ - 88;
   menu_mc.holder_mc.fadeR_mc._x = _loc1_ - 83;
   menu_mc.holder_mc.right_mc._x = _loc1_ - 57;
   menu_mc.right_btn._x = _loc1_ - 88;
   menu_mc.updateOffset();
   menu_mc.loadNewImages();
   intro_mc._x = bufferMsg_mc._x = round(_loc1_ / 2);
   intro_mc._y = bufferMsg_mc._y = round(_loc2_ / 2);
};
menu_mc.over = false;
menu_mc.dx = 0;
menu_mc.wx = 0;
menu_mc.total = 0;
menu_mc.overNum = 0;
menu_mc.selectedTab = 0;
menu_mc.watchingTab = 0;
menu_mc._visible = false;
menu_mc.updateOffset = function()
{
   var _loc5_ = menuList[this.selectedTab].length * (- MENU_SPACING) + this.mask_mc._width;
   if(menuOffset[this.selectedTab] < _loc5_)
   {
      menuOffset[this.selectedTab] = _loc5_;
   }
   if(menuOffset[this.selectedTab] > 0)
   {
      menuOffset[this.selectedTab] = 0;
   }
   var _loc2_ = this.total;
   while(true)
   {
      _loc2_;
      if(!_loc2_--)
      {
         break;
      }
      var _loc3_ = round(_loc2_ * MENU_SPACING + menuOffset[this.selectedTab]);
      var _loc0_ = null;
      var _loc0_ = null;
      var _loc0_ = null;
      var _loc4_ = this.holder_mc.img_mc[this.selectedTab][_loc2_]._visible = this.holder_mc.bg_mc[this.selectedTab][_loc2_]._visible = this.black_mc[this.selectedTab][_loc2_]._visible = _loc3_ > - MENU_SPACING && _loc3_ < this.mask_mc._width;
      if(_loc4_)
      {
         this.holder_mc.img_mc[this.selectedTab][_loc2_]._x = this.holder_mc.bg_mc[this.selectedTab][_loc2_]._x = this.black_mc[this.selectedTab][_loc2_]._x = _loc3_;
      }
   }
   this.info_txt._x = this.holder_mc.bg_mc[this.selectedTab][this.overNum]._x + 22;
   this.info_txt._visible = this.info_txt._x > -10 && this.info_txt._x < this.mask_mc._width - MENU_SPACING + 32;
};
menu_mc.loadNewImages = function()
{
   var _loc3_ = ceil((this.mask_mc._width - menuOffset[this.selectedTab]) / MENU_SPACING);
   var _loc2_ = this.total;
   while(_loc2_ < _loc3_)
   {
      this.loadImage(_loc2_);
      _loc2_ = _loc2_ + 1;
   }
};
menu_mc.holder_mc.onEnterFrame = function()
{
   menu_mc.wx += (menu_mc.dx - menu_mc.wx) / 2;
   if(abs(menu_mc.wx) > 0.1)
   {
      menuOffset[menu_mc.selectedTab] += menu_mc.wx * 12;
      menu_mc.updateOffset();
      menu_mc.loadNewImages();
   }
};
menu_mc.left_btn.onPress = function()
{
   menu_mc.holder_mc.left_mc._alpha = 100;
   menu_mc.dx = 1;
};
menu_mc.right_btn.onPress = function()
{
   menu_mc.holder_mc.right_mc._alpha = 100;
   menu_mc.dx = -1;
};
menu_mc.left_btn.onRelease = menu_mc.left_btn.onReleaseOutside = menu_mc.right_btn.onRelease = menu_mc.right_btn.onReleaseOutside = function()
{
   menu_mc.holder_mc.left_mc._alpha = menu_mc.holder_mc.right_mc._alpha = 75;
   menu_mc.dx = 0;
};
menu_mc.left_btn.tabEnabled = menu_mc.right_btn.tabEnabled = false;
menu_mc.resetTabs = function()
{
   var _loc2_ = 1;
   while(_loc2_ < MENU_NAME_LIST.length + 1)
   {
      var _loc3_ = this.holder_mc.panel_mc["tab" + _loc2_ + "_mc"];
      _loc3_.enabled = true;
      _loc3_.onEnterFrame = function()
      {
         this._width = (this._width + this.w) / 2;
         if(this._alpha > 37.5)
         {
            this._alpha -= 12.5;
         }
         else
         {
            this._alpha = 37.5;
            this._width = this.w;
            delete this.onEnterFrame;
         }
      };
      var _loc4_ = this["tab" + _loc2_ + "_txt"];
      var _loc5_ = new TextFormat();
      _loc5_.bold = false;
      _loc4_.setTextFormat(_loc5_);
      _loc3_.w = _loc4_._width + 20;
      _loc2_ = _loc2_ + 1;
   }
};
menu_mc.selectTab = function()
{
   menu_mc.resetTabs();
   this.enabled = false;
   this.onEnterFrame = function()
   {
      this._width = (this._width + this.w) / 2;
      if(this._alpha < 100)
      {
         this._alpha += 12.5;
      }
      else
      {
         this._alpha = 100;
         this._width = this.w;
         delete this.onEnterFrame;
      }
   };
   var _loc3_ = menu_mc["tab" + this.num + "_txt"];
   var _loc4_ = new TextFormat();
   _loc4_.bold = true;
   _loc3_.setTextFormat(_loc4_);
   this.w = _loc3_._width + 20;
   var _loc2_ = menu_mc.total;
   while(true)
   {
      _loc2_;
      if(!_loc2_--)
      {
         break;
      }
      menu_mc.black_mc[menu_mc.selectedTab][_loc2_].removeMovieClip();
      menu_mc.holder_mc.bg_mc[menu_mc.selectedTab][_loc2_].removeMovieClip();
      menu_mc.holder_mc.img_mc[menu_mc.selectedTab][_loc2_].removeMovieClip();
   }
   menu_mc.black_mc[menu_mc.selectedTab]._visible = menu_mc.holder_mc.bg_mc[menu_mc.selectedTab]._visible = menu_mc.holder_mc.img_mc[menu_mc.selectedTab]._visible = false;
   menu_mc.selectedTab = this.num - 1;
   menu_mc.black_mc[menu_mc.selectedTab]._visible = menu_mc.holder_mc.bg_mc[menu_mc.selectedTab]._visible = menu_mc.holder_mc.img_mc[menu_mc.selectedTab]._visible = true;
   menu_mc.total = 0;
   menu_mc.updateOffset();
   menu_mc.loadNewImages();
   for(_loc2_ in menuList[menu_mc.selectedTab])
   {
      if(menuList[menu_mc.watchingTab][video_mc.num] == menuList[menu_mc.selectedTab][_loc2_])
      {
         video_mc.num = Number(_loc2_);
         menu_mc.watchingTab = menu_mc.selectedTab;
         break;
      }
   }
};
menu_mc.createTab = function(str, n)
{
   if(n > 1)
   {
      var _loc2_ = this.holder_mc.panel_mc.tab1_mc.duplicateMovieClip("tab" + n + "_mc",n);
   }
   else
   {
      _loc2_ = this.holder_mc.panel_mc.tab1_mc;
   }
   _loc2_.num = n;
   _loc2_._alpha = !selected ? 37.5 : 100;
   _loc2_.onRelease = this.selectTab;
   _loc2_.tabEnabled = false;
   menu_mc.black_mc.createEmptyMovieClip(n - 1,n - 1);
   menu_mc.holder_mc.bg_mc.createEmptyMovieClip(n - 1,n - 1);
   menu_mc.holder_mc.img_mc.createEmptyMovieClip(n - 1,n - 1);
   var _loc4_ = this.createTextField("tab" + n + "_txt",n,_loc2_._x - 60,-141,120,20);
   _loc4_.autoSize = "center";
   _loc4_.text = str;
   _loc4_.selectable = false;
   var _loc6_ = new TextFormat("Verdana",11,0);
   _loc6_.align = "center";
   _loc4_.setTextFormat(_loc6_);
   _loc2_._width = _loc4_._width + 20;
   if(n > 1)
   {
      var _loc5_ = this.holder_mc.panel_mc["tab" + Number(n - 1) + "_mc"];
      _loc2_._x = _loc5_._x + _loc5_._width / 2 + _loc2_._width / 2 + 8;
   }
   else
   {
      _loc2_._x = _loc2_._width / 2 + 25;
   }
   _loc4_._x = _loc2_._x - _loc2_._width / 2 + 10;
};
menu_mc.initTabs = function()
{
   var _loc2_ = 0;
   while(_loc2_ < MENU_NAME_LIST.length)
   {
      this.createTab(MENU_NAME_LIST[_loc2_] + " (" + menuList[_loc2_].length + ")",_loc2_ + 1);
      _loc2_ = _loc2_ + 1;
   }
   this.holder_mc.panel_mc.tab1_mc.onRelease();
};
menu_mc.loadImage = function(n)
{
   if(this.total < menuList[this.selectedTab].length)
   {
      this.total = this.total + 1;
      var _loc2_ = this.holder_mc.img_mc[this.selectedTab].createEmptyMovieClip(n,n);
      _loc2_.blendMode = "add";
      _loc2_._visible = false;
      _loc2_.mcl = new MovieClipLoader();
      _loc2_.bg = this.holder_mc.bg_mc[this.selectedTab].createEmptyMovieClip(n,n);
      _loc2_.bg.num = _loc2_.num = n;
      _loc2_.bg._x = n * MENU_SPACING + menuOffset[this.selectedTab];
      _loc2_.bg._alpha = 12.5;
      _loc2_.bg.onRelease = function()
      {
         menu_mc.watchingTab = menu_mc.selectedTab;
         video_mc.loadVideo(this.num);
      };
      _loc2_.bg.ts = new TextScrambler(menu_mc.info_txt,5,20,true);
      _loc2_.bg.onRollOver = function()
      {
         menu_mc.overNum = this.num;
         menu_mc.info_txt._x = this._x + 22;
         menu_mc.info_txt._visible = this._x > -20 && this._x < menu_mc.mask_mc._width - MENU_SPACING + 10;
         menu_mc.info_txt.htmlText = "";
         var _loc2_ = tvList[menuList[menu_mc.selectedTab][this.num]].name;
         this.ts.cancel();
         this.ts.per = _loc2_.length / 4;
         this.ts.scramble(_loc2_);
      };
      _loc2_.bg.onRollOut = _loc2_.bg.onDragOut = function()
      {
         this.ts.cancel();
         menu_mc.info_txt.htmlText = "";
      };
      var _loc8_ = new flash.display.BitmapData(MENU_IMG_WIDTH,MENU_IMG_HEIGHT,true,4278190080);
      _loc2_.bg.attachBitmap(_loc8_,0,"never",false);
      _loc8_.applyFilter(_loc8_,_loc8_.rectangle,new flash.geom.Point(0,0),new flash.filters.GlowFilter(16777215,1,10,10,1.85,3,true,false));
      _loc2_.onLoadError = function(mc, e, http)
      {
         var _loc2_ = new flash.display.BitmapData(MENU_IMG_WIDTH,MENU_IMG_HEIGHT,false,4286611584);
         mc.attachBitmap(_loc2_,0,"never",false);
         _loc2_.draw(mc);
         this.onLoadInit(mc);
      };
      _loc2_.onLoadInit = function(mc)
      {
         var _loc1_ = mc._parent;
         var _loc3_ = menu_mc.black_mc[menu_mc.selectedTab].attachMovie("black",_loc1_.num,_loc1_.num);
         _loc3_.cacheAsBitmap = true;
         _loc3_._x = _loc1_.num * MENU_SPACING + menuOffset[menu_mc.selectedTab];
         var _loc5_ = new flash.display.BitmapData(MENU_IMG_WIDTH,MENU_IMG_HEIGHT,false,4278190080);
         _loc1_.attachBitmap(_loc5_,1,"never",true);
         var _loc4_ = new flash.geom.Matrix();
         _loc4_.scale(MENU_IMG_WIDTH / mc._width,MENU_IMG_HEIGHT / mc._height);
         _loc5_.draw(mc,_loc4_);
         _loc1_._x = _loc1_.num * MENU_SPACING + menuOffset[menu_mc.selectedTab];
         _loc1_._visible = true;
         _loc1_.cacheAsBitmap = true;
         if(menu_mc.watchingTab == menu_mc.selectedTab && _loc1_.num == video_mc.num)
         {
            _loc1_.bg._alpha = 75;
            _loc1_._alpha = _loc3_._alpha = 0;
            _loc1_._visible = _loc3_._visible = false;
         }
         else
         {
            _loc1_.bg._alpha = 25;
            fadeMovieClip(_loc1_.bg,0,100,25);
         }
         _loc1_.mcl.unloadClip(mc);
         mc.removeMovieClip();
         delete _loc1_.mcl;
         delete _loc1_.onLoadInit;
      };
      _loc2_.mcl.addListener(_loc2_);
      _loc2_.mcl.loadClip(BASE_URL + "thumbnails/" + tvList[menuList[this.selectedTab][n]].imageURL,_loc2_.createEmptyMovieClip("loader_mc",0));
   }
   return undefined;
};
var tv_nc = new NetConnection();
tv_nc.connect(null);
var tv_ns = new NetStream(tv_nc);
tv_ns.setBufferTime(2);
tv_ns.onMetaData = function(o)
{
   video_mc.bytesTotal = this.bytesTotal <= 0 ? Number(o.bytelength) : this.bytesTotal;
   video_mc.duration = Number(tvList[menuList[menu_mc.watchingTab][video_mc.num]].duration) / 1000 || Number(o.duration);
};
tv_ns.onStatus = function(o)
{
   switch(o.code)
   {
      case "NetStream.Buffer.Flush":
      case "NetStream.Play.Stop":
         videoStopping = true;
         break;
      case "NetStream.Play.StreamNotFound":
         videoStopping = true;
      case "NetStream.Buffer.Empty":
         if(videoStopping && tv_ns.time != undefined && tv_ns.time > video_mc.duration - 5)
         {
            video_mc.loadVideo(video_mc.num + 1);
            break;
         }
      case "NetStream.Play.Start":
         tv_ns.pause(true);
         strapline_mc.paused = true;
         clearTimeout(video_mc.bufferTimeoutID);
         clearTimeout(video_mc.bufferMsgTimeoutID);
         clearTimeout(video_mc.connectTimeoutID);
         bufferCount++;
         if(bufferCount == 1)
         {
            tv_ns.setBufferTime(2);
         }
         if(bufferCount == 2)
         {
            tv_ns.setBufferTime(4);
         }
         if(bufferCount == 3)
         {
            tv_ns.setBufferTime(6);
         }
         if(bufferCount > 3)
         {
            tv_ns.setBufferTime(8);
            if(getTimer() - bufferTimer < 20000)
            {
               video_mc.bufferTimeout();
            }
         }
         else
         {
            video_mc.bufferTimeoutID = setTimeout(video_mc.bufferTimeout,(tv_ns.bufferTime + 10) * 1000);
         }
         if(!videoStopping)
         {
            fadeMovieClip(menu_mc.holder_mc.bg_mc[menu_mc.watchingTab][video_mc.num],75,100,-12.5);
            fadeMovieClip(menu_mc.holder_mc.img_mc[menu_mc.watchingTab][video_mc.num],0,100,-12.5);
            fadeMovieClip(menu_mc.black_mc[menu_mc.watchingTab][video_mc.num],0,100,-12.5);
            var _loc2_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]].bounds.split(",");
            video_mc.cropVideo(Number(_loc2_[0]) || 0,Number(_loc2_[1]) || 0,Number(_loc2_[2]) || 0,Number(_loc2_[3]) || 0);
         }
         video_mc.onEnterFrame = function()
         {
            var _loc2_ = round(tv_ns.bufferLength / tv_ns.bufferTime * 100);
            if(_loc2_ >= 0 && _loc2_ < 100)
            {
               dot_mc.cancel();
               strapline_mc.ts.cancel();
               strapline_mc.line_txt.htmlText = ":: Just a moment... " + _loc2_ + "%";
               strapline_btn.useHandCursor = false;
            }
            if(_loc2_ > 99)
            {
               bufferTimer = getTimer();
               videoStopped = false;
               clearTimeout(video_mc.bufferTimeoutID);
               clearTimeout(video_mc.bufferMsgTimeoutID);
               if(!bufferMsg_mc._visible)
               {
                  bmp_mc.hideDistortion();
                  tv_ns.pause(false);
               }
               strapline_mc.mod = -1;
               strapline_mc.paused = false;
               if(mouse_mc.mt == 0 && !menu_mc._visible && !strapline_mc.over && !mouse_mc.context)
               {
                  mouse_mc.mt = 2;
               }
               delete this.onEnterFrame;
            }
         };
   }
};
flash.external.ExternalInterface.addCallback("updateFlash",this,updateFlash);
video_mc.num = 0;
video_mc.loadVideo = function(n)
{
   clearTimeout(video_mc.bufferTimeoutID);
   clearTimeout(video_mc.bufferMsgTimeoutID);
   clearTimeout(video_mc.connectTimeoutID);
   video_mc.connectTimeoutID = setTimeout(video_mc.connectTimeout,VIDEO_TIMEOUT);
   fadeMovieClip(menu_mc.holder_mc.bg_mc[menu_mc.watchingTab][video_mc.num],75,100,25);
   fadeMovieClip(menu_mc.holder_mc.img_mc[menu_mc.watchingTab][video_mc.num],0,100,25);
   fadeMovieClip(menu_mc.black_mc[menu_mc.watchingTab][video_mc.num],0,100,25);
   if(n >= menuList[menu_mc.watchingTab].length)
   {
      n = 0;
   }
   video_mc.num = n;
   var _loc1_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
   var _loc2_ = "";
   if(_loc1_.flvBase == "google")
   {
      _loc2_ = GOOGLE_URL;
   }
   videoStopping = false;
   bmp_mc.showDistortion();
   bufferCount = 0;
   tv_ns.setBufferTime(2);
   tv_ns.play(_loc2_ + _loc1_.flvURL);
   tv_ns.pause(true);
   tv_ns.seek(0);
   videoPaused = false;
   video_mc.duration = _loc1_.duration / 1000;
   strapline_mc.num = 1;
   strapline_mc.paused = true;
   dot_mc.init(strapline_mc.line_txt,":: Just a moment");
   flash.external.ExternalInterface.call("setHistory",_loc1_.hash,_loc1_.name);
};
video_mc.connectTimeoutID = video_mc.bufferTimeoutID = video_mc.bufferMsgTimeoutID = 0;
video_mc.connectTimeout = function()
{
   clearTimeout(video_mc.connectTimeoutID);
   tv_ns.close();
   tv_ns.onStatus({code:"NetStream.Play.StreamNotFound",level:"error"});
   clearTimeout(video_mc.bufferTimeoutID);
   video_mc.bufferTimeoutID = setTimeout(video_mc.bufferTimeout,tv_ns.bufferTime * 1000);
};
video_mc.bufferTimeout = function()
{
   clearTimeout(video_mc.bufferTimeoutID);
   clearTimeout(video_mc.bufferMsgTimeoutID);
   video_mc.bufferMsgTimeoutID = setTimeout(video_mc.bufferMsgTimeout,BUFFER_TIMEOUT);
   fadeMovieClip(menu_mc,0,100,-25);
   fadeMovieClip(bufferMsg_mc,0,100,25);
   menu_mc.over = false;
   var _loc1_ = tvList[menuList[menu_mc.watchingTab][video_mc.num]];
   bufferMsg_mc.txt1.text = BUFFER_MSG1 + _loc1_.name + BUFFER_MSG2;
   bufferMsg_mc.txt2.text = BUFFER_MSG3 + _loc1_.flvHost + ".";
};
video_mc.bufferMsgTimeout = function()
{
   clearTimeout(video_mc.bufferMsgTimeoutID);
   bufferMsg_mc.next_btn.onRelease();
};
video_mc.cropVideo = function(t, r, b, l)
{
   video_mc.scrollRect = new flash.geom.Rectangle(l,t,160 - l - r,120 - t - b);
   bmp_mc.m = new flash.geom.Matrix();
   bmp_mc.m.scale(240 / video_mc.scrollRect.width,180 / video_mc.scrollRect.height);
   stage.onResize();
   setTimeout(stage.onResize,60);
};
video_mc.pauseVideo = function(p)
{
   bmp_mc.hideDistortion();
   if(!p)
   {
      strapline_mc.mod = -1;
   }
   strapline_mc.paused = videoPaused = p;
   tv_ns.pause(p);
   if(p)
   {
      strapline_btn.useHandCursor = false;
      strapline_mc.showLine(strapline_mc.PAUSED);
   }
};
video_mc.stopVideo = function()
{
   bmp_mc.hideDistortion();
   video_mc.pauseVideo(true);
   tv_ns.close();
   clearTimeout(video_mc.connectTimeoutID);
   videoStopped = true;
};
video_mc.toggleFullScreen = function()
{
   tv_so.data.fullScreen = fullScreen = !fullScreen;
   stage.onResize();
};
video_mc.video.clear();
video_mc.video.smoothing = true;
video_mc.video.deblocking = 5;
video_mc.video.attachVideo(tv_ns);
video_mc.onKeyDown = function(key)
{
   var _loc1_ = Number(key) || Key.getCode();
   if(_loc1_ == 70)
   {
      video_mc.toggleFullScreen();
   }
   if(introShow || bufferMsg_mc._visible)
   {
      return undefined;
   }
   var _loc2_ = false;
   switch(_loc1_)
   {
      case 32:
      case 80:
         if(videoStopped)
         {
            video_mc.loadVideo(video_mc.num);
         }
         else if(videoPaused)
         {
            video_mc.pauseVideo(false);
         }
         else if(!strapline_mc.paused)
         {
            video_mc.pauseVideo(true);
         }
         break;
      case 37:
         if(!key)
         {
            menu_mc.dx = 1;
            _loc2_ = true;
         }
         break;
      case 39:
         if(!key)
         {
            menu_mc.dx = -1;
            _loc2_ = true;
         }
         break;
      case 187:
         vol.setVolume(vol.getVolume() + 1);
         vol.showBar();
         break;
      case 189:
         vol.setVolume(vol.getVolume() - 1);
         vol.showBar();
   }
   if(_loc1_ > 48 && _loc1_ < 58)
   {
      var _loc3_ = menu_mc.holder_mc.panel_mc["tab" + Number(_loc1_ - 48) + "_mc"];
      if(_loc3_._visible && _loc3_.enabled)
      {
         _loc3_.onRelease();
         _loc2_ = true;
      }
   }
   if(_loc2_ && !menu_mc.over && tvList.length > 0)
   {
      menu_mc.over = true;
      fadeMovieClip(menu_mc,0,100,25);
   }
};
video_mc.onKeyUp = function()
{
   if(Key.getCode() == 39 || Key.getCode() == 37)
   {
      menu_mc.dx = 0;
   }
};
Key.addListener(video_mc);
flash.external.ExternalInterface.addCallback("keyDown",null,video_mc.onKeyDown);
bmp_mc.bmp0 = new flash.display.BitmapData(240,180,false,4278190080);
bmp_mc.bmp0.fillRect(this.bmp0.rectangle,4278190080);
bmp_mc.bmp1 = bmp_mc.bmp0.clone();
bmp_mc.bmp2 = bmp_mc.bmp0.clone();
bmp_mc.bmp3 = bmp_mc.bmp0.clone();
bmp_mc.m = new flash.geom.Matrix();
bmp_mc.m.scale(2,2);
bmp_mc.mtc = bmp_mc.m.clone();
bmp_mc.p0 = new flash.geom.Point(0,0);
bmp_mc.pl = new Array(new flash.geom.Point(0,0),new flash.geom.Point(0,0),new flash.geom.Point(0,0));
bmp_mc.c = new Array(rnd() + 1,rnd() + 1,rnd() + 1);
bmp_mc.d = new Array(0,0,0);
bmp_mc.w = 0.25;
bmp_mc.v = 0;
bmp_mc.mc = bmp_mc.attachMovie("tc","tc_mc",0);
bmp_mc.mc._visible = false;
bmp_mc.attachBitmap(bmp_mc.bmp2,1,"always",true);
bmp_mc.createEmptyMovieClip("white_mc",2);
bmp_mc.white = new Sound("bmp_mc.white_mc");
bmp_mc.white.attachSound("white");
bmp_mc.white.setVolume(0);
bmp_mc.createEmptyMovieClip("beep_mc",3);
bmp_mc.beep = new Sound("bmp_mc.beep_mc");
bmp_mc.beep.attachSound("beep");
bmp_mc.beep.setVolume(10);
bmp_mc.beep.start(0,100000000);
bmp_mc._visible = false;
bmp_mc.showDistortion = function()
{
   if(!this._visible)
   {
      this.white.stop();
      this.white.start(0,1000);
      this.onEnterFrame = this.distort;
   }
};
bmp_mc.hideDistortion = function()
{
   delete this.onEnterFrame;
   this.white.stop();
   this.beep.stop();
   var _loc2_ = new flash.geom.Matrix();
   _loc2_.scale(2,2);
   this.bmp0.fillRect(this.bmp0.rectangle,4278190080);
   video_mc._visible = true;
   this._visible = false;
};
bmp_mc.distort = function()
{
   this._visible = true;
   video_mc._visible = false;
   if(Number(getVersion().substr(4,1)) < 9)
   {
      this.bmp0.draw(this.tc_mc,this.mtc);
   }
   else
   {
      this.bmp0.draw(this.mc,this.m);
   }
   this.bmp1 = this.bmp0.clone();
   var _loc2_ = 3;
   while(true)
   {
      _loc2_;
      if(!_loc2_--)
      {
         break;
      }
      if(this.c[_loc2_] >= 1)
      {
         this.c[_loc2_]--;
         this.d[_loc2_] = rnd() / 4;
      }
      this.c[_loc2_] += this.d[_loc2_];
      this.pl[_loc2_].x = ceil(sin(this.c[_loc2_] * 3.141592653589793 * 2) * this.d[_loc2_] * 32);
   }
   var _loc4_ = (abs(this.pl[0].x) + abs(this.pl[1].x) + abs(this.pl[2].x) + 8) / 4;
   _loc2_ = 180;
   while(true)
   {
      _loc2_;
      if(!_loc2_--)
      {
         break;
      }
      var _loc3_ = sin(_loc2_ / 180 * (rnd() / 8 + 1) * this.w * 3.141592653589793 * 2) * this.w * _loc4_ * _loc4_;
      this.bmp1.copyPixels(this.bmp0,new flash.geom.Rectangle(_loc3_,_loc2_,240 - _loc3_,1),new flash.geom.Point(0,_loc2_));
   }
   if(_loc4_ > 3.5)
   {
      this.w = rnd() * 2;
   }
   if(this.w < 0.8)
   {
      this.bmp3.noise(int(rnd() * 1000),0,255,7,false);
      var _loc5_ = _loc4_ * _loc4_ * _loc4_;
      this.bmp1.merge(this.bmp3,this.bmp1.rectangle,this.p0,_loc5_,_loc5_,_loc5_,0);
   }
   if(rnd() < 0.02)
   {
      this.v = 20;
   }
   if(this.v > 0)
   {
      this.v += 20;
      this.v %= 180;
      var _loc6_ = this.bmp1.clone();
      this.bmp1.copyPixels(_loc6_,new flash.geom.Rectangle(0,0,240,this.v),new flash.geom.Point(0,180 - this.v));
      this.bmp1.copyPixels(_loc6_,new flash.geom.Rectangle(0,this.v,240,180 - this.v),new flash.geom.Point(0,0));
      this.white.setVolume(0);
   }
   else
   {
      var _loc7_ = this.w * this.w * 24;
      this.white.setVolume(_loc7_);
   }
   this.bmp2.copyChannel(this.bmp1,this.bmp2.rectangle,this.pl[0],1,1);
   this.bmp2.copyChannel(this.bmp1,this.bmp2.rectangle,this.pl[1],2,2);
   this.bmp2.copyChannel(this.bmp1,this.bmp2.rectangle,this.pl[2],4,4);
};
bmp_mc.showDistortion();
stage.onResize();
Stage.addListener(stage);
var tagList = new Object();
var tvList = new Array();
var listings_xml = new XML();
listings_xml.ignoreWhite = true;
listings_xml.onLoad = function(success)
{
   if(success)
   {
      var _loc7_ = this.firstChild.childNodes;
      var _loc2_ = 0;
      while(_loc2_ < _loc7_.length)
      {
         var _loc6_ = _loc7_[_loc2_];
         var _loc3_ = _loc6_.attributes;
         tvList[_loc2_] = new Object();
         tvList[_loc2_].name = _loc3_.name;
         tvList[_loc2_].copyright = _loc3_.copyright;
         tvList[_loc2_].link = _loc3_.link;
         tvList[_loc2_].linkBasic = _loc3_.link_basic;
         tvList[_loc2_].flvURL = _loc3_.flv_url;
         tvList[_loc2_].flvBase = _loc3_.flv_base;
         tvList[_loc2_].flvHost = _loc3_.flv_host;
         tvList[_loc2_].flvLink = _loc3_.flv_link;
         tvList[_loc2_].imageURL = _loc3_.image_url;
         tvList[_loc2_].hash = _loc3_.image_url.split(".")[0];
         tvList[_loc2_].bounds = _loc3_.bounds;
         tvList[_loc2_].duration = parseInt(_loc3_.duration);
         tvList[_loc2_].tags = _loc3_.tags;
         var _loc5_ = _loc3_.tags.split(",");
         for(var _loc8_ in _loc5_)
         {
            var _loc4_ = 0;
            switch(_loc5_[_loc8_])
            {
               case "short":
                  _loc4_ = 1;
                  break;
               case "technology":
                  _loc4_ = 2;
                  break;
               case "subversive":
                  _loc4_ = 3;
                  break;
               case "music":
                  _loc4_ = 4;
                  break;
               case "weird":
                  _loc4_ = 5;
            }
            menuList[_loc4_].push(_loc2_);
         }
         menuList[0].push(_loc2_);
         _loc2_ = _loc2_ + 1;
      }
      dot_mc.cancel();
      strapline_mc.paused = false;
      menu_mc.initTabs();
      if(hash.length > 0)
      {
         updateFlash(hash);
      }
      else if(!introShow)
      {
         fadeMovieClip(menu_mc,0,100,25);
         menu_mc.holder_mc.bg_mc[0][0].onRelease();
      }
      mouse.onMouseDown();
      delete listings_xml;
   }
   else
   {
      dot_mc.cancel();
      strapline_btn.useHandCursor = false;
      strapline_mc.showLine("Could not load TV... please reload page to try again!");
   }
};
listings_xml.load(BASE_URL + "get_listings.php");
if(hash.length > 0)
{
   intro_mc._visible = false;
   intro_mc.neave_mc.gotoAndStop(1);
}
intro_mc.ts = new TextScrambler(intro_mc.line_mc.txt,5,20,false);
intro_mc.btn.onRelease = function()
{
   play();
};
intro_mc.btn.onRollOver = function()
{
   intro_mc.ts.cancel();
   intro_mc.ts.scramble("Click me to turn me on...");
};
intro_mc.btn.onRollOut = intro_mc.btn.onDragOut = function()
{
   intro_mc.ts.cancel();
   intro_mc.ts.scramble("Creativity in a telly stylee");
};
intro_mc.neave_btn.onRelease = function()
{
   getUrl("http://www.neave.com/", "_top");
};
intro_mc.mt_btn.onRelease = function()
{
   getUrl("http://www.mediatemple.net/.from/neave.com", "_blank");
};
__com_mochibot__("2c02251c",this,10301,true);
