
#  ViaplayAssignmentF

# Goal

The user should be able to see the title of each section - Implemented
The app should work online and offline (after first request to the API) - Partially implemented 

# How did I approach the task (Flow)

* Used Post man API to see what kind of response I am receiving
* Created a Model respectively
* Created a Web service using new structured concurrency method (Async/Await)
* Created a ViewModel to map to fetch the response and map to the respective ViewModel
* I have used the approach of protocol and delegate to pass the data back to the view controller
* In the view controller I setup the delegates for the for the table view and await for the response  from the web service 
* Once the API is called the first time I set it to a local variable called section (army of sections) and used a singleton (userdefaults) set the value that data is saved to core data.
* The values from local variable are then used to display the Sections and respective content of those sections.
* I also implemented two test cases to check the type of ViaplaySection and Viewmodel using a mock service
*Tests have been Passed and View controller with Desired data is Displayed.

Ran into a Bug(Possible issue with tableview reload data) - offline implementation is not working.
* I tried to show the results from core data but have been run into an issue so I get empty carry of data from core data so the app does blank out when it does not have a network connection 


