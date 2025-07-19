# Paris Lodgement Analysis
This project analyzes cleaned data on rental housing in Paris to uncover trends in rental prices, housing characteristics, and geographic distributions. Using R, the project aims to provide insights for policymakers, real estate professionals, and prospective tenants.

<p align="center">
  <img src="https://www.pousadasincriveis.com/wp-content/uploads/2023/07/Shangri-La-Paris10.jpg" 
       alt="Paris Lodgemen" 
       width="400"/>
</p>


## Project Overview
- **Objective**: Explore trends in rental prices and housing characteristics in Paris.
- **Data Source**: Cleaned dataset with 15,360 entries on Paris housing.
- **Key Variables**:
  - **Year**: Year of observation.
  - **Quarter**: Neighborhoods within Paris.
  - **District**: Arrondissement number.
  - **Rooms**: Number of rooms in the housing unit.
  - **Construction_Period**: Period when the housing was built.
  - **Rental_Type**: Type of rental (furnished or unfurnished).
  - **Reference_Rent**: Standard rent price.
  - **Latitude** / **Longitude**: Geographical coordinates of the property.


## Key Features
1. **Data Cleaning**:
   - Removed duplicate entries and handled missing values.
   - Standardized district and neighborhood names.
2. **Exploratory Data Analysis (EDA)**:
   - Trends in rental prices across districts and construction periods.
   - Correlation between the number of rooms and reference rent.
   - Geospatial distribution of rent prices in Paris.
3. **Visualization**:
   - Used `ggplot2` for visualizations of rent trends.
   - Mapped geographic variations with `leaflet`.
4. **Predictive Modeling**:
   - Built a regression model to predict reference rent based on housing features.
