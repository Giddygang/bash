#!/usr/bin/env bash

# The file names
#TODO Define all file names used for this project
# The file paths
#TODO Define all file paths here
# The globals
LOG_FILE="test_activity.log"
#TODO Define all global variables required
# Time out periods
TIMEOUT=10
#TODO Define all timeout values here
function CSV_FILE_to_Array_Cred() {
	# Read the CSV file into an array
	IFS=',' read -ra array < "$credentials"
}

function log()
{
	activity="$1"
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")
  echo "$timestamp - $activity" >> test_activity.log
#	TODO Write activities to log files along with timestamp, pass argument as a string
#	Todo get current timestamp

}

function answer_file_creaton()
{
	# Create an answer file if it doesn't exist
	answer_file="$test_dir/answer_file.csv"
	if [[ ! -f "$answer_file" ]]; then
		touch "$answer_file"
	fi

	#TODO create answer csv file. If its already exists create a back up
}

function menu_header()
{
	echo "========================================================================================================================"
	echo " "
	echo "THIS IS A TEST ALL YOUR ACTIVITIES ARE RECORDED"
	echo " "
	echo "========================================================================================================================"
	echo " "
	echo " "
	echo "SELECT AN OPTION BELOW"
	echo " "

	select option in "SignIn" "SignUp" "EXIT"; do
        case $option in
            "SignIn")
                sign_in
            
                ;;
            "SignUp")
                sign_up
            #    break
                ;;
            "EXIT")
                echo "Exiting test"
				
				exit
                ;;
        esac
	done
}


# Load the question bank from a file
function load_questions() {
	if [[ -f "$1" ]]; then
		cat "$1" | tr '\r' '\n' > question_bank.txt
	elif [[ -f "question_bank.txt" ]]; then
		echo "Using default question bank file: question_bank.txt"
	else
		echo "Error: Could not find a question bank file"
			return 1
			exit
	fi

	# Randomize the order of the questions
	shuf -i 1-$(wc -l < question_bank.txt) > question_order.txt
}

function view_test_screen()
{
	if [[ -f "$output" ]]; then
		cat $output 
	else
		echo "No Tests taken."
		return 1
	fi
	# TODO UI for view a test.
	# 1. Display all questions from test to user with options answered by user.
	# 2. If it was not answered by user, show message 
	# 3. Read answers from csv file
	# 4. Do appropriate activities to log files
}

function test_screen()
{	 
	load_questions "$1"

  # Prompt the user with each question
	while read -r question_num; do
		question=$(sed -n "${question_num}p" question_bank.txt)
		options=$(echo "$question" | cut -d',' -f2-)
		echo " "
		read -p "Answer: " answer
		echo "$answer" >> $answer_file
		# writing both the question and the answer to an output file
		echo "Question,$question" >> $output
		echo "Answer,$answer" >> $output
		break
	done
	# TODO UI for test.
	# 1. Implement time out
	# 2. Pick and display random question from question bank
	# 3. Answers stores to csv files
	# 4. Do appropriate activities to log files
}

function test_menu()
{
    select option in "Take Test" "View Test" "Exit"; do
        case $option in
            "Take Test")
                test_screen
                break
                ;;
            "View Test")
                view_test_screen
                break
                ;;
            "Exit")
                break
                    ;;
            *)
                echo "Invalid option. Please select again."
                ;;
        esac
    done
}

function sign_in()
{
	# Prompt for username and password
	read -p "Enter username: " username
	read -s -p "Enter password: " password

	#checks if username is only alphabetical and password length is over limit
	if [[ !"$username" =~ ^[[:alpha:]]+$ && "${#password}" -lt 8 ]]; then
   		echo "Error: Invalid username or password"  
			return 1
	else
		CSV_FILE_to_Array_Cred 
		for i in "${array[@]}"; do
  			if [[ "$i" == "$username" ]]; then
				while [[ $(grep -c "^$username:$password$" $users_cred) -eq 1 ]]; do
					echo " "
					echo "welcome, $username!"
					test_menu
				done
			else 
				echo "Error: User does not exist."
				return 1
			fi
		done
		
	fi
}

function sign_up()
{
	# Prompt for username and password
	echo ""
	read -p "Enter a username: " username
	echo ""
	#checks if username is only alphabetical
	if [[ !"$username" =~ ^[[:alpha:]]+$ ]]; then
   		echo "Error: Invalid username format"
			return 1
	else
		CSV_FILE_to_Array_Cred 
		for i in "${array[@]}"; do
  			if [[ "$i" == "$username" ]]; then
    			echo "Error: THIS USER ALREADY EXISTS"
				return 1
  			fi
		done 
	fi
	
	echo ""
	read -s -p "Enter a password: " password
	echo ""
	#checks if password contains alphanumeric characters and symbols, also checks if the password is longer than 8 digits
	while [[ ! "$password" =~ ^[[:alnum:][:punct:]]+$ || "${#password}" < "8" ]]; do
		echo " "
		echo "YOUR PASSWORD DOES NOT MEET REQUIREMENTS OF EITHER LENGTH,A-Z(a-z),0-9 AND SYMBOLS"
		break
	done	
	
	echo ""
    read -s -p "Re-enter the password: " password2
    echo ""
	while [[ "$password" != "$password2" ]]; do
		echo "Passwords do not match. Please try again."
		read -s -p "Enter a new password: " password
		echo ""
		read -s -p "Re-enter the password: " password2
		echo ""
			break
    done

	# Write username to CSV file
	echo "$username" >> $credentials
	
	echo "$username:$password" >> $users_cred
    echo "User registered successfully."
	# TODO For user sign-up
	# 1. Read all user credentials and verify
	# 2. Time-out for entering password
	# 3. Set minimum length and permitted characters for username and password, prompt error incase not matching
	# 4. Check for same user name already exists.
	# 5. Do appropriate activities to log files
}

# Create a TestData directory if it doesn't exist
test_dir="$HOME/.TestData"
if [[ ! -d "$test_dir" ]]; then
    mkdir -p "$test_dir"
fi

# Create a user list file if it doesn't exist
credentials="$test_dir/credentials.csv"
if [[ ! -f "$credentials" ]]; then
	touch "$credentials"
fi

# Create a user credientials file if it doesn't exist
users_cred="$test_dir/users_cred.txt"
if [[ ! -f "$users_cred" ]]; then
	touch "$users_cred"
fi

# Create an output file for the question and asnwer pair if it doesn't exist
output="$test_dir/output.csv"
if [[ ! -f "$output" ]]; then
	touch "$output"
fi

# Create a log file if it doesn't exist
	test_activity="$test_dir/test_activity.log"
	if [[ ! -f "$test_activity" ]]; then
		touch "$test_activity"
	fi
# TODO Your main scropt starts here 
# 1. Creating a .TestData directory if it doesn't exist
# 2. Creating a .user_credentials.csv file if it doesn't exist

# Just loop till user exits
while [ 1 ]
do
	#log
	menu_header
	answer_file_creaton

	# TODO call the appropriate functions in order
done
