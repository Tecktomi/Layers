function buscar_micelio(ex, ey, capa){
	with control{
	    for(var r = 1; r < 10; r++){
	        for(var dx = -r; dx <= r; dx++){
	            var x1 = ex + dx
	            if x1 >= 0 and x1 < xsize{
					var y1 = ey - r
	                if y1 >= 0 and y1 < ysize and micelio[capa][# x1, y1] > 0
						return [x1, y1]
					y1 = ey + r
	                if y1 >= 0 and y1 < ysize and micelio[capa][# x1, y1] > 0
						return [x1, y1]
	            }
	        }
	        for(var dy = -r + 1; dy <= r - 1; dy++){
	            var y1 = ey + dy
	            if y1 >= 0 and y1 < ysize{
					var x1 = ex - r
	                if x1 >= 0 and x1 < xsize and micelio[capa][# x1, y1] > 0
						return [x1, y1]
					x1 = ex + r
	                if x1 >= 0 and x1 < xsize and micelio[capa][# x1, y1] > 0
						return [x1, y1]
	            }
	        }
	    }
	    return [-1, -1]
	}
}