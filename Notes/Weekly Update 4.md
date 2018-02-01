## Weekly Update 4

### Wins
1.  Spent some time figure out the best method for task management
    * settled on a combination using HourStack, Asana, Todoist, Zapier, and Google calendar
    * HourStack lets you grab tasks from Asana or Todoist or generate new tasks
    * you can set an allocated amount of time and start a timer
    * so far I've realized I am spending a lot more time on individual tasks then I thought
    * this tells me I need to break tasks into smaller subtasks more efficiently
2.  Worked on the new agave-r-sdk
    * mainly have been working out the bugs in the tutorial
    * been using best practice to open GitHub issues even though I'm chatting with the developer on Slack
    * there is a Docker container that can be used with rAgave package but I found I like running it on my own machine
    * I found a way to hide my login credentials as global environments to easily call in R
    * Still haven't figured out exactly how to read csv from Agave system directly to R dataframe
3.  Read a lot about Project Structures
    * theres a lot of good info for developing a single language app but when your using multple languages you have to do what works for your team best
    * modified the EnviroTyping repo on a new developing branch
    * linked the Premium repo as exclusive submodule
4.  Learned about developing documentation
    * Sphinx is the standout for developer documentation
    * The initial setup of Sphinx is easy to follow but the concepts require some thorough reading
    * setup a personal documentation repo to play around with
    * setup EnviroTying docs using Sphinx
    * waiting to hear from group on reStructuredText vs Markdown
5.  Wrote my first tutorial on using the TACC launcher module
    * created some R scripts to generate and process data
    * created a Bash script to create the launcherFile
    * wrote up a Markdown on the process
    * tested for bugs and seems to be working
    * need some testers

### Blocks
* errors with rAgave; to be expected on **early Alpha** release
* delayed communication with EnviroTyping team; waiting on feedback about the GitHub repo
* Overthinking some shell script operations; went down a rabbit hole; SoftwareCarpentry rescued me
