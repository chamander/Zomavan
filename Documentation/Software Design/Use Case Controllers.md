# Use Case Controllers

## Key Points

- If there are new responsibilities that don't belong in existing architectural constructs, chuck it in here!
    - We can extract, and or abstract, in the future when a relationship can be drawn.
- Provides a view controller which displays their use case, to callers interested in showing a particular use case (e.g. Authentication).

## Description

Use Case Controllers provide the entry point into our different use cases, which reflect our user experiences.

An example of this concept is when multiple screen need to launch some modal flow (for example, signing in an authenticated user). In this situation, "Authentication" is a use-case, and while we may implement it the first time _as part_ of an existing flow, if we need to implement it in another screen, we may come to realise that we can extract all of "Authentication" into its own use-case.

## Developer Notes

### View Controller

Use Case Controllers provide the entry point into our different use cases. In iOS, this means they provide the UIViewController to display for their use case. 

While subject to the semantics of each controller's implementation, storing a reference to the base view controller means that if any object wants to display a particular use case's UI, it calls for the view controller of the corresponding use case. 

### Architectural Influence

Being a non-UIKit component, our use case controllers are the perfect candidate to capture dependencies, logic, and all the bloat that we may want in one place (removed from our UIKit View Controllers, for example). 

When introducing new logic, or unsure of where a particular responsibility belongs, a Use Case Controller is a good "inbox" to chuck new code, while we continue to work with the code and realise that there is a proper place for that code elsewhere, which leads to an abstraction/extraction.

This encourages iterative extraction, and helps to mitigate premature optimisation. 
