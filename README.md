### Steps to Run the App
1. Download Xcode
2. Select iPhone simulator
3. Press run button
4. To see the empty state or malformed data state, go into RecipeViewModel.swift and uncomment out the different paths

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I priorited making the UI look nice and making a reusable networking class.
I think a nice looking UI is important for an app.  It doesn't have to be a work of art but should be visually appealing.
The reusable networking makes extending the app easier, e.g. adding a detail call

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
4 hours. 1 hour on setup and networking.  1 on making UI work. 1 on empty states, malformed states, mocking and tests. 1 checking that I met requirements and everything works. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I used the Recipe model directly in the RecipeCardView.  Since there was no data manipulation before showing it, I think it makes sense.  If I would have had to manipulate the strings, I would have made a view model for that.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I didn't make an iPad specific UI so there's a lof of empty space on the iPad design

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
