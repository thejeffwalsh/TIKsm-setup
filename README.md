
# Cronus Monitoring
A modified version of the InfluxData 'TICK' Stack which uses Grafana as its UI and dynamically forms to the Kubernetes Cluster it is deployed on.

## Requirements

- Docker (v18.06+)

- A functional Kubernetes cluster (v.1.13+)

    > (Set up a Kubernetes Cluster](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network)

- 2GB RAM or more per node

- C Compiler

- Linux "Make"

> Recommended: Kubernetes v1.13 cluster running on three Ubuntu 18.04 Server VMs

## Installation

Clone the repo and dive in!

`git clone https://github.com/Eliforbes42/cronus-monitoring.git`

### Pre-Configuration

#### Slack Alert Bot
To allow Kapacitor to post alerts to your Slack channel, follow the instructions below.

1. [Create an Incoming Webhook for Slack.](https://api.slack.com/incoming-webhooks)

2. Modify the Kapacitor Configuration to post to your Slack Channel.

    2.1. Open up `/cronus-monitoring/charts/kapacitor/templates/config.yaml`

    2.2. Modify the `[[slack]]` section, [lines 134-142](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/kapacitor/templates/config.yaml#L134).
    
    2.3. Change the `workspace`, `url`, `channel`, and `username` as necessary.

> Experimental: [Change Slack Alerts to Email Alerts](https://github.com/Eliforbes42/cronus-monitoring/blob/master/scripts/README.md#slackalerttoemailsh)

#### Grafana 

##### Dashboards
- To automatically import your own Dashboards destined for Grafana, place all JSON files in the following folder: 

      /cronus-monitoring/charts/grafana/dashboards/

- The initialization and creation scripts will dynamically generate and import various dashboards for each node in your Kubernetes cluster using `scripts/generateDashboards.sh`.
  > [Want to make your own dynamic dashboards?](https://github.com/Eliforbes42/cronus-monitoring/blob/master/GRAFANA.md).

##### Login Details

You may modify the [login details](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/grafana/values.yaml#L112) if you desire.

### Setup
1.   Make all scripts executable, if you desire.
         
         cd cronus-monitoring/scripts

         chmod +x *.sh

2.   Run the initialization script.
                   
         sudo ./init.sh

        2.1.   Tiller may take longer than the allowed set-up time, so Helm Chart installation may fail. Try again with the following script:

         sudo ./create.sh

3.   Verify that the stack setup is operational

         ./verifySetup.sh

4.   Now that the stack is set up, define the TICKscripts.

        4.1 `./copyTickScripts.sh`  

        4.2 `./defineTickTasks.sh`

        4.2.1 -- If 4.2 doesn't work, run the commands below.       

        4.2.2 `./connectToKapacitorContainer.sh`

        4.2.3 `chmod +x TICKscripts/defineTasks.sh`

        4.2.4 `./TICKscripts/defineTasks.sh`

## Usage

-  `./startGrafana.sh`

- Username: admin

- Password: strongpassword

Then you can start using Grafana!

> You may also modify the [login details](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/grafana/values.yaml#L112) if you haven't already.

## Testing

- Chart Services & Deployments

    -  Unit test chart files and deployments

    -  `./scripts/helmTest.sh`

- Grafana

    - Simulated User Testing on Grafana dashboards

    - `./selenium/doorTest.sh`

- Kapacitor

    - Unit test TICKscripts

    - `./scripts/testTickScripts.sh`

    - *These tests are not truly functional yet*

- Stress Testing

    - `./siege/laySiege.sh`

- Test Framework Initialization

    - Selenium: `./selenium/initSelenium.sh`

    - Siege: `./siege/initSiege.sh`

    - Helm Unit-Test: `helm plugin install https://github.com/lrills/helm-unittest`

    - Kapacitor-Unit: `./scripts/initKapacitorUnit.sh`

        - *This framework is the only one not automatically installed.*

## Stack Manipulation

- Set up Stack:  `./scripts/create.sh`

- Remove Stack:  `./scripts/destroy.sh`

- Upgrade Stack: `./scripts/upgrade.sh`        

## Port Info
* Kube-State-Metrics: [`8085`](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/kube-state-metrics/values.yaml#L8)

* InfluxDB: [`8086`](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/influxdb/values.yaml#L103)

* Kapacitor: [`9092`](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/kapacitor/templates/config.yaml#L17)

* Grafana: [`80`](https://github.com/Eliforbes42/cronus-monitoring/blob/master/charts/grafana/values.yaml#L58)
