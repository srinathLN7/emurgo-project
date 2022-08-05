# Nim 

Implementation of **variant of the game of Nim** in Haskell. It is played on a board comprising five numbered rows of stars, initially set up as follows:

### Standard Nim 

Two players then take it in turn to remove one or more stars from the end of a single row. The winner is the player who makes the board empty, that is who removes the final star of stars from the board.


```
1: "*****"

2: "****"

3: "***"

4: "**"

5: "*"

```


### Output


```
Prelude> :l nim.hs
[1 of 1] Compiling Nim              ( nim.hs, interpreted )
Ok, one module loaded.
*Nim> nim

1: "*****"

2: "****"

3: "***"

4: "**"

5: "*"

"Playing now --> Player:1"

Enter row number: 1
Enter number of stars to remove: 5

1: ""

2: "****"

3: "***"

4: "**"

5: "*"

"Playing now --> Player:2"

Enter row number: 2
Enter number of stars to remove: 4

1: ""

2: ""

3: "***"

4: "**"

5: "*"

"Playing now --> Player:1"

Enter row number: 3
Enter number of stars to remove: 3

1: ""

2: ""

3: ""

4: "**"

5: "*"

"Playing now --> Player:2"

Enter row number: 4
Enter number of stars to remove: 2

1: ""

2: ""

3: ""

4: ""

5: "*"

"Playing now --> Player:1"

Enter row number: 5
Enter number of stars to remove: 1

1: ""

2: ""

3: ""

4: ""

5: ""

Player 1 wins!!!
*Nim>  
```

### Variant of the Game of Nim

A standard Nim board always comprises of 5 Rows. In the **variant version**, we construct the Nim board with arbitrary number of rows as per the players choice. 
