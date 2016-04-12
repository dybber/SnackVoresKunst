options(stringsAsFactors = FALSE)

data <- read.csv("daa_emuseum_output_05.04.2016.csv")

urls <- data[,c(1,9)]

for (i in 1:nrow(urls)) {
    if(!is.null(urls[i,2]) && urls[i,2] != "NULL") {
        tryCatch({
            download.file(urls[i,2], sprintf("images2/%05d.jpg", urls[i,1]))
        }, error = function (e) {})
    }
}
