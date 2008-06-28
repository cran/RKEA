.onLoad <- function(libname, pkgname) {
    require("rJava")
    .jinit(system.file("java",
                       c("commons-logging.jar", "icu4j_3_4.jar", "iri.jar", "jena.jar", "kea-5.0.jar",
                         system.file("jar", "snowball.jar", package = "Snowball"),
                         system.file("jar", "weka.jar", package = "RWeka"), "xercesImpl.jar"),
                       package = pkgname,
                       lib.loc = libname))
}
