# ============================================================
# Chapter 2 — Numerics, Arithmetic, Assignment, and Vectors
# ============================================================

# ----------------------------
# 2.1 Numerics & Arithmetic
# ----------------------------

# Basic arithmetic operators: +  -  *  /  ^
2 + 3
10 - 4
6 * 7
8 / 2
2^5  # exponent (power)

# Order of operations (PEMDAS): parentheses, exponents, mult/div, add/sub
2 + 3 * 4        # 2 + (3*4)
(2 + 3) * 4      # parentheses first

# Square root
sqrt(49)

# Logarithm with base
# Example: log base 3 of 243 is 5 because 3^5 = 243
log(x = 243, base = 3)

# Exponential: exp(x) = e^x
exp(x = 3)

# Use log/exp to go back and forth (natural log)
v <- 20
lv <- log(v)     # ln(20)
exp(lv)          # returns 20 (up to tiny floating-point rounding)


# ----------------------------
# E-notation (scientific notation)
# ----------------------------

# R prints very large/small numbers using e-notation (xey = x * 10^y)
big_num <- 2342151012900
big_num

small_num <- 0.00000000023421510129
small_num

# You can create e-notation numbers directly:
2.3421510129e12   # = 2.3421510129 * 10^12
234.21510129e10   # = 234.21510129 * 10^10

# Interpret e-notation by moving decimal:
# 5.1e3 = 5100
5.1e3
options(scipen = 999)
options(scipen = 0)

# ----------------------------
# 2.2 Assigning Objects
# ----------------------------

# Assign with <- (preferred) or =
x <- -5; x

# You can also use "=" (works similarly in simple cases)
mynumber = 36.16
mynumber

y <- mynumber * x
y

# List objects in the workspace
ls()

# Remove objects if needed (optional)
rm(x, mynumber, y, z)

z <- 5
print(z)
z

# ----------------------------
# 2.3 Vectors
# ----------------------------

# 2.3.1 Creating a Vector with c()
myvec <- c(1, 3, 1, 42)
myvec

# Vector entries can include calculations and previously stored objects
foo <- 32.1
myvec2 <- c(5, -2.3, 4, 4, 4, 6, 8, 10, 40221, -8, foo+5^2)
myvec2

# Combine vectors
myvec3 <- c(myvec, myvec2)
myvec3

# A vector can represent a variable (e.g., 5 daily temperatures)
temps <- c(12.1, 13.0, 11.8, 14.2, 13.7)
mean(temps)


# ----------------------------
# 2.3.2 Sequences, rep, sort, length
# ----------------------------

# Colon operator (by 1)
3:27

# Colon can use stored values / parenthesized calculations
foo <- 5.3
bar <- foo:(-47 + 1.5)  # from 5.3 down to -45.5 by -1
bar

# seq(): flexible sequences with from/to/by
seq(from = 3, to = 27, by = 3)

# seq() with fixed length
seq(from = 3, to = 27, length.out = 40)

# Decreasing sequence: by must be negative
foo <- 5.3
myseq <- seq(from = foo, to = (-47 + 1.5), by = -2.4)
myseq

# rep(): repetition
rep(x = 1, times = 4)
rep(x = c(3, 62, 8.3), times = 3)
rep(x = c(3, 62, 8.3), each = 2)
rep(x = c(3, 62, 8.3), times = 3, each = 2)

# sort(): sorting
sort(x = c(2.5, -1, -10, 3.44), decreasing = FALSE)
sort(x = c(2.5, -1, -10, 3.44), decreasing = TRUE)

# length(): number of entries
length(x = myvec)


# ----------------------------
# 2.3.3 Subsetting & Element Extraction with [ ]
# ----------------------------

myvec <- c(5, -2.3, 4, 4, 4, 6, 8, 10, 40221, -8)
length(x = myvec)

# Extract specific elements
myvec[1]
foo <- myvec[2]
foo

# Last element using length()
myvec[length(x = myvec)]

# Negative indexes: remove elements (returns a NEW vector)
myvec[-1]   # all but first

# Index can be a calculation
myvec.len <- length(x = myvec)
qux <- myvec[-(myvec.len - 1)]  # remove second-to-last element
qux

