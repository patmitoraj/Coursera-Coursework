## Put comments here that give an overall description of what your
## functions do

## Creates special matrix that can cache it's inverse

makeCacheMatrix <- function(x = matrix()) {
inv<- NULL
set<- function(y){
  x<<-y
  inv<<-NULL
}
get<-function() x
setInverse<-function() inv<<-solve(x)
getInverse<-function() inv
list(set=set, get=get, setInverse=setInverse, getInverse=getInverse)
}

## Computes the inverse of the special "matrix" returned by makeCacheMatrix##
cacheSolve <- function(x, ...) {
  inv<-x$getInverse()
  if(!is.null){
    message("getting cached inverse")
    return(inv)
  }
  data<-x$get
  inv<=solve(data,...)
  x$setInv(inv)
  inv
}

