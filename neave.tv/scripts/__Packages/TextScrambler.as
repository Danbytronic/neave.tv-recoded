class TextScrambler
{
   var txt;
   var _per;
   var speed;
   var bold;
   var id;
   var a1;
   var a2;
   var len;
   var order;
   var count;
   var onComplete;
   function TextScrambler(txt, per, speed, bold)
   {
      this.txt = txt;
      this._per = per;
      this.speed = speed;
      this.bold = bold;
   }
   function cancel()
   {
      clearInterval(this.id);
   }
   function scramble(s)
   {
      this.cancel();
      this.a1 = this.txt.text.split("");
      this.a2 = this.split(s);
      this.len = Math.max(this.a1.length,this.a2.length);
      this.order = new Array();
      var _loc2_ = this.len;
      while(true)
      {
         _loc2_;
         if(!_loc2_--)
         {
            break;
         }
         this.order.push(_loc2_);
      }
      this.order.sort(this.shuffle);
      this.count = 0;
      this.id = setInterval(this,"loop",this.speed);
   }
   function get per()
   {
      return this._per;
   }
   function set per(n)
   {
      if(n < 1)
      {
         n = 1;
      }
      this._per = int(n);
   }
   function split(s)
   {
      var _loc5_ = new Array();
      var _loc1_ = 0;
      while(_loc1_ < s.length)
      {
         var _loc2_ = s.charAt(_loc1_);
         if(_loc2_ == "&")
         {
            var _loc3_ = s.indexOf(";",_loc1_);
            if(_loc3_ != -1)
            {
               _loc5_.push(s.substring(_loc1_,_loc3_ + 1));
               _loc1_ = _loc3_;
            }
            else
            {
               _loc5_.push(_loc2_);
            }
         }
         else
         {
            _loc5_.push(_loc2_);
         }
         _loc1_ = _loc1_ + 1;
      }
      return _loc5_;
   }
   function loop()
   {
      var _loc2_ = this._per;
      while(true)
      {
         _loc2_;
         if(!_loc2_--)
         {
            break;
         }
         if(this.count >= this.len)
         {
            this.onComplete();
            this.cancel();
            break;
         }
         this.a1[this.order[this.count]] = this.a2[this.order[this.count]] || "";
         this.count = this.count + 1;
      }
      var _loc3_ = new String();
      _loc2_ = 0;
      while(_loc2_ < this.len)
      {
         _loc3_ += this.a1[_loc2_] || "";
         _loc2_ = _loc2_ + 1;
      }
      this.txt.htmlText = !this.bold ? _loc3_ : "<B>" + _loc3_ + "</B>";
      updateAfterEvent();
   }
   function shuffle()
   {
      return Math.floor(Math.random() * 2);
   }
}
