# ============================================================
# Chapter 5: Lists and Data Frames# (store multiple types of values at once)
# Notes:
#   - This script uses base R only.
# ============================================================

# V, M, A can store only one type of data.
# ------------------------------------------------------------
# 5.1 Lists
# ------------------------------------------------------------
cat("\n--- 5.1.1 Definition and Component Access ---\n")

# Creating a list
foo <- list(
  matrix(data = 1:4, nrow = 2, ncol = 2),
  c(TRUE, FALSE, TRUE, TRUE),
  "hello"
)

cat("\nfoo (original):\n")
print(foo)

# Number of components
cat("\nlength(foo): ")
print(length(x = foo))

# Member reference with [[ ]]
cat("\nfoo[[1]]:\n")
print(foo[[1]])

cat("\nfoo[[3]]:\n")
print(foo[[3]])

# Treat retrieved component as a normal object
cat("\nfoo[[1]] + 5.5:\n")
print(foo[[1]] + 5.5)

cat("\nfoo[[1]][1,2]: ")
foo[[1]][1, 2]

cat("\nfoo[[1]][2, ]:\n")
print(foo[[1]][2, ])

cat("\ncat(foo[[3]], 'you!') -> ")
cat(foo[[3]], "you!\n")

# Overwrite a member using assignment
cat("\nOverwriting foo[[3]] using paste():\n")
print(foo[[3]])
foo[[3]] <- paste(foo[[3]], "you!")
print(foo)

# Attempt to access multiple components with [[c(2,3)]] (does NOT slice)
cat("\nfoo[[c(2,3)]] (demonstrates why [[ ]] is for one member):\n")
print(foo[[c(2, 3)]])

# List slicing with [ ] to select multiple members
cat("\nList slicing: bar <- foo[c(2,3)]\n")
bar <- foo[c(2, 3)]
print(bar)


# ------------------------------------------------------------
# 5.1.2 Naming
# ------------------------------------------------------------
cat("\n--- 5.1.2 Naming ---\n")

names(foo) <- c("mymatrix", "mylogicals", "mystring")
cat("\nfoo after naming:\n")
print(foo)

cat("\nfoo$mymatrix:\n")
print(foo$mymatrix)

cat("\nfoo[[1]] (still works with numeric index):\n")
print(foo[[1]])

cat("\nCheck identical extraction of second column: all(...)\n")
print(all(foo$mymatrix[, 2] == foo[[1]][, 2]))

# Naming components at creation time
cat("\nCreate named list baz using components of foo:\n")
baz <- list(
  tom   = c(foo[[2]], TRUE, TRUE, TRUE, FALSE),
  dick  = "g'day mate",
  harry = foo$mymatrix * 2
)
print(baz)

cat("\nnames(baz): ")
print(names(baz))


# ------------------------------------------------------------
# 5.1.3 Nesting
# ------------------------------------------------------------
cat("\n--- 5.1.3 Nesting ---\n")

# Add a new component to an existing list
baz$bobby <- foo
cat("\nbaz after adding nested list bobby <- foo:\n")
print(baz)

# Extract nested items (different valid ways)  dollar operator 
cat("\nbaz$bobby$mylogicals[1:3]:\n")
print(baz$bobby$mylogicals[1:3])

cat("\nbaz[[4]][[2]][1:3]:\n")
print(baz[[4]][[2]][1:3])

cat("\nbaz[[4]]$mylogicals[1:3]:\n")
print(baz[[4]]$mylogicals[1:3])


# ------------------------------------------------------------
# 5.2 Data Frames
# ------------------------------------------------------------
cat("\n=== 5.2 Data Frames ===\n")

cat("\n--- 5.2.1 Construction ---\n")

mydata <- 
  data.frame(
  person = c("Peter", "Lois", "Meg", "Chris", "Stewie"),
  age    = c(42, 40, 17, 14, 1),
  sex    = factor(c("M", "F", "F", "M", "M"))
)

cat("\nmydata:\n")
print(mydata)

cat("\nmydata[2,2] (Lois's age): ")
print(mydata[2, 2])

cat("\nmydata[3:5,3] (sex for Meg, Chris, Stewie):\n")
print(mydata[3:5, 3])

cat("\nmydata[,c(3,1)] (sex then person):\n")
print(mydata[, c(3, 1)])

cat("\nmydata$age:\n")
print(mydata$age)

cat("\nmydata$age[2] (same as mydata[2,2]): ")
print(mydata$age[2])

