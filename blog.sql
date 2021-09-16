-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	5.7.35-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog_article`
--

DROP TABLE IF EXISTS `blog_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `content` text NOT NULL,
  `html` text NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `created_time` varchar(32) NOT NULL,
  `updated_time` varchar(32) DEFAULT '',
  `status` varchar(16) NOT NULL DEFAULT 'published',
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`) USING BTREE,
  KEY `category` (`category_id`),
  CONSTRAINT `category` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_article`
--

LOCK TABLES `blog_article` WRITE;
/*!40000 ALTER TABLE `blog_article` DISABLE KEYS */;
INSERT INTO `blog_article` VALUES (1,'Go定义文章口','定义接口\n本节编写文章的逻辑，我们定义一下接口吧！\n\n获取文章列表：GET(\"/articles”)\n获取指定文章：POST(\"/articles/:id”)\n新建文章：POST(\"/articles”)\n更新指定文章：PUT(\"/articles/:id”)\n删除指定文章：DELETE(\"/articles/:id”)\n编写路由逻辑\n在routers的 v1 版本下，新建article.go文件，写入内容：\n`\npackage util\n\nimport (\n	\"time\"\n\n	jwt \"github.com/dgrijalva/jwt-go\"\n\n	\"github.com/EDDYCJY/go-gin-example/pkg/setting\"\n)\n\nvar jwtSecret = []byte(setting.JwtSecret)\n\ntype Claims struct {\n	Username string `json:\"username\"`\n	Password string `json:\"password\"`\n	jwt.StandardClaims\n}\n\nfunc GenerateToken(username, password string) (string, error) {\n	nowTime := time.Now()\n	expireTime := nowTime.Add(3 * time.Hour)\n\n	claims := Claims{\n		username,\n		password,\n		jwt.StandardClaims {\n			ExpiresAt : expireTime.Unix(),\n			Issuer : \"gin-blog\",\n		},\n	}\n\n	tokenClaims := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)\n	token, err := tokenClaims.SignedString(jwtSecret)\n\n	return token, err\n}\n\nfunc ParseToken(token string) (*Claims, error) {\n	tokenClaims, err := jwt.ParseWithClaims(token, &Claims{}, func(token *jwt.Token) (interface{}, error) {\n		return jwtSecret, nil\n	})\n\n	if tokenClaims != nil {\n		if claims, ok := tokenClaims.Claims.(*Claims); ok && tokenClaims.Valid {\n			return claims, nil\n		}\n	}\n\n	return nil, err\n}\n`','<p>定义接口<br>\n本节编写文章的逻辑，我们定义一下接口吧！</p>\n<p>获取文章列表：GET(\"/articles”)<br>\n获取指定文章：POST(\"/articles/:id”)<br>\n新建文章：POST(\"/articles”)<br>\n更新指定文章：PUT(\"/articles/:id”)<br>\n删除指定文章：DELETE(\"/articles/:id”)<br>\n编写路由逻辑<br>\n在routers的 v1 版本下，新建article.go文件，写入内容：<br>\n`<br>\npackage util</p>\n<p>import (<br>\n\"time\"</p>\n<pre><code>jwt \"github.com/dgrijalva/jwt-go\"\n\n\"github.com/EDDYCJY/go-gin-example/pkg/setting\"\n</code></pre>\n<p>)</p>\n<p>var jwtSecret = []byte(setting.JwtSecret)</p>\n<p>type Claims struct {<br>\nUsername string <code data-backticks=\"1\">json:\"username\"</code><br>\nPassword string <code data-backticks=\"1\">json:\"password\"</code><br>\njwt.StandardClaims<br>\n}</p>\n<p>func GenerateToken(username, password string) (string, error) {<br>\nnowTime := time.Now()<br>\nexpireTime := nowTime.Add(3 * time.Hour)</p>\n<pre><code>claims := Claims{\n	username,\n	password,\n	jwt.StandardClaims {\n		ExpiresAt : expireTime.Unix(),\n		Issuer : \"gin-blog\",\n	},\n}\n\ntokenClaims := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)\ntoken, err := tokenClaims.SignedString(jwtSecret)\n\nreturn token, err\n</code></pre>\n<p>}</p>\n<p>func ParseToken(token string) (*Claims, error) {<br>\ntokenClaims, err := jwt.ParseWithClaims(token, &amp;Claims{}, func(token *jwt.Token) (interface{}, error) {<br>\nreturn jwtSecret, nil<br>\n})</p>\n<pre><code>if tokenClaims != nil {\n	if claims, ok := tokenClaims.Claims.(*Claims); ok &amp;&amp; tokenClaims.Valid {\n		return claims, nil\n	}\n}\n\nreturn nil, err\n</code></pre>\n<p>}<br>\n`</p>\n',1,'2021-08-24 17:28:07','','published'),(2,'满载而归','深秋是天高气爽风轻云淡的那一丝微笑，深秋是草木退去浓绿后绚丽的五彩斑斓，深秋更是姗姗来迟者的喜上眉梢。\n\n我们一行四人迎着暖阳，沿着高速公路向竹林关进发，一路欢声笑语不用多说。临近中午参观完魔芋加工厂后准备去土门公社吃午饭。车子沿着一条依山傍水的小路蜿蜒前行。正在大家感叹“柳暗花明又一村”的时候，土门公社到了。土门公社在小溪的对面，许是这深秋的凉意，让从未来过的我感到些许冷清。过了小石桥我们来到小小的院落，里面一个大大的石盘碾子很是显眼，墙上挂着已经风干了的辣椒、大蒜、葫芦等作为农家饭庄的点缀，虽然已经褪色变形，但依稀能够感觉到这里曾经的热闹和红火。进到里面差不多有六间左右的不同公社风格的包间，由于是原地改造加上现在所处的季节，每个包间里都弥漫着刺鼻的霉变味道，采光也不是很好显得更幽暗而沉闷。于是我建议大家在一排像员工宿舍一样的标准间前面的院子里吃饭，那里正好有长条桌凳。院子尽头便是溪流，我们趴着围栏向下看，溪堤有差不多五米高，水草游鱼清晰可见，叮叮咚咚的流水声很是悦耳，深深吸一口没有污染和杂质的空气顿时感觉神清气爽。不一会儿一桌子丰盛的饭食便端了上来，可能是时间有点晚了，大家都很饿一阵风卷残云般结束了战斗，个个酒足饭饱的样子很可爱，而我还沉醉在清炒油麦菜的余香里不肯出来。\n\n休息片刻后，我们换乘李老板的面包车前去参观他的基地。穿过村庄来到一个狭窄、曲折、幽长的山谷，一路虽然颠簸又惊险，我们却很陶醉车窗外原始气息浓厚的秋景。满山遍野的黄色野菊花就着习习凉风带着淡淡的菊香味扑鼻而来;时而看见几只布尔山羊在山坡上悠闲地啃着草;最让大家欢呼雀跃的是那满树红彤彤的柿子，因无人采摘而不堪负重就连那树枝都快要压断了;几经辗转，路越来越窄，看得出李老板对这里的路况了如指掌，才能这样一边耐心跟我们聊天，一边有紧不慢地开着车。终于在一个没有路的山坳里，我们到达了的基地。由因猪瘟被封弃的猪舍到荒芜破败的鸡棚，绕过一大片郁郁葱葱的竹林，我们来到李老板的“老巢”。最让我惊讶的是这里虽是过去旧的三间土墙瓦房但是里面却有监控，竟然还有一个摄像头正常运作着。让我这个做IT小买卖的很是折服，真是难以想象他几年前在这样的深山沟里是怎样做到的啊!心头不由的对这个中等身材和个头的中年男人油然起敬，打心眼里佩服他的毅力和胆识。\n\n听完李老板的讲解后，我们四人便开始了自由活动。绕过因搬迁而被遗留下的一两栋只剩下残垣断壁的土房子，几株山茱萸自生自灭地生长着，耳边不时传来不知名的鸟儿清脆的叫声，脚下杂草间开着些许野花，空气中夹杂着似有似无的淡淡的花香。这一切都让我们沉醉，每个人脸上都洋溢着孩童般的微笑!大家不约而同地沐浴着阳光，感受着没有凡世杂尘纷扰这大自然的和谐与宁静!“快看”不知谁一声把大家惊醒，顺着手指的方向，哪儿有几颗柿子树，大家立刻动如脱兔般向柿子树飞奔而去，也顾不得因脚下一深一浅而超级搞笑的奔跑动作了，看着满树繁的火红的柿子，像极了一个个精致的小红灯笼真让人应接不暇，我们个个摩拳擦掌、跃跃欲试。“你拉着树枝我来摘”、“不行不行够不着了”、“换地方换地方”、“还是换另外一颗树摘吧!”、“不能一个一个摘，得一支一支的折，这样摘的多”。大家忙得不亦乐乎，直到每个人都拿不下了才肯罢休!把柿子都抱到车上以后，不知谁发现了藤蔓上的小南瓜，因为深秋的温度比较低这些南瓜已经不再生长了，但也足以让我们这些城里人垂涎三尺，你一个我两个不到几分钟就摘了差不多20个。不经意间，我看见地里的白萝卜感觉似乎可以吃了，征求过李老板后我带着极强的罪恶感，跳到菜园子里拔了三个萝卜，可惜只有一个大点的，心里不禁内疚起来。“妈呀，柿子、南瓜、白萝卜，李老板的后备箱放不下了……”，不知谁说了一声惹得大家哈哈大笑。终于可以打道回府了，每个人的脸上都洋溢着深深的满足感，开心的嘴都合不拢……\n\n这是一次愉快的郊游，大家都暂时放下繁忙的工作，全身心真正地回归大自然，竟是如此的惬意。以至于让我们每个人流连往返，不忍离去。我亲爱的挚友们，他日等闲，携一壶美酒，静坐竹林，闭目听风，山水过往，定与你们不醉不归……','<p>深秋是天高气爽风轻云淡的那一丝微笑，深秋是草木退去浓绿后绚丽的五彩斑斓，深秋更是姗姗来迟者的喜上眉梢。</p>\n<p>我们一行四人迎着暖阳，沿着高速公路向竹林关进发，一路欢声笑语不用多说。临近中午参观完魔芋加工厂后准备去土门公社吃午饭。车子沿着一条依山傍水的小路蜿蜒前行。正在大家感叹“柳暗花明又一村”的时候，土门公社到了。土门公社在小溪的对面，许是这深秋的凉意，让从未来过的我感到些许冷清。过了小石桥我们来到小小的院落，里面一个大大的石盘碾子很是显眼，墙上挂着已经风干了的辣椒、大蒜、葫芦等作为农家饭庄的点缀，虽然已经褪色变形，但依稀能够感觉到这里曾经的热闹和红火。进到里面差不多有六间左右的不同公社风格的包间，由于是原地改造加上现在所处的季节，每个包间里都弥漫着刺鼻的霉变味道，采光也不是很好显得更幽暗而沉闷。于是我建议大家在一排像员工宿舍一样的标准间前面的院子里吃饭，那里正好有长条桌凳。院子尽头便是溪流，我们趴着围栏向下看，溪堤有差不多五米高，水草游鱼清晰可见，叮叮咚咚的流水声很是悦耳，深深吸一口没有污染和杂质的空气顿时感觉神清气爽。不一会儿一桌子丰盛的饭食便端了上来，可能是时间有点晚了，大家都很饿一阵风卷残云般结束了战斗，个个酒足饭饱的样子很可爱，而我还沉醉在清炒油麦菜的余香里不肯出来。</p>\n<p>休息片刻后，我们换乘李老板的面包车前去参观他的基地。穿过村庄来到一个狭窄、曲折、幽长的山谷，一路虽然颠簸又惊险，我们却很陶醉车窗外原始气息浓厚的秋景。满山遍野的黄色野菊花就着习习凉风带着淡淡的菊香味扑鼻而来;时而看见几只布尔山羊在山坡上悠闲地啃着草;最让大家欢呼雀跃的是那满树红彤彤的柿子，因无人采摘而不堪负重就连那树枝都快要压断了;几经辗转，路越来越窄，看得出李老板对这里的路况了如指掌，才能这样一边耐心跟我们聊天，一边有紧不慢地开着车。终于在一个没有路的山坳里，我们到达了的基地。由因猪瘟被封弃的猪舍到荒芜破败的鸡棚，绕过一大片郁郁葱葱的竹林，我们来到李老板的“老巢”。最让我惊讶的是这里虽是过去旧的三间土墙瓦房但是里面却有监控，竟然还有一个摄像头正常运作着。让我这个做IT小买卖的很是折服，真是难以想象他几年前在这样的深山沟里是怎样做到的啊!心头不由的对这个中等身材和个头的中年男人油然起敬，打心眼里佩服他的毅力和胆识。</p>\n<p>听完李老板的讲解后，我们四人便开始了自由活动。绕过因搬迁而被遗留下的一两栋只剩下残垣断壁的土房子，几株山茱萸自生自灭地生长着，耳边不时传来不知名的鸟儿清脆的叫声，脚下杂草间开着些许野花，空气中夹杂着似有似无的淡淡的花香。这一切都让我们沉醉，每个人脸上都洋溢着孩童般的微笑!大家不约而同地沐浴着阳光，感受着没有凡世杂尘纷扰这大自然的和谐与宁静!“快看”不知谁一声把大家惊醒，顺着手指的方向，哪儿有几颗柿子树，大家立刻动如脱兔般向柿子树飞奔而去，也顾不得因脚下一深一浅而超级搞笑的奔跑动作了，看着满树繁的火红的柿子，像极了一个个精致的小红灯笼真让人应接不暇，我们个个摩拳擦掌、跃跃欲试。“你拉着树枝我来摘”、“不行不行够不着了”、“换地方换地方”、“还是换另外一颗树摘吧!”、“不能一个一个摘，得一支一支的折，这样摘的多”。大家忙得不亦乐乎，直到每个人都拿不下了才肯罢休!把柿子都抱到车上以后，不知谁发现了藤蔓上的小南瓜，因为深秋的温度比较低这些南瓜已经不再生长了，但也足以让我们这些城里人垂涎三尺，你一个我两个不到几分钟就摘了差不多20个。不经意间，我看见地里的白萝卜感觉似乎可以吃了，征求过李老板后我带着极强的罪恶感，跳到菜园子里拔了三个萝卜，可惜只有一个大点的，心里不禁内疚起来。“妈呀，柿子、南瓜、白萝卜，李老板的后备箱放不下了……”，不知谁说了一声惹得大家哈哈大笑。终于可以打道回府了，每个人的脸上都洋溢着深深的满足感，开心的嘴都合不拢……</p>\n<p>这是一次愉快的郊游，大家都暂时放下繁忙的工作，全身心真正地回归大自然，竟是如此的惬意。以至于让我们每个人流连往返，不忍离去。我亲爱的挚友们，他日等闲，携一壶美酒，静坐竹林，闭目听风，山水过往，定与你们不醉不归……</p>\n',2,'2021-09-02 15:38:51','','published');
/*!40000 ALTER TABLE `blog_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
INSERT INTO `blog_category` VALUES (1,'技术文章'),(2,'散文随笔');
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_comment`
--

DROP TABLE IF EXISTS `blog_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_comment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `is_author` tinyint(1) NOT NULL DEFAULT '0',
  `parent_id` int(10) unsigned DEFAULT NULL,
  `root_id` int(10) unsigned DEFAULT NULL,
  `article_id` int(10) unsigned NOT NULL,
  `content` varchar(255) NOT NULL,
  `created_time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `article` (`article_id`),
  KEY `parent` (`parent_id`),
  KEY `root` (`root_id`),
  CONSTRAINT `article` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parent` FOREIGN KEY (`parent_id`) REFERENCES `blog_comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `root` FOREIGN KEY (`root_id`) REFERENCES `blog_comment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_comment`
--

LOCK TABLES `blog_comment` WRITE;
/*!40000 ALTER TABLE `blog_comment` DISABLE KEYS */;
INSERT INTO `blog_comment` VALUES (1,'taishan',0,NULL,NULL,1,'nice, it\'s very good','2021-09-02 14:10:17');
/*!40000 ALTER TABLE `blog_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_soup`
--

DROP TABLE IF EXISTS `blog_soup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_soup` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `content` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_soup`
--

LOCK TABLES `blog_soup` WRITE;
/*!40000 ALTER TABLE `blog_soup` DISABLE KEYS */;
INSERT INTO `blog_soup` VALUES (1,'你全心全力做到的最好\r\n可能还不如别人的随便搞搞'),(2,'越努力，越幸运！'),(3,'去年今日此门中，人面桃花相映红。'),(4,'疏影横斜水清浅，暗香浮动月黄昏。'),(5,'沧海月明珠有泪，蓝田日暖玉生烟。');
/*!40000 ALTER TABLE `blog_soup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_staff`
--

DROP TABLE IF EXISTS `blog_staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_staff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cn_name` varchar(255) DEFAULT NULL,
  `en_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_staff`
--

LOCK TABLES `blog_staff` WRITE;
/*!40000 ALTER TABLE `blog_staff` DISABLE KEYS */;
INSERT INTO `blog_staff` VALUES (2,'刘荣煌','liu ronghuang ','15958033582'),(3,'蒋韵雯','jiang yunwen','15601761942'),(4,'彭培培','peng peipei ','18317053698'),(12,'threebody','AD3','15921012556'),(17,'陈妮那','chen nina','18761733338');
/*!40000 ALTER TABLE `blog_staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag`
--

DROP TABLE IF EXISTS `blog_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_tag` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(16) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag`
--

LOCK TABLES `blog_tag` WRITE;
/*!40000 ALTER TABLE `blog_tag` DISABLE KEYS */;
INSERT INTO `blog_tag` VALUES (1,'go'),(2,'vue'),(3,'散文');
/*!40000 ALTER TABLE `blog_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_tag_article`
--

DROP TABLE IF EXISTS `blog_tag_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_tag_article` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag_id` int(10) unsigned NOT NULL,
  `article_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tag_id` (`tag_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `article_id` FOREIGN KEY (`article_id`) REFERENCES `blog_article` (`id`),
  CONSTRAINT `tag_id` FOREIGN KEY (`tag_id`) REFERENCES `blog_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_tag_article`
--

LOCK TABLES `blog_tag_article` WRITE;
/*!40000 ALTER TABLE `blog_tag_article` DISABLE KEYS */;
INSERT INTO `blog_tag_article` VALUES (1,1,1),(2,2,1),(3,3,2);
/*!40000 ALTER TABLE `blog_tag_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_user`
--

DROP TABLE IF EXISTS `blog_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(16) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `introduction` varchar(255) DEFAULT NULL,
  `nickname` varchar(32) DEFAULT NULL,
  `about` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_user`
--

LOCK TABLES `blog_user` WRITE;
/*!40000 ALTER TABLE `blog_user` DISABLE KEYS */;
INSERT INTO `blog_user` VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e','https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2884107401,3797902000&fm=26&gp=0.jpg','a gopher','gopher','**Inceptio Cloud**');
/*!40000 ALTER TABLE `blog_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_visitor`
--

DROP TABLE IF EXISTS `blog_visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_visitor` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) NOT NULL COMMENT '访问路径',
  `referer` varchar(255) DEFAULT '',
  `ua` varchar(255) NOT NULL COMMENT 'user_agent',
  `ip` varchar(64) NOT NULL,
  `visit_date` varchar(64) NOT NULL,
  `visit_time` varchar(255) NOT NULL COMMENT '访问时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_visitor`
--

LOCK TABLES `blog_visitor` WRITE;
/*!40000 ALTER TABLE `blog_visitor` DISABLE KEYS */;
INSERT INTO `blog_visitor` VALUES (1,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:22:07'),(2,'/api/v1/articles?page=1&limit=10','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:25'),(3,'/api/v1/categories','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:29'),(4,'/api/v1/tags','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:32'),(5,'/api/v1/user/about','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:32'),(6,'/api/v1/articles?page=1&limit=10','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:37'),(7,'/api/v1/articles?page=1&limit=10','http://192.168.126.156:9528/admin','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-24','2021-08-24 17:22:47'),(8,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:24:53'),(9,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:25:15'),(10,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:25:26'),(11,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:25:44'),(12,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-24','2021-08-24 17:25:53'),(13,'/api/v1/user/about','','PostmanRuntime/7.28.3','127.0.0.1','2021-08-24','2021-08-24 17:46:41'),(14,'/api/v1/tags','','PostmanRuntime/7.28.3','127.0.0.1','2021-08-24','2021-08-24 17:47:05'),(15,'/api/v1/articles','','PostmanRuntime/7.28.3','127.0.0.1','2021-08-24','2021-08-24 17:47:30'),(16,'/api/v1/articles/1','','PostmanRuntime/7.28.3','127.0.0.1','2021-08-24','2021-08-24 17:48:10'),(17,'/api/v1/tags?=test','','PostmanRuntime/7.28.3','127.0.0.1','2021-08-24','2021-08-24 17:49:11'),(18,'/api/v1/user/about','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-25','2021-08-25 14:25:07'),(19,'/api/v1/articles?page=1&limit=10','http://192.168.126.156:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','192.168.126.156','2021-08-30','2021-08-30 09:40:37'),(20,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-30','2021-08-30 09:40:37'),(21,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-30','2021-08-30 09:40:43'),(22,'/api/v1/articles?page=1&limit=10','http://localhost:9528/admin','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-30','2021-08-30 09:40:47'),(23,'/','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-30','2021-08-30 09:45:41'),(24,'/','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-08-31','2021-08-31 13:50:30'),(25,'/test','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-01','2021-09-01 17:48:53'),(26,'/api/v1/articles','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-01','2021-09-01 17:48:59'),(27,'/api/v1/tags','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-01','2021-09-01 17:50:13'),(28,'/api/v1/staff','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-01','2021-09-01 19:26:35'),(29,'/api/v1/staff','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-01','2021-09-01 19:27:02'),(30,'/api/v1/tags','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 10:48:25'),(31,'/api/v1/tags','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:09:11'),(32,'/api/v1/tags','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:09:39'),(33,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:09:47'),(34,'/api/v1/user/about','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:11:10'),(35,'/api/v1/user/articles','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:11:27'),(36,'/api/v1/articles','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:11:33'),(37,'/api/v1/articles','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:12:07'),(38,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:12:13'),(39,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:08'),(40,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:09'),(41,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:10'),(42,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:10'),(43,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:10'),(44,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:11'),(45,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:11'),(46,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:11'),(47,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:11'),(48,'/api/v1/staff','','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 11:18:12'),(49,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 13:55:21'),(50,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 14:07:27'),(51,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 14:07:32'),(52,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 14:07:34'),(53,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 14:07:36'),(54,'/api/v1/articles/1','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-02','2021-09-02 14:07:39'),(55,'/api/v1/articles?page=1&limit=10','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-09','2021-09-09 16:06:58'),(56,'/api/v1/articles/2','http://localhost:9528/','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36','127.0.0.1','2021-09-09','2021-09-09 16:07:03');
/*!40000 ALTER TABLE `blog_visitor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-16 16:33:31
