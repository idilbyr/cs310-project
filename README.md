# FridgeNote
This project aims to create a mobile application that helps people keep track of the food in their fridge by providing a shared space among other people who have access to that fridge. The app will structure a database where the relevant and important information about each product, such as brand name and last usage date, is kept for a certain fridge. This fridge database can only be seen by the people who have access to.
## Group Members' Name/ID
Idil Bayar / 32267 \
Taha Yuşa Bayraktar / 32398\
Furkan Çetin / 32384 \
Berkan Çetin / 32055 \
Semih Kaş / 22575 \
Alp Mert Ekşi / 32119 

## The Problem
In the twenty-first century, consumption is a term that dominates our lives. Having access to a vast amount of different and exotic products and being able to store these products in our house enabled us to buy products without thinking thoroughly about them. Various market chains spread around the world. Now, nearly everyone can easily reach out to a random supermarket in their neighborhood. We humans are also social beings, meaning that we are adapted to live and survive in a small group. Furthermore, the increasing house expenses force people to rent a flat with their friends or continue to live with their parents. This results in multiple people sharing the same fridge in their apartments, dorms, or even in the workplace. This shareholding raises a certain problem: How do we track this mindless fast shopping past of each member who has access to our fridge? If we do not track what is bought for our fridge, there is a huge possibility that the same product can be bought again. Having the redundant necessity to look in the fridge and memorize everything inside is not a feasible solution. You can always call another person inside the house to tell you what is not necessary to buy, but there is no guarantee that a person will be home, nor will they pick up the phone on time. Our mobile app, FridgeNote, aims to resolve this dilemma and create an easy, user-friendly space to keep track of people's fridges in the modern era. FridgeNote is an application that can be appealing to a major part of society. From students to old married couples could find a beneficial aspect to utilize their daily life shopping and prevent spending unnecessary money or wasting food to a certain extent. 

## Features
### Core Features 
The app will have the following core features:
- Multiple users can interact with the app at the same time
- The possibility of 10 people sharing a fridge in the application.
- Main food categories to provide an easy layout to search for products
- Generating a link to share among other people so that they can enroll in the relevant fridge database
- Database storing information about the product: Name of the product, brand of the product, last usage date, amount of the product, and an extra notes section from the buyer.
- Deleting and adding products

### Additional Features
- Putting a mark at the beginning of the products whose expiration date is close.
- Creating your own shopping list to notify other members of the fridge that some products should be bought immediately or whenever they have the chance.

## Structure of the Project
The core functionality of the project lies in the dynamic database where users can interact. The FridgeNote usage logic will be the following: A user downloads the app and creates an account. Then, in the main menu, the user sees the icon that creates a new database for that user. After the user creates their fridge, they can name it uniquely. The app will show a new blank screen with main food categories such as vegetables, fruits, and milk products. The user can update these empty slots, or they can generate a link and send this link to other people who have access to the fridge. When another person clicks on that link, unless they have the application, they will be forwarded to the login page. When they enter the system, they can also start to update the virtual fridge. Users can enter their food by clicking the " add icon" in the relevant product space. The relevant information about the product can be written on the correct placeholders indicated by short and clear titles. When the user is satisfied with their answers, they can click to save button, and the answers will be stored in their fridge's allocated database till another user decides to delete that product. \
To summarize the structure of the FridgeNote, we can highlight the login and home pages, which are similar for every user. The virtual fridge layout  is the unique part for each user. It has subsections to display relevant food that is inside the real fridge at that moment. Clicking the food will display more information about the product in a list structure. Up to 10 people can access that virtual fridge and update the food inside. Any other user who does not have the link for that virtual fridge will not be granted any authority to see the virtual fridge. The FrdigeNote application creates a table for each virtual fridge and stores the relevant and useful information about each food as a row in that virtual table. This database table is stored in another Database Management System, and the exchange of the data will continue until every member of that virtual fridge user closes their application. \ 
The database will be generated and implemented by a famous database application, such as MongoDB. Access to a certain fridge will be determined by the credentials from the FridgeNote application. The login page, homepage, and virtual fridge space design do not have a certain layout structure for now. 
## Responsibility of each Team Member
- Project Coordinator: Berkan Çetin is responsible for arranging the group meetings and ensuring the team achieves its goals within a stable process. He must keep the team on schedule and keep the communication among both in group and between the TA and the group.
- Documentation & Submission: İdil Bayar and Alp Mert Ekşi are responsible for all written materials relevant to the project. They must track the deadlines of each written file submission. Furthermore, they have the obligation to express their project's overall logic clearly within the determined boundaries of the course.
- Testing & Quality Assurance: Furkan Çetin and Semih Kaş are responsible for reviewing and testing the FridgeNote app regularly. They  must evaluate the application run procedure and make sure that the code runs smoothly and as expected.
- Integration & Repository Lead: Taha Yüşa Bayraktar is responsible for managing the GitHub repository. He must resolve the merge conflict and the merge request as soon as possible.
## Platform
We are using Android Studio with the Flutter tool.
## Data
FridgeNote data is not generated by the developers but by the users. The code of the application is held in Android Studio. The data from the users will be held in an application specialized in Database Management Systems, such as MongoDB or Firebase.
## Challenges
The project has the following challenges:
- Maintaining multiple databases.
- Storing user credentials both individually and within the other shareholders securely.
- Properly handle user inputs.
- Having a consensus on the layout of the application, which provides a clean, easy-to-use, and achievable solution within the time interval.
