local gc=love.graphics
local gc_translate,gc_scale=gc.translate,gc.scale
local gc_setColor=gc.setColor
local gc_rectangle=gc.rectangle

local min=math.min

local S={}
S.base='puyo_default'

local function drawSide(B,x,y,bx,by)
    local c=B[y][x].color
    if B[y  ] and B[y  ][x+1] and B[y  ][x+1].color==c then gc_rectangle('fill',bx+40, by+8,  -5,24) end
    if B[y  ] and B[y  ][x-1] and B[y  ][x-1].color==c then gc_rectangle('fill',bx,    by+8,  5 ,24) end
    if B[y-1] and B[y-1][x  ] and B[y-1][x  ].color==c then gc_rectangle('fill',bx+8,  by+40, 24,-5) end
    if B[y+1] and B[y+1][x  ] and B[y+1][x  ].color==c then gc_rectangle('fill',bx+8,  by,    24, 5) end
end

function S.drawFieldCells(F)
    F=F._matrix
    for y=1,#F do for x=1,#F[1] do
        local C=F[y][x]
        if C then
            gc_setColor(ColorTable[C.color])
            gc_rectangle('fill',(x-1)*40,-y*40,40,40,18)
            drawSide(F,x,y,(x-1)*40,-y*40)
        end
    end end
end

function S.drawHand(B,handX,handY)
    for y=1,#B do for x=1,#B[1] do
        if B[y][x] then
            local bx,by=(handX+x-2)*40,-(handY+y-1)*40
            gc_setColor(ColorTable[B[y][x].color])
            gc_rectangle('fill',bx,by,40,40,18)
            drawSide(B,x,y,bx,by)
        end
    end end
end

function S.drawNext(n,B)
    gc.push('transform')
    gc_translate(100,100*n-50)
    gc_scale(min(2.3/#B,3/#B[1],.86))
    for y=1,#B do for x=1,#B[1] do
        if B[y][x] then
            local bx,by=(x-#B[1]/2-1)*40,(y-#B/2)*-40
            gc_setColor(ColorTable[B[y][x].color])
            gc_rectangle('fill',bx,by,40,40,18)
            drawSide(B,x,y,bx,by)
        end
    end end
    gc.pop()
end

return S