cat("\nSize of mydata: nrow, ncol, dim\n")
print(nrow(mydata))
print(ncol(mydata))
print(dim(mydata))

# stringsAsFactors (book note)
cat("\nDemonstrate stringsAsFactors=FALSE to keep person as character:\n")
mydata_chr <- data.frame(
  person = c("Peter", "Lois", "Meg", "Chris", "Stewie"),
  age    = c(42, 40, 17, 14, 1),
  sex    = factor(c("M", "F", "F", "M", "M")),
  stringsAsFactors = TRUE
)
mydata_chr$person

cat("\nmydata_chr$person (should be character):\n")
print(mydata_chr$person)


# ------------------------------------------------------------
# 5.2.2 Adding Data Columns and Combining Data Frames
# ------------------------------------------------------------
cat("\n--- 5.2.2 Adding Columns/Rows and Combining ---\n")

# Add a new record
newrecord <- data.frame(
  person = "Brian",
  age    = 7,
  sex    = factor("M", levels = levels(mydata$sex))
)

cat("\nnewrecord:\n")
print(newrecord)

mydata <- rbind(mydata, newrecord)
cat("\nmydata after rbind(mydata, newrecord):\n")
print(mydata)

# Add a new variable funny
funny <- c("High", "High", "Low", "Med", "High", "Med")
funny <- factor(x = funny, levels = c("Low", "Med", "High"))

cat("\nfunny factor:\n")
print(funny)

mydata <- cbind(mydata, funny)
cat("\nmydata after cbind(mydata, funny):\n")
print(mydata)

# Add age in months using $ operator
mydata$age.mon <- mydata$age * 12
cat("\nmydata after adding age.mon:\n")
print(mydata)


# ------------------------------------------------------------
# 5.2.3 Logical Record Subsets
# ------------------------------------------------------------
cat("\n--- 5.2.3 Logical Record Subsets ---\n")

cat("\nmydata$sex == 'M':\n")
print(mydata$sex == "M")

cat("\nMale-only subset mydata[mydata$sex=='M', ]:\n")
print(mydata[mydata$sex == "M", ])

cat("\nMale-only subset without sex column (column -3):\n")
print(mydata[mydata$sex == "M", -3])

cat("\nMale-only subset selecting columns by name:\n")
print(mydata[mydata$sex == "M", c("person", "age", "funny", "age.mon")])

cat("\nAge>10 OR funny==High:\n")
print(mydata[mydata$age > 10 | mydata$funny == "High", ])

cat("\nEmpty subset example (age > 45):\n")
res_empty <- mydata[mydata$age > 45, ]
print(res_empty)
cat("nrow(empty subset): ")
print(nrow(res_empty))


# ============================================================
# Task
# ============================================================

#  1: [[ ]] vs [ ] (object vs sub-list)
cat("\nTrick 1: [[ ]] vs [ ]\n")
print(foo[[2]])
print(foo[2])
cat("is.list(foo[2]) -> ")
print(is.list(foo[2]))
cat("is.list(foo[[2]]) -> ")
print(is.list(foo[[2]]))

#  2: drop=FALSE to keep data frame output when selecting one column
cat("mydata[, 'age'] simplifies to a vector; drop=FALSE keeps a data frame.\n")
print(mydata[, "age"])
print(mydata[, "age", drop = FALSE])

#  3: Safe factor handling when adding rows (avoid NA due to missing levels)
cat("Always align factor levels when creating new rows.\n")
newrecord_safe <- data.frame(
  person  = "Someone",
  age     = 10,
  sex     = factor("M", levels = levels(mydata$sex)),
  funny   = factor("Med", levels = levels(mydata$funny)),
  age.mon = 120
)

newrecord_safe2 <- data.frame(
  person  = "Someone",
  age     = 10,
  sex     = "II",
  age.mon = 120
)

mydata <- rbind(mydata, newrecord_safe2)
mydata$sex %>% levels()

# To rbind, columns must match; here we demonstrate safely matching factor levels.
mydata_safe <- rbind(mydata, newrecord_safe)
cat("\nmydata_safe (with aligned factor levels):\n")
print(tail(mydata_safe, 2))

# 5: Starts-with filtering: substr and grepl
starts_with_S_substr <- mydata[substr(mydata$person, 1, 1) == "S", ]
starts_with_S_grepl  <- mydata[grepl("^S", mydata$person), ]
cat("Using substr:\n")
print(starts_with_S_substr)
cat("Using grepl (regex):\n")
print(starts_with_S_grepl)


