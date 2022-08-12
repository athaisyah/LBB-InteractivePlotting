dashboardPage(
  
  skin = "purple",
  
  dashboardHeader(
    title = "NYC Growth Markets"
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("house")),
      menuItem("Stores", tabName = "stores", icon = icon("store")),
      menuItem("Map", tabName = "map", icon = icon("map")),
      menuItem("Data", tabName = "data", icon = icon("table"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # ------------- HALAMAN PERTAMA: OVERVIEW
      tabItem(
        tabName = "overview",
        
        # ---------- INFO BOXES
        fluidRow(
          infoBox("Total of all NYC Growth Market", count(grow_nyc), icon = icon("store"), color = "purple"),
          infoBox("Total of Borough in NYC", length(unique(nyc_cd_grow$county_name)), icon = icon("location-dot"), color = "yellow"),
          infoBox("Total of Type market", length(unique(nyc_cd_grow_type$type)), icon = icon("cart-shopping"), color = "purple")
        ),
        
        # ---------- BAR PLOT
        fluidRow(
          box(
            width = 12,
            title = "Growth Market in Each Borough",
            plotlyOutput(outputId = 'barplot')
          )
        )
      ),
      
      # ------------- HALAMAN KEDUA: 
      tabItem(
        tabName = "stores",
        
        # --------- INPUT
        fluidRow(
          box(
            width = 12,
            selectInput(
              inputId = "input_borough",
              label = "Choose Borough in NYC",
              choices = unique(nyc_cd_grow_type$borough_name)
            )
          )
        ),
        
        fluidRow(
          box(
            width = 12,
            plotlyOutput(outputId = "barplot2")
          )
        )
        
      ),
      
      # ------------- HALAMAN KETIGA: MAP
      tabItem(
        tabName = "map",
        fluidRow(
          box(
            width = 12,
            title = "Bachelor's or Higher and GROW NYC Markets",
            tmapOutput(outputId = "map")
          )
        )
        
      ),
      
      # ------------- HALAMAN KEEMPAT: DATA
      tabItem(
        tabName = "data",
        DT:: dataTableOutput(outputId = 'table')
      )
      
      
    )
    
    
  )
)