# Subset with a vector of indexes
myvec <- c("A", "B", "K", "L", 'J')
myvec[c(1, 3, 5)]
foo[-c(1, 3)]  # remove elements 1 and 3 from foo

# NOTE: you cannot mix positive and negative indexes in the same index vector.

# Overwrite elements in an existing vector
bar <- c(3, 2, 4, 4, 1, 2, 4, 1, 0, 0, 5)
bar

bar[1] <- 6
bar

# Overwrite a range with a single value (recycled)
bar[7:10] <- 100
bar


# ----------------------------
# 2.3.4 Vector-oriented (element-wise) behavior & recycling
# ----------------------------
foo <- 5.5:0.5
foo

foo - c(2, 4, 6, 8, 10, 12)

# sum and product of vector entries
sum(foo)
prod(foo)

# Overwriting multiple elements (recycling behavior)
foo
foo[c(1, 3, 5, 6)] <- c(-99, 99, 100)  # recycled to fill 4 positions
foo
a[5]

# Recycling demo (evenly divisible vs not)
a <- 1:6
b <- c(10, 100)
a + b

# This will trigger a warning because 5 is not a multiple of 3
a <- 1:5
b <- c(10, 100, 1000)
a + b

# Rescaling: convert centimeters to meters (vectorized)
cm <- c(150, 160, 172)
m <- cm / 100
m

# ============================================================
# Chapter 3 — Matrices and Arrays
# ============================================================

# ----------------------------
# 3.1 Defining a Matrix
# ----------------------------

# Create a matrix with matrix(data=..., nrow=..., ncol=...)
A <- matrix(data = c(-3, 2, 893, 0.17), nrow = 2, ncol = 2)
A

# If you omit nrow/ncol, R returns a single-column matrix by default
matrix(data = c(-3, 2, 893, 0.17))
matrix(data = c(-3, 2, 893, 0.17), nrow = 4, ncol = 1)

# Convert a vector to a 2x3 matrix
v <- 1:6
matrix(v, nrow = 2, ncol = 3)


# ----------------------------
# 3.1.1 Filling Direction (byrow)
# ----------------------------

# Column-wise filling (R default): byrow = FALSE
matrix(data = c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = FALSE)

# Row-wise filling: byrow = TRUE
matrix(data = c(1, 2, 3, 4, 5, 6), nrow = 2, ncol = 3, byrow = TRUE)


# ----------------------------
# 3.1.2 Row and Column Bindings (rbind, cbind)
# ----------------------------

# rbind(): bind vectors as rows
rbind(1:3, 4:6)

# cbind(): bind vectors as columns
cbind(c(1, 4), c(2, 5), c(3, 6))


# Build a matrix from two measurement vectors
heights <- c(170, 165, 180)
weights <- c(65, 55, 78)
m_hw <- cbind(heights, weights)
m_hw


# ----------------------------
# 3.1.3 Matrix Dimensions (dim, nrow, ncol)
# ----------------------------

mymat <- rbind(c(1, 3, 4), 5:3, c(100, 20, 90), 11:13)
mymat

dim(mymat)       # returns c(rows, cols)
nrow(mymat)      # number of rows
ncol(mymat)      # number of cols
dim(mymat)[2]    # extract number of columns using vector subsetting


# ----------------------------
# 3.2 Subsetting
# ----------------------------
# like extract ing elements from vectors
A <- matrix(
  c(0.3, 4.5, 55.3, 91, 0.1, 105.5, -4.2, 8.2, 27.9),
  nrow = 3, ncol = 3
)
A

# Extract single element: [row, column]
A[3, 2]

# 3.2.1 Row, Column, and Diagonal Extractions

# Whole column (leave row blank, keep comma!)
A[, 2]

# Whole row (leave column blank)
A[1, ]

# Multiple rows
A[2:3, ]

# Reorder/select columns
A[, c(3, 1)]

# Combine row + column selection
A[c(3, 1), 2:3]

# Diagonal elements (square matrix)
diag(x = A)
diag(x = 4)

# "Drop" behavior: single row/column becomes a vector
col2 <- A[, 2]
is.vector(col2)
col2


# ----------------------------
# 3.2.2 Omitting and Overwriting
# ----------------------------

# Delete second column
A[, -2]

# Delete first row, then take columns 3:2 (reverse order)
A[-1, 3:2]

# Delete first row and second column
A[-1, -2]

