####sed用法示例####
##操作文本名称：datafile
#文本内容：
Steve Blenheim:238-923-7366:95 Latham Lane, Easton, PA 83755:11/12/56:20300
Betty Boop:245-836-8357:635 Cutesy Lane, Hollywood, CA 91464:6/23/23:14500
Igor Chevsky:385-375-8395:3567 Populus Place, Caldwell, NJ 23875:6/18/68:23400
Norma Corder:397-857-2735:74 Pine Street, Dearborn, MI 23874:3/28/45:245700
Jennifer Cowan:548-834-2348:583 Laurel Ave., Kingsville, TX 83745:10/1/35:58900
Jon DeLoach:408-253-3122:123 Park St., San Jose, CA 04086:7/25/53:85100

Karen Evich:284-758-2857:23 Edgecliff Place, Lincoln , NB 92743:7/25/53:85100
Karen Evich:284-758-2867:23 Edgecliff Place, Lincoln, NB 92743:11/3/35:58200
Karen Evich:284-758-2867:23 Edgecliff Place, Lincoln, NB 92743:11/3/35:58200

Fred Fardbarkle:674-843-1385:20 Parak Lane, Duluth, MN 23850:4/12/23:780900
Fred Fardbarkle:674-843-1385:20 Parak Lane, Duluth, MN 23850:4/12/23:780900
Lori Gortz:327-832-5728:3465 Mirlo Street, Peabody, MA 34756:10/2/65:35200
Paco Gutierrez:835-365-1284:454 Easy Street, Decatur, IL 75732:2/28/53:123500

Ephram Hardy:293-259-5395:235 CarltonLane, Joliet, IL 73858:8/12/20:56700
James Ikeda:834-938-8376:23445 Aster Ave., Allentown, NJ 83745:12/1/38:45000
Barbara Kertz:385-573-8326:832 Ponce Drive, Gzary, IN 83756:12/1/46:268500
Lesley Kirstin:408-456-1234:4 Harvard Square, Boston, MA 02133:4/22/62:52600
William Kopf:846-836-2837:6937 Ware Road, Milton, PA 93756:9/21/46:43500
Sir Lancelot:837-835-8257:474 Camelot Boulevard, Bath, WY 28356:5/13/69:24500
Jesse Neal:408-233-8971:45 Rose Terrace, San Francisco, CA 92303:2/3/36:25000
Zippy Pinhead:834-823-8319:2356 Bizarro Ave., Farmount, IL 84357:1/1/67:89500
Arthur Putie:923-835-8745:23 Wimp Lane, Kensington, DL 38758:8/31/69:126000
Popeye Sailor:156-454-3322:945 Bluto Street, Anywhere, USA 29358:3/19/35:22350
Jose Santiago:385-898-8357:38 Fife Way, Abilene, TX 39673:1/5/58:95600
Tommy Savage:408-724-0140:1222 Oxbow Court, Sunnyvale, CA 94087:5/19/66:34200
Yukio Takeshida:387-827-1095:13 Uno Lane, Ashville, NC 23556:7/1/29:57000
Vinh Tranh:438-910-7449:8235 Maple Street, Wilmington, VM 29085:9/23/63:68900
####1.显示1-5行('p'参数:为打印参数，'n'参数:使用silent模式)
用法：
	sed -n '1,5p' datafile
####2.删除头三行####
用法：
	sed '1,3d' datafile
####3.过滤掉不带'Lane'的行####
用法：
	sed '/Lane/d' datafile
####用cat 组合 grep 实现：
用法：
	cat -n datafile |grep -v 'Lane'
####4.去除空行####
用法：
	sed '/^$/d' datafile
#使用cat+grep方法：
	cat datafile |grep -v '^$'
#使用cat+tr方法：
	cat datafile |tr -s '\n'
#使用grep方法：
	grep -v '^$' datafile
#使用awk方法：

####5.去掉重复行####
用法：
	sort -u datafile
	sort -k2n datafile |uniq
####6.替换字符串####
用法：s 是普通替换，默认替换第一个。 加上g参数后替换全局
	sed -i "s/Fred Fardbarkle/Yang Hang/g" datafile
####7.增加一行或多行字符串
用法：i在之前操作，a在数字行后操作
	sed '1i Hello World' datafile		#在行首添加Hello World
	sed '1a Ni Hao' datafile			#在第一行后添加Ni Hao
	sed '1,3a Ni Hao' datafile			#在1到3行每行后面添加Ni Hao
	sed '$a nihao wo shi zuihouyihang' datafile #在最后一行添加nihao wo shi zuihouyihang
####8.匹配行添加其他文本内的内容
用法：
	sed '$r 101' datafile				#最后一行添加101文本内的内容

	
	