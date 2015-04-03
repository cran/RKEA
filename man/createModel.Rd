\name{createModel}
\alias{createModel}
\title{Create a KEA Model}
\description{
Create a keyphrase extraction model.
}
\usage{
createModel(corpus, keywords, model, voc = "none", vocformat = "")
}
\arguments{
  \item{corpus}{A list of character vectors containing the text
    documents, e.g., a \code{Corpus} object as provided by
    package \pkg{tm}.}
  \item{keywords}{A list of character vectors containing the keywords
    for each document in \code{corpus}.}
  \item{model}{A character giving the path where the created model
    should be stored.}
  \item{voc}{A character pointing to a controlled vocabulary.}
  \item{vocformat}{A character giving the format of \code{voc}.}
}
\details{
  A tutorial on keyword extraction is located at
  \url{http://www.nzdl.org/Kea/Download/Kea-5.0-Readme.txt}.
  There you can find details on the internals of KEA, including various
  parameter settings (e.g., details on vocabularies and supported
  formats for these).

  When controlled vocabularies are used (by default: no), the \code{voc}
  argument should give the file path to the respective files without
  their extensions.  When \code{vocformat} is \code{"skos"}, the
  extension must be \file{.rdf}; when \code{"text"}, there must be files
  with extensions \file{.en}, \file{.rel} and \file{.use}.
}
\value{
  Invisibly returns \code{model}, i.e., the path to the created KEA
  model.
}
\references{
  \url{http://www.nzdl.org/Kea/}
}
\author{Ingo Feinerer}
\seealso{
  \code{\link{extractKeywords}}
}
\keyword{file}