# Delete first row, then delete columns 2 and 3 from the result
# Leaves only a single column -> returned as a vector
A[-1, -c(2, 3)]

# Overwriting elements/rows/cols
B <- A
B

# Overwrite second row with 1:3
B[2, ] <- 1:3
B

# Overwrite elements in column 2 at rows 1 and 3 with 900
B[c(1, 3), 2] <- 900
B

# Replace column 3 with row 3 values
B[, 3] <- B[3, ]
B

# Recycling in replacement: replace (rows 1 and 3, cols 1 and 3) with c(-7, 7)
B[c(1, 3), c(1, 3)] <- c(-7, 7)
B

# Highlight index order in replacement (fills column-wise, and column order matters)
B[c(1, 3), 2:1] <- c(65, -65, 88, -88)
B

# Overwrite diagonal directly using diag()
diag(x = B) <- rep(x = 0, times = 3)
B


# ----------------------------
# Exercises
# ----------------------------

# a) 4x2 matrix filled row-wise with given values
E31_a <- matrix(
  data = c(4.3, 3.1, 8.2, 8.2, 3.2, 0.9, 1.6, 6.5),
  nrow = 4, ncol = 2, byrow = TRUE
)
E31_a

# b) Confirm dimensions are 3x2 if you remove any one row (example: remove row 1)
E31_b <- E31_a[-1, ]
dim(E31_b)

# c) Overwrite second column with sorted version (smallest to largest)
E31_c <- E31_a
E31_c[, 2] <- sort(E31_c[, 2], decreasing = FALSE)
E31_c

# d) Delete 4th row and 1st column from (c), force single-column matrix
E31_d_vec <- E31_c[-4, -1]  # would usually be a vector
E31_d <- matrix(data = E31_d_vec, ncol = 1)
E31_d

# e) Store bottom four elements of (c) as new 2x2 matrix
# (bottom four elements = last 4 entries in column-wise order)
E31_e <- matrix(data = E31_c[(length(E31_c) - 3):length(E31_c)], nrow = 2, ncol = 2)
E31_e

# f) Overwrite positions (4,2), (1,2), (4,1), (1,1) with -1/2 of diagonal values of (e)
diag_e <- diag(E31_e)          # two values
vals_to_write <- -0.5 * diag_e # two values
E31_f <- E31_c
E31_f[c(4, 1, 4, 1), c(2, 2, 1, 1)] <- vals_to_write
E31_f


# ----------------------------
# 3.3 Matrix Operations and Algebra
# ----------------------------

# 3.3.1 Transpose
A <- rbind(c(2, 5, 2), c(6, 1, 4))
A
t(A)
t(t(A))  # transpose of transpose returns original

# 3.3.2 Identity matrix with diag()
I3 <- diag(x = 3)
I3

# 3.3.3 Scalar multiple (element-wise manner)
A <- rbind(c(2, 5, 2), c(6, 1, 4))
a <- 2
a * A

# 3.3.4 Matrix addition/subtraction
A <- cbind(c(2, 5, 2), c(6, 1, 4))
A
B <- cbind(c(-2, 3, 6), c(8.1, 8.2, -9.8))
B
A - B
A1 <- cbind(c(2, 5), c(6, 1))
A1 - B
# 3.3.5 Matrix multiplication (%*%)
A <- rbind(c(2, 5, 2), c(6, 1, 4))
dim(A)

B <- cbind(c(3, -1, 1), c(-3, 1, 5))
dim(B)
library(dplyr)
B %>% dim() 

A %*% B
B %*% A  # non-commutative: different result

# 3.3.6 Matrix inversion (solve)
A <- matrix(data = c(3, 4, 1, 2), nrow = 2, ncol = 2)
A
solve(A)

# Verify A * A^{-1} = I
A %*% solve(A)


# ----------------------------
# Exercises
# ----------------------------

# a) Compute: (2/7) * [1 2; 2 4; 7 6] - [10 20; 30 40; 50 60]
E32_M1 <- rbind(c(1, 2), c(2, 4), c(7, 6))
E32_M2 <- rbind(c(10, 20), c(30, 40), c(50, 60))
E32_a <- (2/7) * E32_M1 - E32_M2
E32_a


# ----------------------------
# 3.4 Multidimensional Arrays
# ----------------------------

