# Stylometry

# 1. Install and call the package
install.packages("stylo")
library(stylo)

# Choose the right working directory!
# The one that contains the "corpus" folder
# Inside the corpus folder, there should be the texts in .txt format

# 2. Call stylo's main function
stylo()

# Here are some options to put between the brackets
# 
# # Language of the corpus
# 
# corpus.lang = ...
# - you can choose between "English", "German", "Italian", "Latin", and many others
# [Example]
# stylo(corpus.lang = "Italian")
# 
# # Most frequent words
# 
# mfw.min = ...
# - any integer number
# mfw.max = ...
# - any integer number
# mfw.incr = ...
# - any integer number
# 
# [Example]
# stylo(corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100)
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW)
# 
# # Distance measures 
# 
# distance.measure = "..."
# - you can choose between the following:
#   - "dist.delta"
#   - "dist.euclidean"
#   - "dist.manhattan"
#   - "dist.argamon"
#   - "dist.eder"
#   - "dist.simple"
#   - "dist.canberra"
#   - "dist.cosine"
#   - "dist.wurzburg"
#   - "dist.minmax"
# 
# [Example]
# stylo(corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100, distance.measure = "dist.wurzburg")
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW, using the Wurzburg distance, i.e., Cosine Delta)
# 
# # Analysis type (i.e. visualization)
# 
# analysis.type = 
# - you can choose between the following:
#   - "CA"
#     - (that is cluster analysis, i.e. dendrograms)
#   - "BCT"
#     - (that is bootstrap consensus tree)
# 
# [Example]
# stylo(corpus.lang = "Italian", mfw.min = 100, mfw.max = 1000, mfw.incr = 100, distance.measure = "dist.wurzburg", analysis.type = "BCT")
# - (this will perform 10 analyses with 100, 200, 300, etc. MFW, using the Wurzburg distance, i.e., Cosine Delta, and will use them to generate a single consensus tree)
# 
# Much more details are available here: https://github.com/computationalstylistics/stylo_howto/blob/master/stylo_howto.pdf
# Note that if you will install Rstudio in your laptop, stylo will also have a graphical interface to set up these features

# 2. Let's put this knowledge into action
stylo(corpus.lang="English", 
      mfw.min=200, 
      mfw.max=2000,
      mfw.incr=200,
      distance.measure="dist.wurzburg",
      analysis.type="BCT")

# 3. Explore the results
results_stylo <- stylo(corpus.lang="English", 
                       mfw.min=2000, 
                       mfw.max=2000,
                       distance.measure="dist.delta",
                       analysis.type="CA")
# Note: the results of the analysis have been saved in a variable called "stylo_results"

results_stylo$distance.table
# Note: the "$" symbol is used to see the sub-section in a structured variable

# see the name of the texts in the distance table
rownames(results_stylo$distance.table)

# see a portion of the distance table
# for example the one of the first text in our selection
results_stylo$distance.table[1,]

# which one is the "closest" text?
sort(results_stylo$distance.table[1,])

# see a table with the frequency of all words
results_stylo$frequencies.0.culling
# rows are the texts, columns the words

# produce a list of the most frequent words
colnames(results_stylo$frequencies.0.culling)

# which is the position in the table of the word "lights"
lights_position <- which(colnames(results_stylo$frequencies.0.culling) == "lights")

# which author uses "lights" more frequently?
sort(results_stylo$frequencies.0.culling[,lights_position], decreasing = T)

### Your turn!!
# Suggested activity: run the same analyses with a different selection of features

# 4. Stylo network
install.packages('networkD3')
stylo.network()
# note: between the brackets, you can add the features described above
