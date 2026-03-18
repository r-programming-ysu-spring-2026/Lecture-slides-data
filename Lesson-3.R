# ============================================================
# Chapter 10 (Conditions and Loops)
# ============================================================

# ------------------------------------------------------------
# 1. BASIC IF / ELSE
# ------------------------------------------------------------

a <- 3
mynumber <- 4
if (a <= mynumber) { # single logical value
    a <- a^2
  }
a


# ------------------------------------------------------------
# 2. ELSE
# ------------------------------------------------------------
# When the condition is FALSE

  if (a <= mynumber) {
    message("Condition was TRUE")
    a <- a^2
  } else {
    message("Condition was FALSE")
    a <- a - 3.5
  }
  a

myvec <- rnorm(n = 6, mean = 10)
mymat <- matrix(c(2,0,1,2,3,0,3,0,1,1),5,2)

if (any((myvec - 1) > 9) | matrix(myvec, 2, 3)[2, 1] <= 6) {
    message("Condition satisfied")
    new.myvec <- myvec
    new.myvec[seq(1, 9, 2)] <- NA
    mylist <- list(
      aa = new.myvec,
      bb = mymat + 0.5
    )
    
  }

mylist


# ------------------------------------------------------------
# 2. IFELSE (Element-wise Checks)
# ------------------------------------------------------------
if(c(TRUE,FALSE,TRUE,TRUE)){print("Something")}
x <- 27
y <--27:27

ifelse(test = y == 0, yes = NA, no = x / y)

vec1 = 27:10
vec2 = vec1 - 3
stopifnot(length(vec1) == length(vec2))
ifelse(vec1 + vec2 > 3, vec1 * vec2, vec1 + vec2)


grade_labels <- function(scores) {
  ifelse(scores >= 90, "A",
         ifelse(scores >= 80, "B",
                ifelse(scores >= 70, "C", "Needs work")))
}

grade_labels(c(95, 81, 72, 60))


# ------------------------------------------------------------
# 3. NESTED / STACKED IF
# ------------------------------------------------------------

nested_decision <- function(a, mynumber) {
  if (a <= mynumber) {
    message("First condition was TRUE")
    a <- a^2
    if (mynumber > 3) {
      message("Second condition was TRUE")
      b <- seq(1, a, length.out = mynumber)
    } else {
      message("Second condition was FALSE")
      b <- a * mynumber
    }
  } else {
    message("First condition was FALSE")
    a <- a - 3.5
    if (mynumber >= 4) {
      message("Second condition was TRUE")
      b <- a^(3 - mynumber)
    } else {
      message("Second condition was FALSE")
      b <- rep(a + mynumber, times = 3)
    }
  }
  list(a = a, b = b)
}
 
nested_decision(3, 4)


stacked_decision <- function(a, mynumber) {
  if (a <= mynumber && mynumber > 3) {
    a <- a^2
    b <- seq(1, a, length.out = mynumber)
  } else if (a <= mynumber && mynumber <= 3) {
    a <- a^2
    b <- a * mynumber
  } else if (mynumber >= 4) {
    a <- a - 3.5
    b <- a^(3 - mynumber)
  } else {
    a <- a - 3.5
    b <- rep(a + mynumber, times = 3)
  }
  list(a = a, b = b)
}

stacked_decision(3, 4)

# ------------------------------------------------------------
# 4. SWITCH (which code to run based on the value of a single object)
# ------------------------------------------------------------

mystring <- "Lisa"

switch(
    EXPR = mystring,
    Homer = 12,
    Marge = 34,
    Bart = 56,
    Lisa = 78,
    Maggie = 90,
    NA
  )

mystring <- "hy"

switch(mystring,
       en = "Welcome",
       hy = "Բարի գալուստ",
       ru = "Добро пожаловать",
       "Welcome")


number_to_word <- function(mynum) {
  ifelse(
    mynum == 0, "zero",
    switch(as.character(mynum),
           "1" = "one",
           "2" = "two",
           "3" = "three",
           "4" = "four",
           "5" = "five",
           "6" = "six",
           "7" = "seven",
           "8" = "eight",
           "9" = "nine",
           NA)
  )
}

number_to_word(3)

get_fun <- function(type) {
  switch(type,
         square = function(x) x^2,
         cube   = function(x) x^3)
}

f <- get_fun("square")
f(3)


# ------------------------------------------------------------
# 5. FOR LOOPS (p repeats code as it works its way through a vector, element by element)
# ------------------------------------------------------------

loopvector = 5:7
  for (myitem in loopvector) {
    cat("--BEGINS--\n")
    cat("the current item is", myitem, "\n")
    cat("--ENDS--\n\n")
  }

myvec <- rnorm(10, mean = 10)

