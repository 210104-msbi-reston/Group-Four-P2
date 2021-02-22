# Washington D.C. Hotel Travel Agency

## Project Description

This project is meant to replicate the data of a hotel booking agency working out of Washington, D.C. They store customers, hotels, and associated booking dates and payment info. The data is stored in a normalized SQL Server database, extracted, transformed, and loaded into a denormalized data warehouse using SQL Server Integration Services. It is then converted into an OLAP Cube and stored with SQL Server Analytics Services. The cube is used as a data source to generate elegant reports using SQL Server Reporting Services.

## Technologies Used

* Microsoft SQL Server
* SSIS
* SSAS
* SSRS

## Features

List of features
* Imports data from excel file to normalized database
* Imports data from database into data warehouse
* Creates an OLAP Cube
* Generates reports based on cost of booking and related dimensions (customer, payment type, date, room type, etc.)

To-do list:
* Add more fact tables and measures so there is more data to analyze
* Get more demographic info about our customers so that we know who to market to in the future

## Getting Started
   
git clone https://github.com/210104-msbi-reston/Group-Four-P2.git

## Usage

* Restore the database to SQL Server using TravelAgency.bak.
* Restore the data warehouse to SQL Server using TravelAgencyDW.bak.
* Restore the OLAP cube to SQL Analysis Server using TravelAgencySSAS.abf.
* Files used to generate reports from the cube are located in the TravelAgencySSRS folder.

## Contributors

Dakota Wells (Lead)

Ayanes Arapioannou

Robert Palmer

Spencer Barck

## License

This project uses the following license: [GNU General Public License](https://www.gnu.org/licenses/gpl-3.0.en.html).