# 3.4.1 Definition
AR <- array(data = 1:24, dim = c(3, 4, 2))
AR

# 4D array: 3 copies of AR (filled column-wise)
BR <- array(data = rep(1:24, times = 3), dim = c(3, 4, 2, 3))
BR

# 3.4.2 Subsets, Extractions, Replacements

# Second row of second layer (returns a vector)
AR[2, , 2]

# Specific columns from that extraction (3rd then 1st), in order
AR[2, c(3, 1), 2]

# Extract first rows of both layers (returned as columns in a matrix)
AR[1, , ]

# Single element from BR: row 2, col 1, layer 1, block 3
BR[2, 1, 1, 3]

# All matrices from layer 2 across all blocks (returns a 3D array)
BR[ , , 2, ]

# Extract rows 3 then 2, column 4, all layers, all blocks (returns 3D array)
BR[3:2, 4, , ]

# Entire second rows of first layer across all blocks (returns a matrix)
BR[2, , 1, ]

# Deleting/overwriting in arrays follows same rules (negative indexes + assignment).


# ----------------------------
# Exercises
# ----------------------------

# a) 3D array: six layers of a 4x2 matrix, filled with decreasing sequence 4.8 to 0.1
# total elements needed = 4*2*6 = 48
seq_a <- seq(from = 4.8, to = 0.1, length.out = 48)  # decreasing
arr_a <- array(data = seq_a, dim = c(4, 2, 6))
arr_a

# b) Extract rows 4 and 1 (in that order) of column 2 for all layers
b_obj <- arr_a[c(4, 1), 2, ]
b_obj

# c) Use fourfold repetition of second row of (b) to fill new array 2x2x2x3
# b_obj is 2 x 6 (matrix): take its second row (length 6)
row2_b <- b_obj[2, ]
rep_row2_b <- rep(row2_b, times = 4)      # 24 values
c_arr <- array(data = rep_row2_b, dim = c(2, 2, 2, 3))
c_arr

# d) Delete sixth layer of (a)
d_arr <- arr_a[, , -6]
dim(d_arr)

# e) Overwrite rows 2 and 4 of column 2 in layers 1,3,5 of (d) with -99
# d_arr has 5 layers now (original layers 1:5)
d_arr[c(2, 4), 2, c(1, 3, 5)] <- -99
d_arr


# Quick check: array sizes multiply to total elements
dim(AR)          # 3 x 4 x 2 = 24 elements
length(AR)       # 24



# ============================================================
# Chapter 4 — Non-numeric values (logicals, characters, factors)
# ============================================================

# ---------------------------
# 4.1 Logical values
# ---------------------------

# TRUE / FALSE (and abbreviations T / F)
foo <- TRUE
foo

bar <- F
bar

# Vector of logicals
baz <- c(T, F, F, F, T, F, T, T, T, F, T, F)
baz
length(baz)
all(baz)
any(baz)
# Logical matrix (byrow controlled by a logical value)
qux <- matrix(data = baz, nrow = 3, ncol = 4, byrow = foo)
qux

# ---------------------------
# 4.1.2 Relational operators (==, !=, >, <, >=, <=)
# ---------------------------
1 == 2
1 > 2
(2 - 1) <= 2
1 != (2 + 3)

# Element-wise comparisons on vectors
foo <- c(3, 2, 1, 4, 1, 2, 1, -1, 0, 3)
bar <- c(4, 1, 2, 1, 1, 0, 0, 3, 0, 4)

length(foo) == length(bar)

foo == bar
foo < bar
foo <= bar
foo <= (bar + 10)

# Vector recycling with relational operators
baz <- foo[c(10, 3)]
baz
foo > baz

# Compare to a single value
foo < 3

# Same behavior for matrices
foo.mat <- matrix(foo, nrow = 5, ncol = 2)
foo.mat

bar.mat <- matrix(bar, nrow = 5, ncol = 2)
bar.mat

foo.mat <= bar.mat
foo.mat < 3

# any() and all()
qux <- foo == bar
qux
any(qux)
all(qux)

quux <- foo <= (bar + 10)
quux
any(quux)
all(quux)

# ---------------------------
# 4.1.3 Logical operators (&, &&, |, ||, !)
# ---------------------------

