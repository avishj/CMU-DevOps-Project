#!/bin/bash

# Default admin credentials
ADMIN_USER="admin"
ADMIN_PASS="admin"

# Wait a bit more to ensure SonarQube is fully operational
sleep 10

echo "Generating SonarQube global analysis token..."

# First, change the default admin password if it hasn't been changed
# This is a best practice for security
NEW_ADMIN_PASS="YourSecurePassword123!"
curl -s -X POST "http://localhost:9000/api/users/change_password" \
  -u "${ADMIN_USER}:${ADMIN_PASS}" \
  -d "login=${ADMIN_USER}&previousPassword=${ADMIN_PASS}&password=${NEW_ADMIN_PASS}"

# Update credentials for subsequent requests
ADMIN_PASS="${NEW_ADMIN_PASS}"

# Generate a global analysis token
TOKEN_RESPONSE=$(curl -s -X POST \
  "http://localhost:9000/api/user_tokens/generate" \
  -u "${ADMIN_USER}:${ADMIN_PASS}" \
  -d "name=sonarqube-token-jenkins" \
  -d "type=GLOBAL_ANALYSIS")

# Extract token from response
TOKEN=$(echo $TOKEN_RESPONSE | grep -o '"token":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "Failed to generate token. Response: ${TOKEN_RESPONSE}"
  exit 1
fi

# Save token to shared volume
echo "Saving token to shared volume..."
echo "${TOKEN}" > /opt/sonarqube/tokens/sonarqube-token.txt
chmod 600 /opt/sonarqube/tokens/sonarqube-token.txt

echo "Token generation complete! Token saved to /opt/sonarqube/tokens/sonarqube-token.txt"
