vid = videoinput('winvideo', 1, 'MJPG_1920x1080');
src = getselectedsource(vid);

vid.FramesPerTrigger = 1;

preview(vid);

src.Focus = 73;

src.Zoom = 200;

src.FocusMode = 'manual';

src.Focus = 70;

src.Focus = 73;

