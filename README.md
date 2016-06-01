# Box Document Uploader Demo

Using the [Box API](https://docs.box.com/reference) and [Boxr](https://github.com/cburnette/boxr), I have created a document uploader demo for the Bank of America loan application. On the home page, users can either log in as a customer or an employee. 

Once logged in as a customer, users can upload and delete their documents. All documents are stored in individual customer folders within the Bank of America Employee Box account.

Once logged in as an employee, the user can view all folders and files. 

### Installation

The demo requires [Rails](http://railsinstaller.org/en) and a [Box developer token](https://developer.box.com) to run.

To run the demo, first download the project. 

In the `login_controller.rb` and `documents_controller.rb` files, paste your developer token in the `get_client` method where `DEV TOKEN` is. 


cd to the project folder, then:
```sh
$ cd BoxApp
$ bin/rails server
```

Navigate to [localhost:3000](http://localhost:3000/) to view the demo

### Tech

Open source projects that were used:

* [Box API](https://docs.box.com/reference)
* [Boxr](https://github.com/cburnette/boxr)
* [Ruby](https://www.ruby-lang.org/en/downloads/)
* [Rails](http://railsinstaller.org/en) 
* [Twitter Bootstrap](http://getbootstrap.com/getting-started/#download)
* [CarrierWave](https://github.com/carrierwaveuploader/carrierwave)