
local old;
old = hookfunction(game.HttpGet, function(a,b,...)
    appendfile("http.txt","   [-] Method: Http Get".." | Url: "..b.."\n")
    return old(a,b,...) 
end)
print("     [-] Applied http get hook\n")

local old;
old = hookfunction(game.HttpGetAsync, function(a,b,...)
    appendfile("http.txt","   [-] Method: Http Get Async".." | Url: "..b.."\n")
    return old(a,b,...) 
end)
print("     [-] Applied http get async hook\n")

if fluxus then
local old;
old = hookfunction(game.HttpPost, function(a,b,...)
    appendfile("http.txt","   [-] Method: Http Post".." | Url: "..b.."\n")
    return old(a,b,...) 
end)
print("     [-] Applied http post hook\n")

local old;
old = hookfunction(game.HttpPostAsync, function(a,b,...)
    appendfile("http.txt","   [-] Method: Http Post Async".." | Url: "..b.."\n")
    return old(a,b,...) 
end)
print("     [-] Applied http post async hook\n")
end

local request = http_request or request or syn.request or fluxus.request
request = function(data)
    appendfile("http.txt","   [-] Method: Request".." | Url: "..data.Url.."\n")
    return request(data)
end
print("     [-] Applied request hook\n\n")