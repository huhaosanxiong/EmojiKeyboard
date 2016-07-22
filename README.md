# EmojiKeyboard
简约封装的emoji键盘和图文混排Demo<br><br>
效果如下:<br><br>
![image](https://github.com/huhaosanxiong/EmojiKeyboard/raw/master/GIF.gif)
<br>
由于这个Demo做的有些粗糙，解释下以下类：<br>
`ChatBarVC`这个是输入框和表情切换按钮的一个父类View,`EmojiScrollView`这个是有emoji的一个`UIScrollView`,`ChatBarFaceView`是`EmojiScrollView`的一个父视图
`NaturalData`这个是emoji图片的名称，一般是从plist文件中获取。<br>
`NSString+HNEmojiExtension`是一个工具类，用来正则匹配表情字符串的类，`HNEmojiContact`则是表情的模型。<br>
`详情请见Demo`
