# Setting up Food Coop Dev environment using docker

This setup is based on:

https://docs.google.com/document/d/1LdUcwCVMzIMcUidnwLA2zsryWFzxK8bxftR2VSzResU/edit

This directory provides a single docker image to run all services together.

You have to take a few steps before you run the docker container.

Here's the summary:

 * Install the right tools on your host
 * Prepare the code on your host
 * Launch the container
 * Import the data
 * Test
 * Develop

## Install the right tools

Please be sure you have [npm](https://www.npmjs.com/),
[git](https://www.git-scm.com/), and [docker](https://docker.io) installed.

## Checkout and prepare the code

If you are running Linux or Mac, you can run the included prepare script, which
will install everything in a directory called foodcop in your home directory.
If that's ok with you, then run:

```
./prepare
```

Otherwise... here are the manual directions.

 * Create a fresh directory where you want to keep all your dev files and
   change into that directory (e.g. "foodcoop").

 * Checkout the Wordpress code:
```
git clone --recursive git@github.com:foodcoop/foodcoop-test.git wordpress/foodcoop-test
```
 * Change back into your foodcoop directory and checkout the members API code:
```
git clone git@github.com:foodcoop/foodcoop-api.git api
```
 * Install api code dependencies
```
cd api
npm install
```
 * Copy the wp-config.php file into the wordpress directory (overwrite the 
   existing file).

 * Copy the config.json file into the api directory.

# Launch the container:

You have to modify this line! Please change the /PATH/TO/DATA with the path
to your checked out code as created above (e.g. /path/to/foodcoop).

docker run --name foodcoop \
  -v "PATH/TO/DATA/foodcoop:/var/www/foodcoop" \
  -p 127.0.0.1:3456:3456 \
  -p 127.0.0.1:6789:80 \
  foodcoop:latest runsvdir

# Import the data

To import the data, log into the container with:

docker exec -it foodcoop bash

Then run:

/root/import-data

It will take several minutes to complete.

# Test

You should be able to access the WordPress site with:

http://localhost:6789/foodcoop-test/

And access the Members API with:

http://localhost:3456/members/66202

Username: WordPress
Password: coop

# Develop

Now you can make changes to the files on your host computer and those
changes will automatically be made on the container.
