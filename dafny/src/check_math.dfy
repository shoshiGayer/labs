include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"


import opened Number
import opened Maps
import opened Tx


class Check_math{




 function Add(x: u256, y: u256) : u256 
    requires (x as nat) + (y as nat) <= MAX_U256 as nat
    ensures (x as nat) + (y as nat) <= MAX_U256 as nat{
        x + y
    }

    function Sub(x: u256, y: u256) : u256
    requires (x as nat) - (y as nat) >= 0 as nat 
    ensures (x as nat) - (y as nat) >= 0 as nat{
        x - y
    }

function Mul(x: u256,y:u256): u256
requires (x as nat) * (y as nat) <= MAX_U256 as nat 
ensures (x as nat) * (y as nat) <= MAX_U256
{
    x*y
}
function Div(x: u256,y:u256): u256
requires (y as nat) > 0 as nat && (x as nat) / (y as nat) <= MAX_U256 as nat  
ensures (x as nat) / (y as nat) <= MAX_U256 as nat  {
    x/y
}

function Mod(x: u256,y:u256): u256
requires (y as nat) > 0 as nat {
    x%y
}
function GetExp(x:u256 , y:u256) : u256

}


