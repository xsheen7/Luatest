local class ={}
class.name="private"
function class.Fun()
	print("call class fun")
end


module ={}
module.a=100
module.s="haha"

function module:Fun( ... )
	-- body
	class.Fun()
	self.a = self.a+1
	print(class.name)
end

return module
