# Prabu

Prabu updates your ruby repository using `bundle update` and make a merge request.

## Environment variables

|            Env           |                                                  Usage                                                  |
|:------------------------:|:-------------------------------------------------------------------------------------------------------:|
|         REPO_NAME        | your full repo name without the url                                                                     |
|    GITLAB_API_ENDPOINT   | your gitlab api endpoint, if you are using gitlab.com it should be `https://www.gitlab.com/api/v4`      |
| GITLAB_API_PRIVATE_TOKEN | Personal acces token you can get on (gitlab)[https://gitlab.com/profile/personal_access_tokens          |
|       SLACK_WEBHOOK      | You slack webhook wich you setup (here)[https://meilisearch.slack.com/apps/A0F7XDUAZ-incoming-webhooks] |

## Usage

```bash
> REPO_NAME=<your-repo> GITLAB_API_ENDPOINT=https://gitlab.com/api/v4 GITLAB_API_PRIVATE_TOKEN=<personal-token> SLACK_WEBHOOK=<slack-webhook> ruby prabu.rb
```
