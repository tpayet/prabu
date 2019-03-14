# Prabu

Prabu updates your ruby repository using `bundle update` and make a merge request.

## Environment variables

|            Env           |                                                  Usage                                                  |
|:------------------------:|:-------------------------------------------------------------------------------------------------------:|
|         REPO_NAME        | your full repo name without the url                                                                     |
|    GITLAB_API_ENDPOINT   | your gitlab api endpoint, if you are using gitlab.com it should be `https://www.gitlab.com/api/v4`      |
| GITLAB_API_PRIVATE_TOKEN | Personal acces token you can get on [gitlab](https://gitlab.com/profile/personal_access_tokens)          |
|       SLACK_WEBHOOK      | You slack webhook wich you setup [here](https://meilisearch.slack.com/apps/A0F7XDUAZ-incoming-webhooks) |

## Usage

```bash
$> bundle i

$> REPO_NAME=<your-repo> GITLAB_API_ENDPOINT=https://gitlab.com/api/v4 GITLAB_API_PRIVATE_TOKEN=<personal-token> SLACK_WEBHOOK=<slack-webhook> ruby prabu.rb
```

Docker:

```bash
$> docker build . -t prabu

$> docker run --rm -it -e REPO_NAME=<your-repo> -e GITLAB_API_ENDPOINT=https://gitlab.com/api/v4 -e GITLAB_API_PRIVATE_TOKEN=<personal-token> -e SLACK_WEBHOOK=<slack-webhook> prabu
```

Kubernetes:

```yaml
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: prabu
spec:
  schedule: "0 10 * * 1"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: prabu
            image: tpayet/prabu:latest
            imagePullPolicy: Always
            env:
            - name: REPO_NAME
              value: <your-repo>
            - name: GITLAB_API_ENDPOINT
              value: https://gitlab.com/api/v4
            - name: GITLAB_API_PRIVATE_TOKEN
              value: <personal-token>
            - name: SLACK_WEBHOOK
              value: <slack-webhook>
          restartPolicy: Never


```
