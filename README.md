# Film_App

First Screen: 
Firs screen is a flash screen.Ther is only one background photo and second photo for logo.

Second Screen:
Second screen is movies collection screen. First time I create a CollectionView with constraints and with their cell. In cell import from library a UIImageView. 
Of course I make networkManager file where retrieved information from server and ImageView fill with movie posters. 
NetworkManager file also has error handling methods. First is network fail and second is server error. Second screen has also filters. 
Filters make with filterViewCell with .xib fail. In .xib are 4 buttons for filter the movies. 
With the second screen is required Core Data because Favorite Filter need to save movies.  
If you click on a movie poster on the second screen , you will be taken to the third page where detailed information about the movie will be displayed.

Third Screen:
Third screen you can see detailed information about the selected movie.
In  “MovieDetailsViewController.swift” file are methods which configure movie’s poster and details.. 
There is a button “Add to Favorite” and if we press this button selected movie will move to the second screen  favorites tab and the button’s text will be changed “Remove from Favorite”. 
If we press this button selected movie will be deleted from favorite tab.

By agreement, the GitHub version of my project doesn’t include any API Key. You will need any key to launch the app. 
For Example "ec6abd76b95a0d674c028f1e4be8c877"
