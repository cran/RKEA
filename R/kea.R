RKEA_work_dir <- ""

writeKeys <-
function(keywords, filenames)
{
    i <- 1L
    for(k in keywords) {
        writeLines(paste(k, "\n", sep = "", collapse = ""), filenames[i])
        i <- i + 1L
    }
}

createModel <-
function(corpus, keywords, model, voc = "none", vocformat = "")
{
    if(length(corpus) != length(keywords))
        stop("number of documents and keywords does not match")

    cwd <- getwd()
    tmpdir <- tempfile()
    dir.create(tmpdir)
    on.exit({
        setwd(cwd)
        unlink(tmpdir, recursive = TRUE)
    })
    setwd(RKEA_work_dir)
    writeCorpus(corpus, path = tmpdir,
                filenames = sprintf("%s.txt", seq_along(corpus)))
    writeKeys(keywords,
              file.path(tmpdir, sprintf("%s.key", seq_along(corpus))))

    ## KEA does
    ##  System.err.println("-- Reading the Documents... ");
    ## which cannot easily be redirected to R's message connection.
    ## Hence, capture the Java messages directly.
    bos <- .jnew("java/io/ByteArrayOutputStream")
    err <- .jfield("java/lang/System", , "err")
    .jcall("java/lang/System", "V", "setErr",
           .jnew("java/io/PrintStream",
                 .jcast(bos,"java/io/OutputStream")))

    km <- .jnew("kea/main/KEAModelBuilder")
    .jcall(km, "V", "setDirName", tmpdir)
    .jcall(km, "V", "setModelName", model)
    .jcall(km, "V", "setVocabulary", voc)
    .jcall(km, "V", "setVocabularyFormat", vocformat)
    .jcall(km, "V", "buildModel",
           .jcall(km, "Ljava/util/Hashtable;", "collectStems"))
    .jcall(km, "V", "saveModel")

    ## And stop redirecting Java messages.
    .jcall("java/lang/System", "V", "setErr", err)
    ## Note that these would be available via
    ##   .jcall(bos, "Ljava/lang/String;", "toString")
    ## for output or returning ...

    invisible(model)
}

extractKeywords <-
function(corpus, model, voc = "none", vocformat = "")
{
    tmpdir <- tempfile()
    dir.create(tmpdir)
    on.exit(unlink(tmpdir, recursive = TRUE))
    writeCorpus(corpus, path = tmpdir,
                filenames = sprintf("%s.txt", seq_along(corpus)))
    
    ## KEA does
    ##  System.err.println("-- Extracting Keyphrases... ");
    ## which cannot easily be redirected to R's message connection.
    ## Hence, capture the Java messages directly.
    bos <- .jnew("java/io/ByteArrayOutputStream")
    err <- .jfield("java/lang/System", , "err")
    .jcall("java/lang/System", "V", "setErr",
           .jnew("java/io/PrintStream",
                 .jcast(bos,"java/io/OutputStream")))

    ke <- .jnew("kea/main/KEAKeyphraseExtractor")
    .jcall(ke, "V", "setDirName", tmpdir)
    .jcall(ke, "V", "setModelName", model)
    .jcall(ke, "V", "setVocabulary", voc)
    .jcall(ke, "V", "setVocabularyFormat", vocformat)
    .jcall(ke, "V", "loadModel")
    .jcall(ke, "V", "extractKeyphrases",
           .jcall(ke, "Ljava/util/Hashtable;", "collectStems"))

    ## And stop redirecting Java messages.
    .jcall("java/lang/System", "V", "setErr", err)
    ## Note that these would be available via
    ##   .jcall(bos, "Ljava/lang/String;", "toString")
    ## for output or returning ...
    
    lapply(file.path(tmpdir, sprintf("%s.key", seq_along(corpus))),
           readLines)
}
