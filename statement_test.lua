a={index=1,name= "xx"}
print(a.index)

a ={}--重复定义就会覆盖掉全局变量的module
print(a.name)

-- or 逻辑运算
print(a.name or "name is nil")

--异常捕获
local finish,msg = pcall(a.err)

if finish then
print("finish")
else
print("err:"..msg)
end

--字符串长度
a.name="123321"
--数组长度
a.name={1,2,3}
print(#a.name)

--函数定义
local function testFun()
	print("test_fun")
end

local f;
f = function()
	print("test_fun")
end

f()

--多参数 多返回值 匿名函数
local f = function(...)
	print("test fun")
	for i,v in pairs {...}
	do
	print(i,v)
	--return i,v
	end
end

testFun()
f(1,2,3)

--closer

function closerLog(i)
	print("closer "..i)
end

local funList={ fun1,fun2}

function closerTest()
	local var = 100
	for	i=1,2 do --若存在表达式，只执行一次
		local function f()
			var= var+1
			closerLog(var)--每次调用var都会运算,是同一个var
			i=i+2
			closerLog(i)--每次循环的i都是一个新的内存
		end

		funList[i] = f
	end
end

closerTest()
funList[1]() --101 3
funList[2]() --102 4 和c#的闭包不同 c#的输出22
funList[2]() --104 6
funList[1]() --105 5

--upvalue 始终相同
function Test(n)
   local function foo()
      local function inner1()
         print(n)
      end
      local function inner2()
         n = n + 10
      end
      return inner1,inner2
   end
   return foo
end
t = Test(2015)
f1,f2 = t()
f1()        -- 打印:2015

f2()
f1()        -- 打印:2025

g1,g2 = t()
g1()        -- 打印:2025

g2()
g1()        -- 打印:2035

f1()        -- 打印:2035


--枚举器的实现
function values(t)
	local i = 0
	return function () i = i + 1 return t[i] end
end

t = {10, 20, 30}

iter = values(t)
while true do
	local element = iter()
	if element == nil then break end
	print(element)
end