# ============================================================
# Exercise 5.1
# ============================================================
# 5.1(a) Create the list with specified components
seq20 <- seq(from = -4, to = 4, length.out = 20)

log_mat <- matrix(
  data = c(FALSE, TRUE, TRUE,
           TRUE, FALSE, TRUE,
           TRUE, FALSE, FALSE),
  nrow = 3, ncol = 3, byrow = FALSE
)

chars <- c("don", "quixote")

facs <- factor(c("LOW", "MED", "LOW", "MED", "MED", "HIGH"),
               levels = c("LOW", "MED", "HIGH"))

lstA <- list(seq20, log_mat, chars, facs)
cat("\nlstA created:\n")
print(lstA)

# (i) Extract row elements 2 and 1 of columns 2 and 3, in that order
cat("\n5.1(a)(i): rows (2,1) of cols (2,3) from logical matrix:\n")
print(lstA[[2]][c(2, 1), c(2, 3)])

# (ii) Overwrite "quixote" -> "Quixote" and "don" -> "Don" inside list; print exact statement
cat("\n5.1(a)(ii): overwrite strings using sub and print statement:\n")
lstA[[3]] <- sub("^don$", "Don", lstA[[3]])
lstA[[3]] <- sub("^quixote$", "Quixote", lstA[[3]])

# Print exactly:
# "Windmills! ATTACK!"-\Don Quixote/
cat('"Windmills! ATTACK!"-\\', paste(lstA[[3]], collapse = " "), '/\n', sep = "")

# (iii) Values from the sequence > 1
cat("\n5.1(a)(iii): values > 1 in seq(-4,4,length=20):\n")
print(lstA[[1]][lstA[[1]] > 1])

# (iv) Indexes assigned the "MED" level
cat("\n5.1(a)(iv): which indexes are MED in factor vector:\n")
print(which(lstA[[4]] == "MED"))


# 5.1(b) Create new list with facs, nums, and nested oldlist
lstB <- list(
  facs    = lstA[[4]],
  nums    = c(3, 2.1, 3.3, 4, 1.5, 4.9),
  oldlist = lstA[c(1, 2, 3)]
)

cat("\nlstB created:\n")
print(lstB)

# (i) Extract elements of facs where nums >= 3
cat("\n5.1(b)(i): facs where nums >= 3:\n")
print(lstB$facs[lstB$nums >= 3])

# (ii) Add flags: length 6 = twofold repetition of 3rd column of logical matrix in oldlist
cat("\n5.1(b)(ii): create flags by repeating 3rd column twice:\n")
col3 <- lstB$oldlist[[2]][, 3]
lstB$flags <- rep(col3, times = 2)
print(lstB$flags)

# (iii) Use flags and ! to extract nums corresponding to FALSE
cat("\n5.1(b)(iii): nums where flags are FALSE (using !flags):\n")
print(lstB$nums[!lstB$flags])

# (iv) Overwrite character vector component of oldlist with "Don Quixote"
cat("\n5.1(b)(iv): overwrite oldlist character vector with single string:\n")
lstB$oldlist[[3]] <- "Don Quixote"
print(lstB$oldlist)

# ============================================================
# Chapter 6: Special Values, Coercion
# ============================================================
# ------------------------------------------------------------
# 6.1 Some Special Values
# ------------------------------------------------------------

# -------------------------
# 6.1.1 Infinity
# -------------------------

foo_inf <- Inf
cat("foo_inf:\n")
print(foo_inf)

bar_inf <- c(3401, Inf, 3.1, -555, Inf, 43)
cat("\nbar_inf:\n")
mean(bar_inf)

baz_inf <- 90000^100
cat("\nbaz_inf (90000^100):\n")
print(baz_inf)
1.797693e+308
.Machine$double.xmax
exp(2000)
factorial(2000)
(1e200) * (1e200)
.Machine$double.xmin


qux_inf <- c(-42, 565, -Inf, -Inf, Inf, -45632.3)
cat("\nqux_inf:\n")
print(qux_inf)

cat("\nBasic operations with Inf/-Inf:\n")
print(Inf * -9)
print(Inf + 1)
print(4 * -Inf)
print(-45.2 - Inf)
print(Inf - 45.2)
print(Inf + Inf)
print(Inf / 23)

cat("\nDivision with infinity and zero:\n")
print(-59 / Inf)
print(-59 / -Inf)
print(-59 / 0)

