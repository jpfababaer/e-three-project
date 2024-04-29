# 3E Fitness
3E is a gym scheduling application designed to streamline the booking process for personal training. This application enables the gym establishment to empower its members and personal trainers by offering them extra convenience. 3E offers its users an easier time managing their fitness experience, leaving the hassle in the hustle to work out.

# Table of Contents
- [Technologies Used](#technologies-used)
- [Main Features](#main-features)
- [Limitations](#limitations)
- [Contribution Guidelines](#contribution-guidelines)
- [FAQ](#faqs)

## Technologies Used
- Rails 7
- Bootstrap
- HTML/CSS
- Javascript
- Firstdraft (for ERD)

### Entity Relationship Diagram
https://gist.github.com/assets/100891759/d40088ee-a466-4890-87d8-14069c99d5fe

## Main Features

### Work Schedule Setup
Personal trainers have the power to determine their own work schedules. By selecting the day, their start and end time, they take control of their own work flow. Defining these work schedules enables members to find the days and times they are available to potentially book for a personal training session. 

https://gist.github.com/assets/100891759/1bdd74a9-3a47-4197-b542-a0bc9247dad4

### Member Bookings
Members of the gym can go on their personalized calendar to book for their desired personal training session. From the calendar, they can select their intended date to see all the available personal trainers. Within the form, they can select the time slot best for their schedule based on the personal trainer selected. 

https://gist.github.com/assets/100891759/b79118e1-b1e6-4b52-a73f-00be8650dc49

### Calendar Reminders
Both the personal trainers and the members have their own personalized calendars. These calendars contain the bookings (for members) and sessions (for trainers) that they have for a given month. This calendar is used to visualize and serve as a reminder for the fitness commitments a user may have. 

https://gist.github.com/assets/100891759/cfbf24eb-0e35-42ec-a574-321f13af3d25

## Limitations
1. Currently, 3E Fitness only works with one personal service, personal training. The goal is to give the gym establishment the ability to accurately define each of the amenties offered.

2. There is a need to implement exceptional dates when determining work schedules. This enables service providers the ability to block off specific dates, removing them from the available providers for that date. This would also include holidays.

3. Members would still need to pay for their booked services on site. In the future, the implementation of online payment is vital to streamlining the process of booking personal services. 

## Contribution Guidelines
If you would like to contribute to my scheduling application, kindly follow the guidelines below:

### Finding Issues
1. Look for issues to work on. Once found, briefly describe the issue by creating an "Issue" ticket in the Issue tab. 

### Conventions 
Please adhere to the Ruby conventions when contributing. More information on it here: [Ruby Style Guide](https://github.com/rubocop/ruby-style-guide)

  - Naming Conventions:
    - ```snake_case```: for variables, methods, and file names.
    - ```PascalCase```: for class and module names. 
    - NOTE: when naming anything, be concise and descriptive with your naming choice. The name should surmise the purpose of the object or file. 

  - Comments:
    - Like "naming conventions", ensure that your comments are concise and descriptive. 
    - If necessary, practice commenting as to "why" the code was made the way that it was. This gives others insight on the reasoning behind the implemention. 
    - Avoid commenting out code that is not needed. Ensure that your codespace is clutter free of superfluous code. 

  - Code Hygiene: 
    - Clear your controller of any business logic. When possible, abstract these functions within Service Objects. 
    - Use associations and methods within Models to adhere to the DRY principle. 

  - Branch Naming Conventions:
    - When creating a branch, please follow this naming convention:
    - ```<name-issue#-feature>``` (i.e. jp-11-landing-page)

  - Version Control:
    - Pull frequently, push infrequently, commit frequently and in detail.
    - For more guidelines on proper git control etiquitte. Visit this: [Git Etiquette](https://github.com/LeDuble/Git-Etiquette)

  - Pull Requests:
    - When creating a pull request, provide detailed description of the change you have made and would like to be implemented. 
    - Any pull request made requires the approval of me. 

### FAQs

1. SimpleCalendar Gem:
  - If you are interested in rendering your own calendar, please visit this link for detailed information on SimpleCalendar: [SimpleCalendar Gem](https://github.com/excid3/simple_calendar)

2. Bootstrap:
  - Most of the front-end facing portion of this application utilizes bootstrap. If you would like to know about its detailed usage, visit: [Bootstrap Docs](https://getbootstrap.com/docs/5.3/getting-started/introduction/)
