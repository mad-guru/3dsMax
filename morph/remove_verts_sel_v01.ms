/* create remove_ary
temp_ary=getvertselection $

for a in temp_ary do (print (a as string+","))
*/

for cur_obj in selection do
(
	new_vert_ary=#()
	vert_ary=polyop.getVertSelection cur_obj
	
remove_ary=#(18,
19,
21,
139,
387,
1840,
1841,
1842,
1843,
1844,
1845,
1849,
1865,
1880,
1881,
1885,
1886,
1887,
1888,
1889,
1890,
1891,
1895,
1896,
1992,
1993,
1994,
1995,
1996,
1997,
1998,
1999,
2000,
2001,
2002,
2003,
2004,
2005,
2014,
2015,
2016,
2017,
2018,
2041,
2043,
2046,
2048,
2051,
2195,
2242,
2243,
2303,
2307,
2322,
2331,
2355,
2362,
2382,
2387,
2403,
2415,
2439,
2461,
2462,
2463,
2478,
2616,
2625,
3018,
3021,
3030,
4015,
4016,
4017,
4020)

	cur_obj.useSoftSel =false

	for ary_item in remove_ary do
		(
		del_num=findItem vert_ary ary_item
		if del_num!=0 do (deleteItem vert_ary del_num)
		)
		new_vert_ary=copy vert_ary
polyop.setVertSelection cur_obj new_vert_ary
	cur_obj.useSoftSel =true
	cur_obj.ssUseEdgeDist=true
	cur_obj.ssEdgeDist=1
)