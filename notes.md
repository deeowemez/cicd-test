# Create Docker file and Run container

```
docker build -t jenkins-with-node .
docker run -d \
 --name jenkins-node \
 -p 8080:8080 \
 -p 50000:50000 \
 -v jenkins_home:/var/jenkins_home \
 jenkins-with-node
```
# Setup Jenkins Admin account

1. Enter docker container through `docker exec -it jenkins-node bash` <br>
2. Retrieve password from `cat /var/jenkins_home/secrets/initialAdminPassword` in jenkins docker container <br>
3. Install suggested plugins

# Automatically trigger a build on every commit

### Set Up Global Tool Config
1. Select Mange Jenkins, then Tools
2. Under Git installations, input `/usr/bin/git/` as Path to Git executable

### Set Up a Jenkins Job for Your Repository

1. Go to Jenkins Dashboard → Click "New Item"
2. Enter a name → Choose "Pipeline"
3. Click OK

#### For Pipeline Job:

1. Under Trigger, select GitHub hook trigger for GITScm polling
2. Under Pipeline Definition, select Pipeline script from SCM
3. Choose Git and enter the repository URL: `https://github.com/deeowemez/cicd-test`

### Enable Webhooks for Automatic Builds

#### For GitHub:

1. Go to your GitHub repository → Click Settings
2. Under Webhooks, click "Add webhook"
3. Set Payload URL to: <br>
   `http://your-jenkins-server/github-webhook/` <br>
   <br>
   If you are using localhost, use ngrok to expose your localhost <br>
   `ngrok http 8080`
   <br>

   For errors reflecting in github: <br>

   _HTTP ERROR 403 No valid crumb was included in the request_ <br>

   Use the API Token in GitHub Webhook <br>
   - Generate API token by clicking Jenkins user, then security
   - Change your GitHub Webhook URL to: <br>
     `https://USERNAME:TOKEN@123456789.ngrok-free.app/github-webhook/`

4. Choose "Just the push event"
5. Set Content type to application/json
6. Click "Add webhook"

#### Alternative to Webhooks (Poll Git)

If webhooks are not an option, you can poll the repository:

1. In Jenkins Job → Build Triggers
2. Enable Poll SCM
3. Set the schedule (e.g., check every minute): <br>

   `* * * * *` <br>

   (Syntax: MIN HOUR DOM MON DOW → this runs every minute)

### Save and Run

1. Click "Save"
2. Click "Build Now" to test
3. Make a commit to your repo → Jenkins should automatically trigger a build