for (i in myvec) {
   print(i)
   print(2*i)
}


for (i in 1:length(myvec)) {
 
  print(i)
  print(2*myvec[i]) 

 }


foo <- list(aa=c(3.4,1),bb=matrix(1:4,2,2),cc=matrix(c(T,T,F,T,F,F),3,2),
            dd="string here",ee=matrix(c("red","green","blue","yellow")))

name <- names(foo)
is.mat <- rep(NA,length(foo))
nr <- is.mat
nc <- is.mat
data.type <- is.mat

for (i in seq_along(foo)) {
    member <- foo[[i]]
    if (is.matrix(member)) {
      is.mat[i] <- "Yes"
      nr[i] <- nrow(member)
      nc[i] <- ncol(member)
      data.type[i] <- class(as.vector(member))
    } else {
      is.mat[i] <- "No"
    }
  }
  
data.frame(name,is.mat,nr,nc,data.type,stringsAsFactors=FALSE)



out <- matrix(NA, nrow = length(loopvec1), ncol = length(loopvec2))

  for (i in seq_along(loopvec1)) {
    for (j in seq_along(loopvec2)) {
      out[i, j] <- loopvec1[i] * loopvec2[j]
    }
  }

out


# ------------------------------------------------------------
# 6. WHILE LOOPS (until specific condition)
# ------------------------------------------------------------

myval <- 5
while (myval < 10) { 
    myval <- myval + 1
    cat("\n'myval' is now", myval, "\n")
    cat("'mycondition' is now", myval < 10, "\n")
}

factorial_while <- function(mynum) {
  stopifnot(length(mynum) == 1, mynum >= 0, mynum == as.integer(mynum))
  
  result <- 1
  while (mynum > 0) {
    result <- result * mynum
    mynum <- mynum - 1
  }
  result
}

factorial_while(4)


##$
truncate_before_second_e <- function(mystring) {
  index <- 1
  ecount <- 0
  result <- mystring
  
  while (ecount < 2 && index <= nchar(mystring)) {
    current_char <- substr(mystring, index, index)
    
    if (current_char == "e" || current_char == "E") {
      ecount <- ecount + 1
    }
    
    if (ecount == 2) {
      result <- substr(mystring, 1, index - 1)
    }
    
    index <- index + 1
  }
  
  result
}

myvec[11] <- 0

for(i in 1:length(myvec)){
  print(paste(myvec[i], "divided by", 0, "=", myvec[i]/0))
}


# ------------------------------------------------------------
# 7.  Implicit Looping: APPLY, BREAK, NEXT
# ------------------------------------------------------------

apply(X = matrix(1:12, 4, 3), MARGIN = 1, FUN = sum)
apply(X = matrix(1:12, 4, 3), MARGIN = 2, FUN = sum)

bar <- array(1:18,dim = c(3,3,2))
bar
apply(bar,3,FUN=diag)

s
lapply(list(1:3, 4:6), mean)
sapply(list(1:3, 4:6), mean)

tapply(1:6, c("A","A","B","B","A","B"), mean)

sum(1:3, 4:6)
mapply(sum, 1:3, 4:6) 
mapply(function(x, y) x^y, 1:3, 2:4)
mapply(rep, 1:3, 3:1)
mapply(paste, letters[1:3], LETTERS[1:3])
round(x = 1.789, digits = 2)

mapply(round, c(1.234, 5.678), MoreArgs = list(digits = 2))

prices <- c(100, 200, 300)
discounts <- c(0.1, 0.2, 0.15)

mapply(function(p, d) p * (1 - d), prices, discounts)

# ------------------------------------------------------------
# 8. EXTRA  EXAMPLES
# ------------------------------------------------------------

fizzbuzz_r <- function(n = 20) {
  out <- character(n)
  for (i in seq_len(n)) {
    if (i %% 15 == 0) {
      out[i] <- "FizzBuzz"
    } else if (i %% 3 == 0) {
      out[i] <- "Fizz"
    } else if (i %% 5 == 0) {
      out[i] <- "Buzz"
    } else {
      out[i] <- as.character(i)
    }
  }
  out
}

running_balance_alert <- function(transactions, start_balance = 0) {
  balance <- start_balance
  alerts <- character(0)
  
  for (i in seq_along(transactions)) {
    balance <- balance + transactions[i]
    if (balance < 0) {
      alerts <- c(alerts, paste("Balance went negative at step", i))
    }
  }
  
  list(final_balance = balance, alerts = alerts)
}

first_repeat_value <- function(x) {
  seen <- c()
  for (val in x) {
    if (val %in% seen) {
      return(val)
    }
    seen <- c(seen, val)
  }
  NA
}