print(59 / 0)
print(Inf / 0)

cat("\nDetecting infinite and finite values:\n")
print(is.infinite(x = qux_inf)) # do not distinguish between neg-pos
print(is.finite(x = qux_inf))

cat("\nRelational checks:\n")
print(-Inf < Inf)
print(Inf > Inf)
print(qux_inf == Inf)
print(qux_inf == -Inf)


# -------------------------
# 6.1.2 NaN
# -------------------------
# not mathematically defined, undefined for real numbers, or not representable
foo_nan <- NaN
cat("foo_nan:\n")
print(foo_nan)

bar_nan <- c(NaN, 54.3, -2, NaN, 90094.123, -Inf, 55)
cat("\nbar_nan:\n")
print(bar_nan)

cat("\nHow NaN can arise:\n")
print(-Inf + Inf)
print(Inf / Inf)
print(0 / 0)
Inf %% Inf
log(-1)
sqrt(-4)
factorial(-1)
0^(-1)

cat("\nAny operation involving NaN stays NaN:\n")
print(NaN + 1)
print(2 + 6 * (4 - 4) / 0)
print(3.5 ^ (-Inf / Inf))

cat("\nDetect NaN and combine with Inf detection:\n")
print(is.nan(x = bar_nan))
print(!is.nan(x = bar_nan))
print(is.nan(x = bar_nan) | is.infinite(x = bar_nan))

cat("\nRemove NaN or Inf using which + negative indexes:\n")
idx_bad <- which(is.nan(x = bar_nan) | is.infinite(x = bar_nan))
print(idx_bad)
print(bar_nan[-idx_bad])
#NaN==NaNv# relational operators 


# -------------------------
# 6.1.3 NA
# -------------------------
foo_na <- c("character", "a", NA, "with", "string", NA)
cat("foo_na:\n")
print(foo_na)

bar_na <- factor(c("blue", NA, NA, "blue", "green", "blue", NA, "red", "red", NA, "green"))
cat("\nbar_na (factor with NA):\n")
print(bar_na)

baz_na <- matrix(c(1:3, NA, 5, 6, NA, 8, NA), nrow = 3, ncol = 3)
cat("\nbaz_na (matrix with NA):\n")
print(baz_na)

qux_mix <- c(NA, 5.89, Inf, NA, 9.43, -2.35, NaN, 2.10, -8.53, -7.58, NA, -4.58, 2.01, NaN)
cat("\nqux_mix (NA/NaN/Inf mix):\n")
print(qux_mix)

cat("\nis.na flags both NA and NaN (for numeric vectors):\n")
print(is.na(x = qux_mix))

cat("\nIdentify NaN only:\n")
print(which(x = is.nan(x = qux_mix)))

cat("\nIdentify NA only (exclude NaN):\n")
print(which(x = (is.na(x = qux_mix) & !is.nan(x = qux_mix))))

cat("\nRemove NA and NaN using na.omit():\n")
quux_omit <- na.omit(object = qux_mix) #na.action
print(quux_omit)

cat("\nArithmetic with NA yields NA; comparisons with NA/NaN yield NA:\n")
print(3 + 2.1 * NA - 4)
print(3 * c(1, 2, NA, NA, NaN, 6))
print(NA > 76)
print(76 > NaN)
as.numeric(c("L", "Z"))


# -------------------------
# 6.1.4 NULL
# -------------------------
foo_null <- NULL
cat("foo_null:\n")
print(foo_null) # no position to access

bar_single_na <- NA
cat("\nbar_single_na:\n")
print(bar_single_na)

cat("\nCompare c(..., NA, ...) vs c(..., NULL, ...):\n")
print(c(2, 4, NA, 8))
print(c(2, 4, NULL, 8))

cat("\nCompare multiple NA vs multiple NULL:\n")
print(c(NA, NA, NA))
print(c(NULL, NULL, NULL))

cat("\nNULL in arithmetic/relational produces empty vectors of a type:\n")
print(NULL + 53)
print(53 <= NULL)
print(NaN - NULL + NA / Inf)

# NULL in lists/data frames: missing member/column
cat("\nNULL returned when accessing a missing list member:\n")
foo_list <- list(member1 = c(33, 1, 5.2, 7), member2 = "NA or NULL?")
print(foo_list)
print(foo_list$member3)  # doesn't exist -> NULL

cat("\nFill a missing member (member3) after seeing NULL:\n")
foo_list$member3 <- NA
print(foo_list)

