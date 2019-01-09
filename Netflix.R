echo= TRUE 
eval= TRUE



# ----------------------------------------------------get data into R
movies = read.table("movieLens.txt", header=FALSE, sep="|",quote="\"")
str(movies)

# Add column names
colnames(movies) = c("ID", "Title", "ReleaseDate", "VideoReleaseDate", "IMDB", "Unknown", "Action", "Adventure", "Animation", "Childrens", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "FilmNoir", "Horror", "Musical", "Mystery", "Romance", "SciFi", "Thriller", "War", "Western")
str(movies)

# Remove unnecessary and duplicates variables
movies$ID = NULL
movies$ReleaseDate = NULL
movies$VideoReleaseDate = NULL
movies$IMDB = NULL
movies = unique(movies)
str(movies)

#-----------------------------------------------------Clustring

# distances
distances = dist(movies[2:20], method = "euclidean")

# clustering
clusterMovies = hclust(distances, method = "ward.D") 

#dendrogram
plot(clusterMovies)

# Assign points to clusters
clusterGroups = cutree(clusterMovies, k = 10)


#percentage of movies in each genre and cluster

tapply(movies$Action, clusterGroups, mean)
tapply(movies$Romance, clusterGroups, mean)

# Create a new data set with just the movies from cluster 2
cluster2 = subset(movies, clusterGroups==2)

# Look at the first 10 titles in this cluster:
cluster2$Title[1:10]
clusterGroups = cutree(clusterMovies, k = 2)

clusterGroups
table(clusterGroups)

