writeKeys <- function(keywords, filenames) {
    i <- 1
    for (k in keywords) {
        writeLines(paste(k, "\n", sep = "", collapse = ""), filenames[i])
        i <- i + 1
    }
}

createModel <- function(corpus, keywords, model, voc = "none", vocformat = "") {
    if (length(corpus) != length(keywords))
        stop("number of documents and keywords does not match")
    tmpdir <- tempfile()
    dir.create(tmpdir)
    tm::writeCorpus(corpus, path = tmpdir, filenames = paste(seq_along(corpus), ".txt", sep = ""))
    writeKeys(keywords, file.path(tmpdir, paste(seq_along(corpus), ".key", sep = "")))
    km <- .jnew("kea/main/KEAModelBuilder")
    .jcall(km, "V", "setDirName", tmpdir)
    .jcall(km, "V", "setModelName", model)
    .jcall(km, "V", "setVocabulary", voc)
    .jcall(km, "V", "setVocabularyFormat", vocformat)
    .jcall(km, "V", "buildModel", .jcall(km, "Ljava/util/Hashtable;", "collectStems"))
    .jcall(km, "V", "saveModel")
    unlink(tmpdir, recursive = TRUE)
    invisible(model)
}

extractKeywords <- function(corpus, model, voc = "none", vocformat = "") {
    tmpdir <- tempfile()
    dir.create(tmpdir)
    tm::writeCorpus(corpus, path = tmpdir, filenames = paste(seq_along(corpus), ".txt", sep = ""))
    ke <- .jnew("kea/main/KEAKeyphraseExtractor")
    .jcall(ke, "V", "setDirName", tmpdir)
    .jcall(ke, "V", "setModelName", model)
    .jcall(ke, "V", "setVocabulary", voc)
    .jcall(ke, "V", "setVocabularyFormat", vocformat)
    .jcall(ke, "V", "loadModel")
    .jcall(ke, "V", "extractKeyphrases", .jcall(ke, "Ljava/util/Hashtable;", "collectStems"))
    result <- lapply(file.path(tmpdir, paste(seq_along(corpus), ".key", sep = "")), readLines)
    unlink(tmpdir, recursive = TRUE)
    return(result)
}
