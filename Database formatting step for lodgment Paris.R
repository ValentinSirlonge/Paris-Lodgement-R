# Load Libraries
library(dplyr)
library(tidyr)  
 
# Load data
data <- read.csv("lodgement.csv",sep = ";", stringsAsFactors = FALSE)

# Cleaning and selecting columns
data_clean <- data %>%
  select(Année, Nom.du.quartier, Nombre.de.pièces.principales, 
         Epoque.de.construction, Type.de.location, Loyers.de.référence, 
         Loyers.de.référence.majorés, Loyers.de.référence.minorés, geo_point_2d) %>%
rename(
    Year = Année,
    Quarter = Nom.du.quartier,
    Rooms = Nombre.de.pièces.principales,
    Construction_Period = Epoque.de.construction,
    Rental_Type = Type.de.location,
    Reference_Rent = Loyers.de.référence,
    High_Reference_Rent = Loyers.de.référence.majorés,
    Low_Reference_Rent = Loyers.de.référence.minorés,
    Geo_Point = geo_point_2d
  )%>%
  
  # Split Geo_Point into Latitude and Longitude
mutate(
    Latitude = as.numeric(sub(",.*", "", Geo_Point)),
    Longitude = as.numeric(sub(".*,", "", Geo_Point))
  ) %>%
select(-Geo_Point)%>%

# Edit Construction_Period to change the names to English
mutate(Construction_Period = gsub("Avant", "Before", Construction_Period),
         Construction_Period = gsub("Apres", "After", Construction_Period))%>%

# Edit Rental_Type to change the names to English
mutate(Rental_Type = ifelse(Rental_Type == "meublé", "furnished",
                     ifelse(Rental_Type == "non meublé", "unfurnished", Rental_Type)))%>%

# Creating the district column  
mutate(
    District = case_when(
      Quarter %in% c("Palais-Royal", "St-Germain-l'Auxerrois", "Halles", "Vivienne") ~ 1,
      Quarter %in% c("Bonne-Nouvelle", "Mail", "Gaillon") ~ 2,
      Quarter %in% c("Arts-et-Metiers", "Enfants-Rouges", "Sainte-Avoie", "Archives") ~ 3,
      Quarter %in% c("Saint-Gervais", "Saint-Merri", "Notre-Dame", "Arsenal") ~ 4,
      Quarter %in% c("Val-de-Grace", "Jardin-des-Plantes", "Saint-Victor", "Sorbonne") ~ 5,
      Quarter %in% c("Monnaie", "Odeon", "Notre-Dame-des-Champs", "Saint-Germain-des-Prés") ~ 6,
      Quarter %in% c("Invalides", "Gros-Caillou", "Saint-Thomas-d'Aquin", "Ecole-Militaire") ~ 7,
      Quarter %in% c("Champs-Elysées", "Madeleine", "Europe", "Faubourg-du-Roule", "Place-Vendôme") ~ 8,
      Quarter %in% c("Faubourg-Montmartre", "Rochechouart", "Chaussée-d'Antin", "Saint-Georges") ~ 9,
      Quarter %in% c("Saint-Vincent-de-Paul", "Porte-Saint-Martin", "Porte-Saint-Denis", "Hôpital-Saint-Louis") ~ 10,
      Quarter %in% c("Saint-Ambroise", "Folie-Méricourt", "Roquette", "Sainte-Marguerite") ~ 11,
      Quarter %in% c("Bercy", "Picpus", "Bel-Air", "Quinze-Vingts") ~ 12,
      Quarter %in% c("Maison-Blanche", "Croulebarbe", "Salpêtrière", "Gare") ~ 13,
      Quarter %in% c("Parc-de-Montsouris", "Montparnasse", "Petit-Montrouge", "Plaisance") ~ 14,
      Quarter %in% c("Saint-Lambert", "Javel", "Javel 15Art", "Necker", "Grenelle") ~ 15,
      Quarter %in% c("Auteuil", "Muette", "Porte-Dauphine", "Chaillot") ~ 16,
      Quarter %in% c("Ternes", "Plaine de Monceaux", "Batignolles", "Epinettes") ~ 17,
      Quarter %in% c("Grandes-Carrières", "Clignancourt", "Goutte-d'Or", "La Chapelle") ~ 18,
      Quarter %in% c("Amérique", "Pont-de-Flandre", "Villette", "Combat") ~ 19,
      Quarter %in% c("Belleville", "Père-Lachaise", "Saint-Fargeau", "Charonne") ~ 20,
      TRUE ~ NA_integer_))%>%
      select(Year, Quarter, District, Rooms, everything())%>%

# Replacing empty cells with NA
mutate_all(~ ifelse(. == "" | . == " ", NA, .))

# Export to CSV
write.csv(data_clean, "data_cleaned_lodgement_paris.csv", row.names = FALSE)
