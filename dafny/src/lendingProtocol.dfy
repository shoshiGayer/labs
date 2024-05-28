
include "util/number.dfy"
include "util/maps.dfy"
include "util/tx.dfy"
include "util/math2.dfy"


import opened Number
import opened Maps
import opened Tx
import opened Fixed

class LendingProtocol{
    var baseRate:u256
    var totalBorrowed:u256
    var totalDeposit:u256
    var WAD:u256
    var fixedAnnuBorrowRate:u256
    constructor() {
        baseRate:= 20000000000000000;
        WAD:=100000000000000000000;
        fixedAnnuBorrowRate:= 300000000000000000;
    }
    
    method calculateBorrowFee(amount:u256) returns (fee:u256 , paid: u256)
    {
    var borrowRate:= borrowRate();
    var (successMul, feeTmp) := tryMul(amount, borrowRate);
        if !successMul || feeTmp > MAX_U256 {
            fee := 0;
            paid := amount;
            return;
        }
    //fee:= tryMul(amount,borrowRate);
    paid:= Sub(amount,fee);
    }
    method getExp(num: u256, denom: u256) returns (rational: u256)
        requires num >= 0 && denom > 0
        requires denom !=0
        requires (num as nat) * (denom as nat) <= MAX_U256 as nat
        ensures rational >= 0
    {
        var number := Fixed.Mul(num,WAD);
        var result := Fixed.Div(number, denom);
        rational := result;
    }
     method utilizationRatio() returns (uRatio: u256)
        ensures uRatio >= 0
    {
        uRatio := getExp(totalBorrowed, totalDeposit);
    }
    method interestMultiplier() returns (interestMul: u256)
        ensures interestMul >= 0
    {
        var uRatio := utilizationRatio();
        var num := Sub(fixedAnnuBorrowRate, baseRate);
        interestMul := getExp(num,uRatio);
    }

    method borrowRate() returns (borrowRate: u256)
        ensures borrowRate >= 0
    {
        var uRatio := utilizationRatio();
        var interestMul := interestMultiplier();
        var product := Mul(uRatio, interestMul);
        borrowRate := Fixed.Add(product, baseRate);
    }
    
  }

