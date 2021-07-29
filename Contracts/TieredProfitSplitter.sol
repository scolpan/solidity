pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        amount = points * 23;
        
        // Step 2: Add the `amount` to `total` to keep a running total
        total += amount;
        
        // Step 3: Transfer the `amount` to the employee
        employee_one.transfer(amount);
        
        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        amount = points * 33;
        total += amount;
        employee_two.transfer(amount);
        
        //Bob gets the lions share in this company.
        amount = points * 43;
        total += amount;
        employee_three.transfer(amount);
        
        employee_three.transfer(msg.value - total); // Bob gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}
