m = require "module" --如果不执行 就无法访问到全局的module，module可以定义为local的，此时就不可再访问了
module:Fun()
--m:Fun()
print(module.a)
--print(m.a)

