\name{extractKeywords}
\alias{extractKeywords}
\title{Extract Keywords}
\description{
Extract keywords from text documents.
}
\usage{
extractKeywords(corpus, model, voc = "none", vocformat = "")
}
\arguments{
  \item{corpus}{A list of character vectors containing the text
    documents, e.g., a \code{Corpus} object as provided by
    package~\pkg{tm}, used for keyword extraction.}
  \item{model}{A character giving the path to a KEA model.}
  \item{voc}{A character pointing to a controlled vocabulary.}
  \item{vocformat}{A character giving the format of \code{voc}.}
}
\details{
A tutorial on keyword extraction is located at
\url{http://www.nzdl.org/Kea/Download/Kea-5.0-Readme.txt}. There you can
find details on the internals of KEA, including various parameter
settings (e.g., valid arguments for \code{voc} and \code{vocformat}).
}
\value{
  A list of character vectors corresponding to the keywords in
  \code{corpus}.
}
\references{\url{http://www.nzdl.org/Kea/}}
\author{Ingo Feinerer}
\seealso{\code{\link{createModel}}}
\keyword{file}
