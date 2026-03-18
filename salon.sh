#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~"
echo -e "\nWelcome to My Salon, how can I help you?\n"
MAIN_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  # get available services  
  SERVICE_ID_SELECTED=$($PSQL "SELECT service_id, name FROM services")
  # if no services available
  if [[ -z $SERVICE_ID_SELECTED ]]
  then
    # send to main menu
    MAIN_MENU "Sorry, we don't have available services"
  else
    # display available services
    echo "$SERVICE_ID_SELECTED" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
  fi
  # read selected service
  read SERVICE_ID_SELECTED
  # get service name
  SERVICE_NAME=$($PSQL "SELECT name FROM SERVICES WHERE service_id = $SERVICE_ID_SELECTED")
  # if not found
  if [[ -z $SERVICE_NAME ]]
  then
    # send to main menu
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    echo -e "\nWhat's your phone number?"
    # read phone number
    read CUSTOMER_PHONE
    # get phone number
    PHONE_NUMBER=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    # if not found
    if [[ -z $PHONE_NUMBER ]]
    then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      # read name
      read CUSTOMER_NAME
      # Saving data client
      SAVING_DATA_CLIENT_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    else
      # get the client number
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
      CUSTOMER_NAME=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')     
    fi
    # get the name associated with that phone number
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
    SERVICE_NAME=$(echo $SERVICE_NAME | sed -r 's/^ *| *$//g') 
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    # read time
    read SERVICE_TIME
    # Booking the appointment
    INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
  fi  
}
MAIN_MENU