	function foo (a)
       print("foo", a)
       return coroutine.yield(2*a)
     end

     co = coroutine.create(function (a,b)
           print("co-body", a, b)
           local r = foo(a+1)--ִ�е�yieldҲ�����
           print("co-body", r)
           local r, s = coroutine.yield(a+b, a-b)--r,s����resume���ݽ����Ĳ���
           print("co-body", r, s)
           return b, "end"
     end)

     print("main", coroutine.resume(co, 1, 10))
     print("main", coroutine.resume(co, "r"))
     print("main", coroutine.resume(co, "x", "y"))
	 print("main", coroutine.resume(co, "x", "y"))--�����Ĳ�����resume
