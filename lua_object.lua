student = {}
--静态字段
student.count=0
--对象字段
student.name=""
--构造函数
function student.New( ... )
	local object = {}
	setmetatable(object,{__index=student})
	a=...--多参数的第一个值赋值给a
	print(a)
	for i,v in ipairs {...} do--将多参数构建为数组
	print("params",i,v)
	end
	object.name=a
	student.count=student.count+1
	return object
end


xm = student.New("xiaoming",100)
print("name",xm.name)
--第一次调用count访问到student的count 后面就是自己的count进行计算
xm.count = xm.count+1
print(xm.count,student.count)
