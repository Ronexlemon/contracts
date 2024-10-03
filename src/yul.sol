// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Yul {
    function power(int base, int exponent) external pure returns (int256 result) {
        assembly {
            switch exponent
            case 0 { result := 1 } // Any number to the power of 0 is 1
            case 1 { result := base } // Any number to the power of 1 is the number itself
            default {
                result := 1 // Initialize result to 1
                let b := base
                for { } gt(exponent, 0) { } {
                    switch mod(exponent, 2)
                    case 1 { result := mul(result, b) } // Multiply result by base if exponent is odd
                    b := mul(b, b) // Square the base
                    exponent := div(exponent, 2) // Divide the exponent by 2
                }
            }
        }
    }

    //function two

    function power2(int base, int exponent)external  pure returns(int256 result){
        assembly{
            result := 1

            for {let i:=0} lt(i,exponent) {i := add(i,1)}{
                result := mul(result,base)
            }

        }
    }
}