# ------------------------------------------------------------
# 9. PRACTICE QUESTIONS
# ------------------------------------------------------------

practice_questions <- list(
  q1 = "Write a function that returns TRUE if any element of a numeric vector is negative, otherwise FALSE.",
  q2 = "Write a function that labels numbers as 'even' or 'odd' using ifelse.",
  q3 = "Use a for loop to return a vector of cubes for the integers 1 through n.",
  q4 = "Use a while loop to count how many times you can divide a number by 2 before it becomes less than 1.",
  q5 = "Use switch to return the number of days in a month name (ignore leap years)."
)

practice_questions

# ------------------------------------------------------------
# 10. PRACTICE SOLUTIONS
# ------------------------------------------------------------

any_negative <- function(x) {
  any(x < 0)
}

even_or_odd <- function(x) {
  ifelse(x %% 2 == 0, "even", "odd")
}

cubes_up_to_n <- function(n) {
  out <- numeric(n)
  for (i in seq_len(n)) {
    out[i] <- i^3
  }
  out
}

halving_steps <- function(x) {
  count <- 0
  while (x >= 1) {
    x <- x / 2
    count <- count + 1
  }
  count
}

days_in_month <- function(month_name) {
  switch(
    tolower(month_name),
    january = 31,
    february = 28,
    march = 31,
    april = 30,
    may = 31,
    june = 30,
    july = 31,
    august = 31,
    september = 30,
    october = 31,
    november = 30,
    december = 31,
    NA
  )
}


# ============================================================
# CHAPTER 11 - WRITING FUNCTIONS
# ============================================================

# ------------------------------------------------------------
# 11.1 Simple functions
# ------------------------------------------------------------


square_plus_one <- function() { # no arguments
  2^2 + 1
}

square_plus_one() 

square_plus_one <- function(x) {
  x^2 + 1
}

mean_center <- function(x) {
  x - mean(x)
}


myfib_print <- function(thresh) {
  fibseq <- c(1, 1)
  counter <- 2
  
  repeat {
    fibseq <- c(fibseq, fibseq[counter - 1] + fibseq[counter])
    counter <- counter + 1
    
    if (fibseq[counter] > thresh) {
      break
    }
  }
  
  fibseq
}

a <- myfib_print(100)


myfac <- function(int) {
  result <- 1
  
  while (int > 0) {
    result <- result * int
    int <- int - 1
  }
  
  return(c(result, int))
}

myfac(4)


myfac2 <- function(int) {
  return(NaN)
  print("I am not here")
  result <- 1
  while (int > 0) {
    result <- result * int
    int <- int - 1
  }
  
  return(result)
}

myfac2(4)


# ------------------------------------------------------------
# 11.2 Arguments
# ------------------------------------------------------------

multiples1 <- function(x, y) {
  out <- list()
  
  for (i in seq_along(x)) {
    if (is.matrix(x[[i]])) {
      out[[length(out) + 1]] <- x[[i]] %*% y
    }
  }
  
  if (length(out) == 0) {
    return("no valid matrices")
  }
  
  out
}

multiples1(list(matrix(1:4, 2, 2)), diag(2))


multiples1(list(1, 2, 3), stop("boom"))
multiples1(list(matrix(1:4, 2, 2)), stop("boom"))


f <- function(x, y) {
  x
}

f(1, stop("error"))



A <- matrix(1:4, 2, 2)
B <- matrix(1:6, 3, 2)

A %*% B

my_sum <- function(...) {
  sum(...)
}

my_sum(1, 2, 3, 4)


my_mean <- function(..., na.rm = TRUE) {
  mean(c(...), na.rm = na.rm)
}

my_mean(1, 2, 3, NA)

plot_wrapper <- function(x, y, ...) {
  plot(x, y, ...)
}

plot_wrapper(1:5, 1:5, col = "red", pch = 19)


f <- function(x, ...) {
  x + 1
}

f(5, something = "ignored")


f <- function(...) {
  args <- list(...)
  print(args)
}

f(a = 1, b = 2)


safe_mean <- function(x, ...) {
  if (!is.numeric(x)) return(NA)
  mean(x, ...)
}

safe_mean(c(1, 2, NA), na.rm = TRUE)

# ------------------------------------------------------------
# Extra examples
# ------------------------------------------------------------

# A grading function with defaults
grade_student <- function(score, pass_mark = 50) {
  if (score >= pass_mark) "pass" else "fail"
}

# A function factory-like example of argument reuse
power_fun <- function(x, power = 2) {
  x ^ power
}

# A function that accepts ... and passes it to sort()
sort_with_options <- function(x, ...) {
  sort(x, ...)
}

# A function that uses ... with data.frame()
make_student_df <- function(...) {
  data.frame(..., stringsAsFactors = FALSE)
}