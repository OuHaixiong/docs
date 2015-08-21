local iputils = require("iputils")
iputils.enable_lrucache()

--获取客户端IP地址
function getClientIp()
        IP = ngx.req.get_headers()["X-Real-IP"]
        if IP == nil then
                IP = ngx.var.remote_addr
        end
        if IP == nil then
                IP = "unknown"
        end
        return IP
end

--写文件操作
function write(file, msg)
        local fd = io.open(file,"ab")
        if fd == nil then
                return
        end
        fd:write(msg)
        fd:flush()
        fd:close()
end

--读取文件返回数组格式
function read(file)
        local fd = io.open(file,"r")
        local array = {}
        if fd then
                for line in fd:lines() do
                        table.insert(array, line)
                end
                fd:close()
        end
        return iputils.parse_cidrs(array)
end

--白名单
function dowhiteip(ipWhitelist)
        if ipWhitelist ~= nil then
                local clientip = getClientIp()
                if iputils.ip_in_cidrs(clientip, ipWhitelist) then
                        return true
                end
        end
        return false
end

--黑名单
function doblockip(ipBlocklist)
        if ipBlocklist ~= nil then
                local clientip = getClientIp()
                if iputils.ip_in_cidrs(clientip, ipBlocklist) then
                        ngx.exit(403)
                        return true
                end
        end
        return false
end

--拒绝CC攻击
function denycc(CCrate, logfile)
        if CCrate ~= nil and logfile ~= nil then
                local CCcount = tonumber(string.match(CCrate, '(.*)/'))
                local CCseconds = tonumber(string.match(CCrate, '/(.*)'))
                local IP = getClientIp()
                --令牌环(ip+请求文件)
                local token = IP .. ngx.var.uri
                --共享内存
                local limit = ngx.shared.limit
                --获取使用某个令牌请求次数
                local req,_ = limit:get(token)
                if req then
                        --请求次数大于CCcount报HTTP 503
                        if req > CCcount then
                                write(logfile, IP .. "\n")
                                ngx.exit(503)
                                return true
                        else
                        --请求次数小于CCcount加1
                                limit:incr(token, 1)
                        end
                else
                        limit:set(token, 1, CCseconds)
                end
        end
        return false
end
