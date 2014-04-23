###
# Helper functions.
.env <- new.env()

.env$addrepo <- function(...) {
    options(repos=unique(c(getOption("repos"), c(...))))
}

## Stolen from: https://github.com/DarwinAwardWinner/Rprofile
# perldoc -f say
.env$say <- function(...) {
    stuff <- unlist(list(...))
    string <- paste(c(stuff, "\n"), collapse = "\n")
    cat(string)
}

## Stolen from: https://github.com/DarwinAwardWinner/Rprofile
# Get the source code for an object.
.env$sourcecode <- function(x) {
    .env$say(deparse(x), sep="\n")
}

## Stolen from: https://gist.github.com/stephenturner/5700920
# Show the first and last 10 items of an object.
.env$headtail <- function(d) rbind(head(d, 10), tail(d, 10))

## Stolen from: https://gist.github.com/stephenturner/5700920
# Read data on clipboard.
.env$read.cb <- function(...) {
    ismac <- Sys.info()[1] == "Darwin"
    if (!ismac) read.table(file = "clipboard", ...)
    else read.table(pipe("pbpaste"), ...)
}

## Stolen from: https://gist.github.com/stephenturner/5700920
# List all functions in a package.
.env$lspkg <- function(package, all.names = FALSE, pattern) {
    package <- deparse(substitute(package))
    ls(pos = paste("package", package, sep = ":"),
       all.names = all.names,
       pattern = pattern)
}

# Attach the new environment.
attach(.env)


##
# Don't echo anything from init.
sink("/dev/null")


##
# Basic configuration.
# Limit the number of printed lines.
options(max.print = 1000)

# Nicer prompt.
options(prompt="R> ")


##
# Set GUI framework.
if (.Platform$GUI == "X11" && Sys.info()[1] == "Darwin") {
    options(device = "quartz")
}


##
# Repositories.
# Use 0-Cloud CRAN mirror redirection.
.env$addrepo("http://cran.rstudio.com/")
# Add R-Forge repo.
.env$addrepo("http://r-forge.r-project.org")
# Don't ask which repo to use when installing a package.
options(repos=Filter(function(x) x != "@CRAN@", getOption("repos")))


if (!any(commandArgs() == "--no-readline") && interactive()) {
    if (Sys.getenv("R_HISTFILE") == "") {
        history_path = file.path(Sys.getenv("HOME"), ".Rhistory")
        Sys.setenv(R_HISTFILE = history_path)
    }
}

##
# Initialize R session.
.First <- function() {
    ##
    # Enable Echoing again.
    sink(NULL)
}

# Clean up R session.
.Last <- function() {
    # Save command history.
    if (!any(commandArgs() == "--no-readline") && interactive()) {
        require(utils)
        try(savehistory(Sys.getenv("R_HISTFILE")))
    }
}

# Local Variables:
# mode: R
# End:
