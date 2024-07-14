stop();
_parent.tv_mc.onEnterFrame = function()
{
   if(this._alpha < 100)
   {
      this._alpha += 6.25;
   }
   else
   {
      _parent.txt_mc._alpha = this._alpha = 100;
      this.createEmptyMovieClip("t_mc",0);
      this.t_mc.onEnterFrame = function()
      {
         this._parent._parent.line_mc.txt.textColor = "0x" + this._parent.c.getRGB().toString(16);
      };
      this.onEnterFrame = this.colorTint;
   }
   _parent.line_mc._alpha = this._alpha;
};
