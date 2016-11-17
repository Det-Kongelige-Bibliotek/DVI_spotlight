# README

This is a Spotlight application, potentially used in the Vest Indies project. 

## Installation
### Prerequisites
ImageMagick needs to be installed correctly, in order Spotlight to run properly. (Centos instructions)

1. Install ImageMagick
    * yum install ghostscript-fonts
    * cd /usr/local/src
    * wget http://www.imagemagick.org/download/ImageMagick.tar.gz
    * sudo tar xvzf ImageMagick.tar.gz
    * cd ImageMagick-7.0.3-6
    * sudo ./configure 
    * sudo make
1. Install ImageMagick-devel
    * yum install ImageMagick-devel

### How to run it
Clone the project under you desired local directory.
In the terminal run:
```
bundle install
rake db:migrate
``` 
#### Configure Solr
In order to use the local Solr, you have to create a new blacklight-core:
* First start Solr:
```
rake solr:start
```
* Create a local folder where you copy the schema.xml and solrconfig.xml from DVI_spotlight/solr/config/ folder.
* Go at http://127.0.0.1:8983/solr/#/ and create a new core with:
    * name: blacklight-core
    * instanceDir: 'the local path with the xml files'
* Test that it works:
```
rake spotlight:check:solr
```
    
#### Create an admin 
You can create a new admin entirely from the command line:
```
rake spotlight:initialize 
```
Or if you want to give admin rights to an existing user:
```
rake spotlight:admin  
```

Your local application should be up and running. Check it by creating a new exhibit and manually adding items to it.

BE AWARE that the images you upload need to be jpg, jpeg or png and have the right extension at the file name!
