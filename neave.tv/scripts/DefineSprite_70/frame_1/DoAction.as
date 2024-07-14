tv_mc.c = new Color(tv_mc);
tv_mc.r = _parent.rnd() * 255;
tv_mc.g = _parent.rnd() * 255;
tv_mc.b = _parent.rnd() * 255;
tv_mc.s = 12;
tv_mc.n = 127;
tv_mc.colorTint = _parent.colorTint;
tv_mc.colorTint();
line_mc.txt.textColor = "0x" + tv_mc.c.getRGB().toString(16);