(6 < 4) || (3 != 1)

# Element-wise logical operators vs single-comparison versions
foo <- c(T, F, F, F, T, F, T, T, T, F, T, F)
bar <- c(F, T, F, T, F, F, F, F, T, T, T, T)

foo & bar
foo | bar


# ---------------------------
# 4.1.4 Logicals are numbers (TRUE=1, FALSE=0 in arithmetic)
# ---------------------------
TRUE + TRUE
FALSE - TRUE
T + T + F + T + F + F + T

1 & 1
1 | 0
0 & 1

# Small teaching example: counting TRUEs
x <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
sum(x)        # how many TRUEs
mean(x)       # proportion TRUE

# An AND statement has a higher precedence than an OR 

# ---------------------------
# 4.1.5 Logical subsetting and extraction
# ---------------------------
myvec <- c(5, -2.3, 4, 4, 4, 6, 8, 10, 40221, -8)

# Logical flags directly
myvec[c(F, T, F, F, F)]

# Condition-generated logical flags
myvec <- rnorm(n = 100)
myvec < 0
myvec[myvec < 0]

# Recycling of logical flags (extract every second element)
myvec[c(T, F)]

# Multiple conditions with & and |
myvec[(myvec > 0) & (myvec < 1000)]

# Overwrite using a logical condition
myvec[myvec < 0] <- -200
myvec

# which(): get numeric indexes of TRUE positions
which(x = c(T, F, F, T, T))
which(x = myvec < 0)

# Use which() to delete based on a condition
myvec[-which(x = myvec < 0)]

# Logical subsetting on a matrix
A <- matrix(c(0.3, 4.5, 55.3,
              91,  0.1, 105.5,
              -4.2, 8.2, 27.9),
            nrow = 3, ncol = 3)
A

A[c(T, F, F), c(F, T, T)]  # A[1, 2:3]

# Replace all elements < 1 with -7 using a logical matrix
A[A < 1] <- -7
A

# which() on matrices: default is column-stacked vector indexes
A > 25
which(x = A > 25)

# Dimension-specific indexes
which(x = A > 25, arr.ind = TRUE)

# ---------------------------
# 4.2 Characters
# ---------------------------

# Create strings
foo <- "This is a 'character' string!"
foo <- 'This is a "character" string!'
foo
length(foo)
nchar(foo)

bar <- "23.3"
bar
# bar * 2  # would error (non-numeric)

# 4.2.2 Concatenation: cat vs paste
qux <- c("awesome", "R", "is")
qux

cat(qux[2], qux[3], "totally", qux[1], "!")
paste(qux[2], qux[3], "totally", qux[1], "!")

cat("Do you think ", qux[2], " ", qux[3], " ", qux[1], "?", sep = "")

# ---------------------------
# 4.3 Factors
# ---------------------------

# Example data (Table-like)
firstname <- c("Liz", "Jolene", "Susan", "Boris", "Rochelle", "Tim", "Simon", "Amy")

s.num <- c(0, 0, 0, 1, 0, 1, 1, 0)
s.char <- c("female", "female", "female", "male", "female", "male", "male", "female")

s.num.fac <- factor(x = s.num)
s.num.fac

s.char.fac <- factor(x = s.char)
s.char.fac

levels(x = s.num.fac)
levels(x = s.char.fac)

# Relabel levels
  levels(x = `s.char.fac`) <- c("1", "2")
levels(x = s.num.fac) <- c("1", "2")
s.num.fac

# Subsetting factors
s.char.fac[2:5]
s.char.fac[c(1:3, 5, 8)]

# Levels stored as strings: compare with "2" not 2
s.num.fac == "2"

# Use factor flags to subset another vector
firstname[s.char.fac == "male"]

# 4.3.2 Ordered factor with explicit levels
mob <- c("Apr", "Jan", "Dec", "Sep", "Nov", "Jul", "Jul", "Jun")
ms <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

mob.fac <- factor(x = mob, levels = ms, ordered = TRUE)
mob.fac
mob.fac[2] < mob.fac[3]

# 4.3.3 Combining factors (safe way)
new.values <- factor(x = c("Oct", "Feb", "Feb"),
                     levels = levels(mob.fac),
                     ordered = TRUE)

# c() on factors returns their internal integer codes
c(mob.fac, new.values)