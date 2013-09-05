### R code from vignette source 'kea.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: kea.Rnw:15-18
###################################################
options(width = 75)
### for sampling
set.seed <- 1234


###################################################
### code chunk number 2: kea.Rnw:36-37
###################################################
library("RKEA")


###################################################
### code chunk number 3: kea.Rnw:46-61
###################################################
library("tm")
data("crude")

keywords <- list(c("Diamond", "crude oil", "price"),
                 c("OPEC", "oil", "price"),
                 c("Texaco", "oil", "price", "decrease"),
                 c("Marathon Petroleum", "crude", "decrease"),
                 c("Houston Oil", "revenues", "decrease"),
                 c("Kuwait", "OPEC", "quota"))

tmpdir <- tempfile()
dir.create(tmpdir)
model <- file.path(tmpdir, "crudeModel")

createModel(crude[1:6], keywords, model)


###################################################
### code chunk number 4: kea.Rnw:78-81
###################################################
extractKeywords(crude, model)

unlink(tmpdir, recursive = TRUE)


