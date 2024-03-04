# Introduction

Sample Flask app to test IAC templates deployments. Flask app calls [Wise Comparison](https://docs.wise.com/api-docs/api-reference/comparison) then renders partners transfer rates.

## Build and run App

From the project root DIR, build a docker image and run app. Sample commands below.

```bash
# Navigate to project source DIR
cd Sample_App

# Build docker image. Example: docker image build -t <desired image name>:<desired image tag> .
docker image build -t wise_app:0.1 .

# Run app.
docker run -d --name wise_app -p 3002:5000 wise_app:0.1
```
