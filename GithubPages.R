### Make github pages (master branch / docs as web site)
# The README.md file is copied to /docs. Make a link to the main html file in it
# html files, including figures and libs are copied to /docs
# pdf files are copied to /docs
# Source this file before committing

# Create the docs folder
if (!dir.exists("docs")) dir.create("docs")

# Copy knitted html files
htmlFiles <- list.files(pattern="*.html")
if (length(htmlFiles) > 0)
  file.rename(from=htmlFiles, to=paste("docs/", htmlFiles, sep=""))
# Figures
html_filesDir <- list.files(pattern="*_files")
if (length(html_filesDir) > 0) {
  sapply(paste("docs/", html_filesDir, sep=""), dir.create)
  sapply(paste("docs/", html_filesDir, "/figure-html", sep=""), dir.create)
  html_files <- list.files(path=paste(html_filesDir, "/figure-html/", sep=""), full.names = TRUE, recursive=TRUE)
  if (length(html_files) > 0)
    file.copy(from=html_files, to=paste("docs/", html_files, sep = ""), overwrite=TRUE)
}
#libs
libsDirs <- list.dirs(path="libs", full.names=TRUE, recursive=TRUE)
if (length(libsDirs) > 0) {
  sapply(paste("docs/", libsDirs, sep = ""), dir.create)
  libsFiles <- list.files("libs", full.names = TRUE, recursive=TRUE)
  file.copy(from=libsFiles, to=paste("docs/", libsFiles, sep = ""), overwrite=TRUE)
}

# Copy knitted pdf files
RmdFiles <- list.files(pattern="*.Rmd")
# Change .Rmd files extension
pdfFiles <- gsub(".Rmd", ".pdf", RmdFiles)
if (length(pdfFiles) > 0)
  file.rename(from=pdfFiles, to=paste("docs/", pdfFiles, sep=""))

# Copy README.md to docs
file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)
