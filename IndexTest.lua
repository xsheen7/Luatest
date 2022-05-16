local a={}

local b={
    name="xixi";
    
    __index= function()
        print("call index")
    end;
    
    __newindex= function()
        print("call new index")
    end;
}

setmetatable(a,{ __index =b })

print(a.name)
print(a.age)
