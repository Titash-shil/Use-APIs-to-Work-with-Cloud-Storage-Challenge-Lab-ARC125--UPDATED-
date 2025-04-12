#!/bin/bash

# Define color variables
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'


clear

# Step 1: Create bucket1.json
cat > bucket1.json <<EOF
{  
   "name": "$DEVSHELL_PROJECT_ID-bucket-1",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF

# Step 2: Create bucket1
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" --data-binary @bucket1.json "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"

# Instructions before Step 3


# Step 3: Create bucket2.json
cat > bucket2.json <<EOF
{  
   "name": "$DEVSHELL_PROJECT_ID-bucket-2",
   "location": "us",
   "storageClass": "multi_regional"
}
EOF

# Step 4: Create bucket2
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" --data-binary @bucket2.json "https://storage.googleapis.com/storage/v1/b?project=$DEVSHELL_PROJECT_ID"

# Instructions before Step 5
echo ""
echo "${YELLOW_TEXT}${BOLD_TEXT}  Bucket2 has been created. Now Downloading the world.jpeg file.${RESET_FORMAT}"
echo ""

# Step 5: Download the image file
echo "${MAGENTA_TEXT}${BOLD_TEXT}Downloading the image file...${RESET_FORMAT}"
curl -LO https://raw.githubusercontent.com/ArcadeCrew/Google-Cloud-Labs/refs/heads/main/Use%20APIs%20to%20Work%20with%20Cloud%20Storage%20Challenge%20Lab/world.jpeg

# Instructions before Step 6

# Step 6: Upload image file to bucket1
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: image/jpeg" --data-binary @world.jpeg "https://storage.googleapis.com/upload/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o?uploadType=media&name=world.jpeg"

# Instructions before Step 7


# Step 7: Copy the image from bucket1 to bucket2
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" --data '{"destination": "$DEVSHELL_PROJECT_ID-bucket-2"}' "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/world.jpeg/copyTo/b/$DEVSHELL_PROJECT_ID-bucket-2/o/world.jpeg"

# Instructions before Step 8


# Step 8: Set public access for the image
cat > public_access.json <<EOF
{
  "entity": "allUsers",
  "role": "READER"
}
EOF


curl -X POST --data-binary @public_access.json -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/world.jpeg/acl"


read -p "${YELLOW_TEXT}${BOLD_TEXT}Have you checked the Lab progress till TASK 4? (Y/N) ${RESET_FORMAT}" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Great! Let's go ahead for next steps..."
else
    echo "Please check the progress till lab Task 4 and run the script again."
fi

# Instructions before Step 9


# Step 9: Delete the image from bucket1
curl -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1/o/world.jpeg"

# Instructions before Step 10


# Step 10: Delete bucket1
curl -X DELETE -H "Authorization: Bearer $(gcloud auth print-access-token)" "https://storage.googleapis.com/storage/v1/b/$DEVSHELL_PROJECT_ID-bucket-1"

echo
echo "${GREEN_TEXT}${BOLD_TEXT}|||||||||||||||||||||||||||||||||||||||||||||||||||||||${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              LAB COMPLETED SUCCESSFULLY!              ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}|||||||||||||||||||||||||||||||||||||||||||||||||||||||${RESET_FORMAT}"
echo

echo -e "${RED_TEXT}${BOLD_TEXT}Subscribe our Channel:(QwikLab Explorers)${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@qwiklabexplorers${RESET_FORMAT}"
echo
