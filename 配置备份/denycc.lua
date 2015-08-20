--==================================================
--nginx配置文件中http段添加以下内容
--==================================================
--lua_package_path "/opt/nginx/conf/lua/?.lua";
--lua_shared_dict limit 10m;
--init_by_lua_file  /opt/nginx/conf/lua/fun.lua;
--access_by_lua_file /opt/nginx/conf/lua/denycc.lua;
--==================================================

--默认为(120/60)60秒内访问次数超过120次视为CC攻击
local CCrate = "120/60"
--白名单文件
local whitefile = "/opt/nginx/conf/lua/whiteip.txt"
--黑名单文件
local blockfile = "/opt/nginx/conf/lua/blockip.txt"

local whiteip = read(whitefile)
local blockip = read(blockfile)

--白名单放行
if dowhiteip(whiteip) then
--黑名单拒绝
elseif doblockip(blockip) then
--拒绝CC攻击并写入IP至黑名单
elseif denycc(CCrate, blockfile) then
--干掉恶意软件扫描报HTTP 444
elseif ngx.var.http_Acunetix_Aspect then
    ngx.exit(444)
elseif ngx.var.http_X_Scan_Memo then
    ngx.exit(444)
end