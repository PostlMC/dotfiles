options(papersize="letter")
# options(editor="notepad")
# options(pager="internal")

# R interactive prompt
options(prompt="> ")
options(continue="+ ")

# to prefer Compiled HTML
#help options(chmhelp=TRUE)
# to prefer HTML help
# options(htmlhelp=TRUE)

# General options
options(tab.width = 4)
options(width = 120)
options(graphics.record=TRUE)

.First <- function(){
#    library(Hmisc)
#    library(R2HTML)
    cat("\nSession start: ", format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"), "\n", sep="")
}

.Last <- function() {
    if (!any(commandArgs()=='--no-readline') && interactive()){
        require(utils)
        try(savehistory(Sys.getenv("R_HISTFILE")))
    }
    cat("\nSession end: ", format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"), "\n", sep="")
}
