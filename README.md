# shopping-cart kata
This kata is a simplified cli shopping cart total calculator app. 


## Execute  

* Run `$ stack exec -- shopping-cart-exe` to start the shopping cart app

### Using the App
When prompted, simply type in the item that you want and the quantity you want it in. 
For example, to add 4 items of A to your cart, just type 
`A 4`


### How the total is calculated
For each item, there is either a sale or not a sale. We will illustrate the algorithm with 
the following shopping cart. 

A 5
B 3
C 2

We will assume all of these items are usually 5.00 each, with a sale of 3 for 12.00.   
A's total will be 22.00 (3 at the sale price and 2 at the regular price)
B's total will be 12.00 (3 at the sale price and 0 at the regular price)
C's total will be 10.00 (0 at the sale price and 2 at the regular price)

## Run tests

To run the tests, run
`$ stack test`