# no object at all
x <- list(a = 1, b = 2)
x$c 

x$b <- NULL   # removes column b

#an empty or uninitialized object
# mainly used in fucntion's optional arguments and predefinitions

# ============================================================
# Task 
# ============================================================

# A: A robust "bad value" detector for numeric vectors
# (NA, NaN, Inf, -Inf)
cat("\nTrick A: Identify any 'bad' numeric values (NA/NaN/Inf)\n")
mark_bad <- function(x) {
  is.na(x) | is.infinite(x)
}

x_demo <- c(1, NA, 2, NaN, 3, Inf, -Inf, 4)
print(x_demo)
print(mark_bad(x_demo))
cat("Cleaned (remove bad):\n")
print(x_demo[!mark_bad(x_demo)])

#B: Why you shouldn't use == NA (it's invalid / not meaningful)
cat("\nTrick B: NA comparisons yield NA, so always use is.na\n")
val <- c(NA, 1, 2)
print(val)
cat("val == NA gives:\n")
print(val == NA)  # always NA
cat("Use is.na(val):\n")
print(is.na(val))

# D: Optional argument checks — NULL vs NA
cat("\nTrick D: Optional argument checks — is.null is single TRUE/FALSE\n")
opt.arg <- c("string1", "string2", "string3")
print(is.na(opt.arg))
print(is.null(opt.arg))
opt.arg <- NULL
print(is.null(opt.arg))



# ============================================================
# Chapter 9: Calling Functions
# ============================================================
# -------------------------
# 9.1.1 Environments (global, local, namespaces)
# -------------------------
# Global environment: user-created objects live here
foo <- 4 + 5
bar <- "stringtastic"
cat("\nObjects in .GlobalEnv (ls()):\n")
print(ls())

# Package environments: list visible objects in a package
cat("\nFirst few objects in package:graphics (ls('package:graphics')):\n")
print(head(ls("package:graphics"), 20))

# Local (lexical) environment: created when a function is called
# Example: matrix() uses argument name 'data' internally, but R resolves it in the local env
cat("\nCreate a matrix using argument name data (local env inside matrix call):\n")
youthspeak <- matrix(dat <- c("OMG", "LOL", "WTF", "YOLO"), 
                     2, 2)
print(youthspeak)

rm(x)

# -------------------------
# 9.1.2 Search Path
# -------------------------
print(search())
library(dplyr)
library(ggplot2)
library(stringr)
dplyr::filter()
# Demonstrate how R finds functions along the search path
baz <- seq(from = 0, to = 3, length.out = 5)
cat("\nSequence baz from seq():\n")
print(baz)

# Identify owning environments (namespaces) of functions
cat("\nOwning environments for selected functions:\n")
print(environment(seq))
print(environment(arrows))

library(dplyr)
print(search())
neither.here()

# -------------------------
# 9.1.3 Reserved and Protected Names
# -------------------------

# Trying to overwrite reserved names causes errors
cat("\nAttempt to assign to NaN (should error):\n")
NaN <- 5

# Case sensitivity: these are allowed but confusing
False <- "confusing"
nan <- "this is"
cat("\nCase-variant names are allowed but confusing:\n")
cat(nan, False, "\n")

# T and F are NOT reserved (avoid overriding!)
T <- 42
rm(T)
F <- TRUE
cat("\nOverriding T/F is legal but confusing; F && TRUE now means TRUE && TRUE:\n")
print(F && TRUE)

# Clean global environment (as in book)
cat("\nCleaning global environment with rm(list=ls()):\n")
print(ls())
rm(list = ls())
print(ls())


# ------------------------------------------------------------
# Exercise
# ------------------------------------------------------------
# (a) First 20 items in methods package; total count
items_methods <- ls("package:methods")
print(head(items_methods, 20))
cat("Total items in package:methods: ")
print(length(items_methods))

# (b) Determine owning environment (namespace) for each function
cat("read.table -> "); print(environment(read.table))
cat("data       -> "); print(environment(data))
cat("matrix     -> "); print(environment(matrix))
cat("jpeg       -> "); print(environment(jpeg))

# (c) Confirm smoothScatter is part of graphics package
graphics_items <- ls("package:graphics")
print(any(graphics_items == "smoothScatter"))


# ------------------------------------------------------------
# 9.2 Argument Matching
# ------------------------------------------------------------
# -------------------------
# 9.2.1 Exact matching
# -------------------------
bar <- matrix(data = 1:9, nrow = 3, ncol = 3,
              dimnames = list(c("A", "B", "C"), c("D", "E", "F")))
