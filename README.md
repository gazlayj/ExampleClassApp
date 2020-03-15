# ExampleClassApp

This application demonstrates several iOS architecture concepts:
 - Repository Layer
 - MVVM
 - Passing data between ViewControllers
 
 ## Repository Layer
 This is a layer that encapsulates the persistance / fetching of data for the app. It is responsible for tranforming that
 data into the models the app uses and consumes. We interact with the repository layer through a series of protocols. This
 allows us to change the implementation details / structures in the future without impacting the code the uses the Repository
 layer. 
 
 For instance if we start out without well defined protocols then we can change the way we store data, move from a single 
 repository object to several focused repository objects, add different layers for data persistance, data transforming and many
 other changes that might be useful later but we shouldn't worry about, without impacting any other code outside the Repository
 layer.
 
 ## MVVM
 MVVM creates a well defined and structured way to organize our code to ensure we have clear seperation of concerns.
 
 The first M is model. Our models should only be concerned about translating our problem domain into sensible code structures.
 Models should not have any reference or knowlegde of how they will end up be presented in the UI to the end user. 
 
 The V is the view. In iOS this often ends up be represented by both a combination of UIViews and UIViewControllers. Views
 should have no knowlegde about the models or the business logic surrounding models. They should simply consume View Models to 
 update themselves and inform View Models about how the user is interacting with them.
 
 Finally the VM is the View Model. This is the glue between the models and views. View Models are responsible for taking the
 models and transfroming them into the attributes the views need to display. For example information from the models that might
 need to be displayed as text, the view model should handle all formatting and localizing that is needed instead of leaving it 
 to the view controller to handle. They are also responsible for taking action on the models. So when a user edits something in
 the view, the view informs the view model which then can update the models themselves.
 
 Keeping these responsibilities in their correct places helps to keep your code clean and ensure well defined responsibilities
 and encapsulation.
 
 ## Passing Data Between View Controllers
 There are many different ways to be able to communicate data changes between different View Controllers but selecting the 
 correct ones for the job can difficult. 
 
 There are two ways this app passes data between view controllers:
 
 The first way is through view models. When a new view controller is created, it is instanciated with a view model that holds 
 the data it needs to know about. View models help simplify this a lot.
 
 The second way is through delegation. Delegation is great for informing a delegate view controller about what the delegator is
 doing. For instance in this app the EditClassViewController is used for both editing existing classes and creating new ones. 
 It uses the EditClassViewControllerDelegate to inform it's delegate that it has saved changes (either updating or creating a 
 new class). This allows the another View Controller who cares if that has happened to assign it's self as the delegate so it
 can respond approriately to the saved changes (like updating the ui for the edited class or refreshing the list of classes)
 
