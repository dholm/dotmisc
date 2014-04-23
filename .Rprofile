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
options(repos = Filter(function(x) x != "@CRAN@", getOption("repos")))


##
# Default packages.
.env$packages <- c(# For setting the correct terminal width.
                   "setwidth")


##
# Interactive initialization.
if (interactive()) {
    local({
        require(utils, quietly = TRUE)

        # Set up user library path.
        lib.path <- Sys.getenv("R_LIBS_USER")
        if (lib.path == "") {
            lib.path <- file.path(Sys.getenv("HOME"), ".local", "lib", "R",
                                  "site-packages")
            Sys.setenv(R_LIBS_USER = lib.path)
        }
        if (!file.exists(lib.path)) {
            dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE,
                       mode = "755", showWarnings = FALSE)
        }

        # Install missing packages.
        need.filter <- function(x) !x %in% rownames(installed.packages())
        need.packages <- Filter(need.filter, .env$packages)
        if (length(need.packages)) {
            install.packages(need.packages)
        }

        if (!any(commandArgs() == "--no-readline")) {
            # Set default path to history, if unset.
            if (Sys.getenv("R_HISTFILE") == "") {
                history.path <- file.path(Sys.getenv("HOME"), ".Rhistory")
                Sys.setenv(R_HISTFILE = history.path)
            }
        }
    })

    # Fix terminal width.
    library("setwidth")
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
    if (interactive()) {
        require(utils)

        # Save command history.
        if (!any(commandArgs() == "--no-readline")) {
            try(savehistory(Sys.getenv("R_HISTFILE")))
        }
    }
}


# Local Variables:
# mode: R
# End:
