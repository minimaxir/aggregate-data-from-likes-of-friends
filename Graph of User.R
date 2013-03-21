library(RJSONIO)

username <- "max.woolf"
access_token <- "INSERT TOKEN HERE"

nrows <- 5000
likeCategories <- character()
likeNames <- character()

getSTDFriendURL <- function(name,token) {
  return (paste("https://graph.facebook.com/", name,"/friends?access_token=", token, sep = ""))
}

getSTDLikesURL <- function(name,token) {
  return (paste("https://graph.facebook.com/", name,"/likes?access_token=", token, sep = ""))
}

getProfileURL <- function(ID) {
  return (paste("https://facebook.com/", ID, sep = ""))
}

getCategoryName <- function(data) {
  data<- data[[1]]
  return ( data[which(names(data)==c("category","name"))])
}

JSONfriends <- fromJSON(paste(readLines(getSTDFriendURL(username,access_token)), collapse=""))
numFriends <- floor(length(JSONfriends[[1]]))

  for (JSONindex in 1:numFriends) {
    ID <- JSONfriends[[1]][[JSONindex]][[2]]
    JSONLikes <- fromJSON(paste(readLines(getSTDLikesURL(ID,access_token)), collapse=""))
    
    if (length(JSONLikes$data) > 0) {
      

      #x<-sapply(JSONLikes[[1]],unlist)
      #y<-t(apply(as.array(x),1,getCategoryName))
      
    try ({
      #likeData<- data.frame(t(sapply(JSONLikes[[1]],c)))
      likeData<-sapply(JSONLikes[[1]],unlist)
      likeData<-t(apply(as.array(likeData),1,getCategoryName))
      
      likeCategories <- append(likeCategories, unlist(likeData[,1]))
      likeNames <- append(likeNames, unlist(likeData[,2]))
      
    }, silent=T)
    
  }

  }

data_Categories <- data.frame(table(likeCategories))
data_Names <- data.frame(table(likeNames))

data_Categories<-data_Categories[with(data_Categories, order(-data_Categories$Freq,likeCategories)), ]
data_Names<-data_Names[with(data_Names, order(-data_Names$Freq,likeNames)), ]

barplot(data_Categories$Freq[1:5], main="Categories of FB Pages That My Friends Liked", xlab="Category", ylab="Total # of Pages", names.arg=data_Categories$likeCategories[1:5], col="#3b5998", border="#23487e")
dev.copy(png,"graph-friends.png", width=854, height=553)
dev.off()

write.csv(data_Categories[which(data_Categories$Freq>2),], paste(username,"-CategoryLikeCounts.csv",sep=""), row.names=F)
write.csv(data_Names[which(data_Names$Freq>2),], paste(username,"-NameLikeCounts.csv",sep=""), row.names=F)