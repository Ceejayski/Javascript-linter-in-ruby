# Javascript-linter-in-ruby
Microverse Capstone

This project is a Javascript linter that flags basic errors to include readablity.

Listed below are the methods built in this project:

-   `file_empty?`
-   `semicolon_check` 
-   `trailing_space`
-   `parenthesis_check`
-   `check_classname`
-   `last_line_space_check`
-   `error_sort`

`Good code`

```bash
class CarService{
    constructor(name,country){
        this.name = name;
        this.country = country;
    this.carsToRepairs = new Array();
    }
    addcar(car){
        this.carsToRepairs.push(car);
    }
}

```
`Bad code`

```bash
class 2carService{
    constructor(name,country){
        this.name = name
        this.country = country
    this.carsToRepairs = new Array()
    }
    addcar(car){
        this.carsToRepairs.push(car)
    }


```

`Good code`

```bash
class CarService{
    constructor(name,country){
        this.name = name;
        this.country = country;
    this.carsToRepairs = new Array();
    }
    addcar(car){
        this.carsToRepairs.push(car);
    }
}
#one line space
```
`Good code`

```bash
class CarService{
    constructor(name,country){
        this.name = name;
        this.country = country;
    this.carsToRepairs = new Array();
    }
    addcar(car){
        this.carsToRepairs.push(car);
    }
}

# multiple blank last line
# multiple blank last line
# multiple blank last line
```



### Project Structure

```bash 
├── README.md
├── bin
│   └── main.rb
└── lib
     └── linter_cops.rb

```

## Prerequisites
-  Text editor
-  Github profile
-  Git and Ruby.
-  Rubocop

## Installations

- Firstly, in order to run this on your local machine, you are going to need ruby already setup on your machine, so click this [link](https://rubyinstaller.org/) if you don't have ruby already installed and download for your specific machine.

## Test
    1. Open a terminal
    2. Run 'gem install rspec'
    3. Run rspec --init
    3. Run rspec in the terminal

## How to Run the Program



```
$ git clone https://github.com/Yors-git/tic-tac-toe
```
This linter checks all Javascript file(.js) within the folder, follow the steps below to get setup
- Open your git bash and clone the repo.

- go to the folder and copy out the bin and lib folder into your project directory

- run ./bin/main

- Good job you are now setup and ready to Check all your javascript file in project directory for linter error 👌🙌

## Authors:

👤 **Ceejayski**

- Github: [@Ceejayski](https://github.com/Ceejayski)

- LinkedIn: [LinkedIn](https://www.linkedin.com/in/chijioke-okoli-b0397a168/)

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse
- GitHub
- Theodinproject.com