##
## Application name

* Name: go-jira
* URL: https://github.com/Netflix-Skunkworks/go-jira
* Version: 1.0.20

### Application source URL

## Docker image

* ubuntu:18.04

## Install

To build it by default, run `./build.sh`.


To build with a different version.

Run `./build.sh x.x.x`

## Setup go jira

### Create config file
Create a config file  `settings/config.yml` directory.

```shell
cp settings/config-template.yaml settings/config.yml
```
### Update config file

Replace ""
```
user: <jira-user>
password-source: pass
endpoint: <jira-url>
```
More settings please go to [go-jira](https://github.com/Netflix-Skunkworks/go-jira/)