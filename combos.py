def num_ones(number):
    num_str = format(number, 'b')
    count = 0
    for digit in num_str:
        if digit == "1":
            count += 1
    return count


# Combinations of neighbor states with two or three neighbors alive,
# which for a living cell means that it will remain living in the next tick
def living():
    for i in range(0,256):
        n_ones = num_ones(i)
        if n_ones == 2 or n_ones == 3:
            out_str = "8\'b" + format(i,'08b') + ":\n\tnext_board[i][j] <= 1;"
            print(out_str)

# Combinations of neighbor states with exactly two neighbors alive,
# which for a currently dead cell means that it will become living in the next tick
def dead():
    for i in range(0,256):
        n_ones = num_ones(i)
        if n_ones == 3:
            out_str = "8\'b" + format(i,'08b') + ":\n\tnext_board[i][j] <= 1;"
            print(out_str)



if __name__ == "__main__":
    dead()






