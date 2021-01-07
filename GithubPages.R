### Make github pages (master branch / docs as web site)
# The README.md file is copied to /docs. Make a link to the main html file in it
# html files, including figures and libs are copied to /docs
# pdf files are copied to /docs
# Source this file before committing

# Create the docs folder
if (!dir.exists("docs")) dir.create("docs")

# Move knitted html files
htmlFiles <- list.files(pattern="*.html")
if (length(htmlFiles) > 0)
  file.rename(from=htmlFiles, to=paste("docs/", htmlFiles, sep=""))
# Copy css files
cssFiles <- list.files(pattern="*.css")
if (length(cssFiles) > 0)
  file.copy(from=cssFiles, to=paste("docs/", cssFiles, sep=""), overwrite=TRUE)
# Copy generated figures
html_filesDir <- list.files(pattern="*_files")
if (length(html_filesDir) > 0) {
  sapply(paste("docs/", html_filesDir, sep=""), dir.create, showWarnings=FALSE)
  sapply(paste("docs/", html_filesDir, "/figure-html", sep=""), dir.create, showWarnings=FALSE)
  html_files <- list.files(path=paste(html_filesDir, "/figure-html/", sep=""), full.names = TRUE, recursive=TRUE)
  if (length(html_files) > 0)
    file.copy(from=html_files, to=paste("docs/", html_files, sep = ""), overwrite=TRUE)
}
# Copy libs
libsDirs <- list.dirs(path="libs", full.names=TRUE, recursive=TRUE)
if (length(libsDirs) > 0) {
  sapply(paste("docs/", libsDirs, sep = ""), dir.create, showWarnings=FALSE)
  libsFiles <- list.files("libs", full.names = TRUE, recursive=TRUE)
  file.copy(from=libsFiles, to=paste("docs/", libsFiles, sep = ""), overwrite=TRUE)
}
# Copy static image files. MUST be in /images, may be in subfolders.
imagesDirs <- list.dirs(path="images", full.names=TRUE, recursive=TRUE)
if (length(imagesDirs) > 0) {
  sapply(paste("docs/", imagesDirs, sep = ""), dir.create, showWarnings=FALSE)
  imagesFiles <- list.files("images", full.names = TRUE, recursive=TRUE)
  file.copy(from=imagesFiles, to=paste("docs/", imagesFiles, sep = ""), overwrite=TRUE)
}

# Move knitted pdf files
RmdFiles <- list.files(pattern="*.Rmd")
# Change .Rmd files extension
pdfFiles <- gsub(".Rmd", ".pdf", RmdFiles)
if (length(pdfFiles) > 0)
  suppressWarnings(file.rename(from=pdfFiles, to=paste("docs/", pdfFiles, sep="")))

# Copy README.md to docs
file.copy(from="README.md", to="docs/README.md", overwrite=TRUE)

cat("Output files moved to docs/")
