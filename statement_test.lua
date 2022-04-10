a={index=1,name= "xx"}
print(a.index)

a ={}--�ظ�����ͻḲ�ǵ�ȫ�ֱ�����module
print(a.name)

-- or �߼�����
print(a.name or "name is nil")

--�쳣����
local finish,msg = pcall(a.err)

if finish then
print("finish")
else
print("err:"..msg)
end

--�ַ�������
a.name="123321"
--���鳤��
a.name={1,2,3}
print(#a.name)

--��������
local function testFun()
	print("test_fun")
end

local f;
f = function()
	print("test_fun")
end

f()

--����� �෵��ֵ ��������
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
	for	i=1,2 do --�����ڱ��ʽ��ִֻ��һ��
		local function f()
			var= var+1
			closerLog(var)--ÿ�ε���var��������,��ͬһ��var
			i=i+2
			closerLog(i)--ÿ��ѭ����i����һ���µ��ڴ�
		end

		funList[i] = f
	end
end

closerTest()
funList[1]() --101 3
funList[2]() --102 4 ��c#�ıհ���ͬ c#�����22
funList[2]() --104 6
funList[1]() --105 5

--upvalue ʼ����ͬ
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
f1()        -- ��ӡ:2015

f2()
f1()        -- ��ӡ:2025

g1,g2 = t()
g1()        -- ��ӡ:2025

g2()
g1()        -- ��ӡ:2035

f1()        -- ��ӡ:2035


--ö������ʵ��
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