print(bar)

# Order doesn't matter with exact tags
bar <- matrix(nrow = 3,
              dimnames = list(c("A", "B", "C"), c("D", "E", "F")),
              ncol = 3,
              data = 1:9)
print(bar)

# -------------------------
# 9.2.2 Partial matching
# -------------------------
bar <- matrix(nr = 3, di = list(c("A", "B", "C"), c("D", "E", "F")), nc = 3, dat = 1:9)
print(bar)

matrix(nro = 3, di = list(c("A", "B", "C"), c("D", "E", "F")), nc = 3, dat = 1:9)

# Ambiguous partial tag example (should error)
matrix(nr = 3, di = list(c("A", "B", "C"), c("D", "E", "F")), nc = 3, d = 1:9)
# -------------------------
# 9.2.3 Positional matching
# -------------------------
bar <- matrix(1:9, 3, 3, FALSE, list(c("A", "B", "C"), c("D", "E", "F")))
print(bar)

dim(bar)

# -------------------------
# 9.2.4 Mixed matching
# -------------------------
cat("\n9.2.4 Mixed matching example:\n")
bar <- matrix(1:9, 3, 3, dim = list(c("A", "B", "C"), c("D", "E", "F")))
print(bar)

# -------------------------
# 9.2.5 Ellipsis (...)
# -------------------------
args(data.frame)
args(list)

cat("args(plot):\n")
print(args(plot))

# Example: data.frame uses ... for its main ingredients
DF <- data.frame(a = 1:3, b = c("x", "y", "z"), stringsAsFactors = FALSE)
print(DF)

# Example: plot uses ... for optional graphical parameters
# (creates a quick plot if interactive; safe in non-interactive too)
# Uncomment if you want to see a plot:
# plot(1:5, 1:5, pch = 19, col = "blue", main = "Demo", cex = 1.2)

myfunction <- function(){}

# ------------------------------------------------------------
# Exercise 
# ------------------------------------------------------------
# (a) Positional matching with seq: from -4 to 4 by 0.2
# Usage: seq(from, to, by) -- by is 3rd argument
seq_a <- seq(-4, 4, 0.2)
cat("\n9.2(a) seq(-4, 4, 0.2):\n")
print(head(seq_a))
print(tail(seq_a))

# (b) Identify matching styles
# We print the calls and annotate in comments.
cat("\n9.2(b) Matching styles (see comments in script):\n")

# i) array(8:1, dim=c(2,2,2))  -> mixed (positional for data, exact for dim)
obj_i <- array(8:1, dim = c(2, 2, 2))
print(obj_i)

# ii) rep(1:2, 3) -> positional (x, times)
obj_ii <- rep(1:2, 3)
print(obj_ii)

# iii) seq(from=10, to=8, length=5) -> exact (named)
obj_iii <- seq(from = 10, to = 8, length = 5)
print(obj_iii)

# iv) sort(decreasing=T, x=c(...)) -> mixed (exact for decreasing and x)
obj_iv <- sort(decreasing = TRUE, x = c(2, 1, 1, 2, 0.3, 3, 1.3))
print(obj_iv)

# v) which(matrix(c(T,F,T,T),2,2)) -> positional inside matrix, positional in which
obj_v <- which(matrix(c(TRUE, FALSE, TRUE, TRUE), 2, 2))
print(obj_v)

# vi) which(matrix(c(T,F,T,T),2,2), a=T) -> error (which has no arg 'a'); demonstrate via try
cat("\n9.2(b)(vi) invalid arg name example (handled with try):\n")
try(which(matrix(c(TRUE, FALSE, TRUE, TRUE), 2, 2), a = TRUE), silent = TRUE)

# (c) plot.default ellipsis arguments
# Determine which of {type, pch, xlab, ylab, lwd, lty, col} are in plot.default formals.
cat("\n9.2(c) Which specified args are in plot.default formals vs in ... ?\n")
formals_pd <- names(formals(plot.default))
args_to_check <- c("type", "pch", "xlab", "ylab", "lwd", "lty", "col")

in_formals <- args_to_check[args_to_check %in% formals_pd]
in_dots    <- setdiff(args_to_check, in_formals)

cat("In plot.default formals (NOT via ...):\n")
print(in_formals)
cat("Likely passed via ... (not formal args of plot.default):\n")
print(in_dots)

