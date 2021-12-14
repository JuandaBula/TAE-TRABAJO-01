library(shiny)
library(shinythemes)
library(rsconnect)
library(leaflet)
library(sf)
library(plotly)

tipo_accidente <- c("Todos", "Atropello", "Caida de Ocupante", "Choque", "Incendio", 
                    "Volcamiento", "Otro")

barrios <- read_sf("C:/Users/jdbul/OneDrive/Escritorio/TRABAJO-1-TAE/Limite_Barrio_Vereda_Catastral.shp")
grupos_de_barrios <- c("Todas", levels(factor(barrios$NOMBRE_COM)))

ventanas_de_tiempo <- c("Diario", "Mensual")

ui <- fluidPage(theme = shinytheme("yeti"),
                navbarPage(
                  "AccApp",
                  
                  tabPanel("Inicio",
                           fluidRow(
                             column(4,
                                    h2("Presentado por:"),
                                    p("Juan Daniel Bula Isaza"),
                                    
                             ),
                             column(8,
                                    h1("Video explicativo AccApp"),
                                    HTML('<iframe width="560" height="315" src="https://www.youtube.com/watch?v=mXex3lggZgA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
                                    # responsive HTML('<pre><div class="video-responsive"><iframe src="https://www.youtube.com/embed/dQw4w9WgXcQ?start=46" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div><pre>'),
                             )
                           ),
                  ),
                  
                  tabPanel("Resumen",
                           mainPanel(
                             h1("Resumen"),
                             
                             p("La alta accidentalidad en la ciudad de Medellín, se ha convertido en un problema de salud pública, por esta razón, las entidades gubernamentales y el cuerpo de tránsito, requieren de campañas y metodologías fuertes con el fin de atacar dicha problemática."),
                             p("El objetivo principal de este trabajo, es realizar un aporte a dichas entidades gubernamentales, con el fin de atacar este problema social y de salud pública, donde tuvimos como base, los datos proporcionados por el portal MEData: [MeData](http://medata.gov.co/dataset/incidentes-viales) la cual, es una estrategia de datos de la ciudad de Medellín, que busca la apropiación, apertura y uso de los datos como herramienta de gobierno, de allí, se utilizó como ingrediente, la base de datos de incidentes viales en la ciudad de Medellín entre los años 2014  y 2021."),
                             h4("Si deseas ver el informe completo, puedes ingresar al siguiente link:"),
                             a(),
                           ) 
                           
                  ),
                  
                  tabPanel("Historico",
                           fluidRow(
                             column(4,
                                    h3("¡HOLA! Aquí puedes seleccionar el rango de años y el tipo de accidente para observar el historico de accidentes en Medellín"),
                                    sliderInput("slider_año",
                                                "Años:",
                                                min = 2014,
                                                max = 2019,
                                                value = c(2014, 2019)),
                                    selectInput("select_tipo_accidente",
                                                "Tipo de accidente:",
                                                choices = tipo_accidente),
                             ),
                             column(8,
                                    leafletOutput("Historico")
                             )
                           ),
                  ),
                  tabPanel("Prediccion", 
                           fluidRow(
                             column(4,
                                    h3("¡Aquí seleccionas la ventana de tiempo y el tipo de accidente para predecir!"),
                                    selectInput("select_ventana_tiempo",
                                                "Ventana de tiempo:",
                                                choices = ventanas_de_tiempo),
                                    selectInput("select2_tipo_accidente",
                                                "Tipo de accidente:",
                                                choices = tipo_accidente),
                             ),
                             column(8,
                                    plotlyOutput("Prediccion2020", height = "240px", width = "660px"),
                                    plotlyOutput("Prediccion2021", height = "240px", width = "660px"),
                             )
                           ),
                  ),
                  
                  tabPanel("Agrupamiento",
                           fluidRow(
                             column(4,
                                    h3("En esta sección, seleccionas la comuna para analizar clasificación de accidentalidad"),
                                    #textInput("select_comuna", "Comuna:", value = c("Todas")),
                                    selectInput("select_comuna",
                                                "Comuna:",
                                                choices = grupos_de_barrios),
                             ),
                             column(8,
                                    leafletOutput("Agrupamiento"),
                             )
                           ),
                  ),
                  
                )
) 