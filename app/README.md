# Example

A variant of the Nim game where players can pick the board of their choice.

### Output

```
cabal run
Build profile: -w ghc-8.10.7 -O1
In order, the following will be built (use -v for more details):
 - nim-0.1.0.0 (exe:nim) (file src/Board.hs changed)
Preprocessing executable 'nim' for nim-0.1.0.0..
Building executable 'nim' for nim-0.1.0.0..
[1 of 3] Compiling Board            ( src/Board.hs, /home/srinathln7/Desktop/emurgo-project/dist-newstyle/build/x86_64-linux/ghc-8.10.7/nim-0.1.0.0/x/nim/build/nim/nim-tmp/Board.o )
[2 of 3] Compiling Nim              ( src/Nim.hs, /home/srinathln7/Desktop/emurgo-project/dist-newstyle/build/x86_64-linux/ghc-8.10.7/nim-0.1.0.0/x/nim/build/nim/nim-tmp/Nim.o ) [Board changed]
Linking /home/srinathln7/Desktop/emurgo-project/dist-newstyle/build/x86_64-linux/ghc-8.10.7/nim-0.1.0.0/x/nim/build/nim/nim ...

***********************************************************************************************************************************************************************************************************
                                                                   Welcome to the Variant NIM game
***********************************************************************************************************************************************************************************************************

Enter the total number of rows you want in the board: 
7

Constructing the Nim game board

1: " *  *  *  *  *  *  * "

2: " *  *  *  *  *  * "

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: " * "

                                                                   "PLAYING now  - PLAYER_1"

Enter row number: 
1

Enter number of stars to remove: 
4


1: " *  *  * "

2: " *  *  *  *  *  * "

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: " * "

                                                                   "PLAYING now  - PLAYER_2"

Enter row number: 
2

Enter number of stars to remove: 
3


1: " *  *  * "

2: " *  *  * "

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: " * "

                                                                   "PLAYING now  - PLAYER_1"

Enter row number: 
7

Enter number of stars to remove: 
1


1: " *  *  * "

2: " *  *  * "

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_2"

Enter row number: 
1

Enter number of stars to remove: 
3


1: ""

2: " *  *  * "

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_1"

Enter row number: 
2

Enter number of stars to remove: 
3


1: ""

2: ""

3: " *  *  *  *  * "

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_2"

Enter row number: 
3

Enter number of stars to remove: 
5


1: ""

2: ""

3: ""

4: " *  *  *  * "

5: " *  *  * "

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_1"

Enter row number: 
4

Enter number of stars to remove: 
4


1: ""

2: ""

3: ""

4: ""

5: " *  *  * "

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_2"

Enter row number: 
5

Enter number of stars to remove: 
3


1: ""

2: ""

3: ""

4: ""

5: ""

6: " *  * "

7: ""

                                                                   "PLAYING now  - PLAYER_1"

Enter row number: 
6

Enter number of stars to remove: 
2


1: ""

2: ""

3: ""

4: ""

5: ""

6: ""

7: ""

                                                                   PLAYER_1 WINS !!!

```
