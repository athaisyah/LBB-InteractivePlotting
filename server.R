function(input, output) {
  
  # --------- HALAMAN PERTAMA: OVERVIEW
  output$barplot <- renderPlotly({
    
    # ggplot
    plot1 <- nyc_grow_count %>%
      ggplot(aes(x=count,
                 y=reorder(borough_name, count),
                 fill=count,
                 text=label)) +
      geom_col() +
      scale_fill_gradient(low = "#F39C12", high = "#605CA8") +
      theme_minimal() +
      theme(legend.position = "none") +
      labs(title = NULL,
           x = 'Growth Market Count',
           y = NULL)
    
    # plotly
    ggplotly(plot1, tooltip = "text")
    
    
  })
  
  # --------- HALAMAN KEDUA: STORES
  output$barplot2 <- renderPlotly({
    nyc_grow_store <- 
      nyc_cd_grow_type %>%
      filter(borough_name == input$input_borough) %>%
      group_by(type, county_name) %>%
      summarise(count = n())
    
    # penambahan tooltip
    nyc_grow_store <- 
      nyc_grow_store %>%
      mutate(label = glue("County: {county_name}
                     Growth Market: {count} Stores"))
    
    
    # ggplot
    plot2 <- nyc_grow_store %>%
      ggplot(aes(x = type,
                 y = count,
                 fill = count,
                 text = label)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      theme(legend.position = "none") +
      labs(title = glue("Stores for each type in {input$input_borough}"),
           x = NULL,
           y = 'Growth Market Count')
    
    # plotly
    ggplotly(plot2, tooltip = 'text')
  })
  
  
  # --------- HALAMAN KETIGA: MAP
  output$map <- renderTmap({
    nyc_ntas_grow_plot_tm <- tm_shape(nyc_ntas) +
      tm_fill(col = "pop_ba_above_pct_est",
              palette = "cividis",
              alpha = 0.7,
              title = "% Bachelor's or Higher",
              popup.vars = c("Neighborhood" = "nta_name",
                             "County" = "borough_name"),
              legend.format = percent_format()) +
      tm_layout(title = NULL) +
      tm_shape(grow_nyc_sf) +
      tm_dots(
        col = "type",
        border.col = "white",
        border.lwd = 0.8,
        border.alpha = 0.5,
        palette = "Greens",
        title = "Market Type",
        popup.vars = c("Days" = "day",
                       "Time" = "compost_hours",
                       "Duration" = "duration")) +
      tm_scale_bar()
  })
  
  
  # --------- HALAMAN KEEMPAT: DATA
  output$table <- renderDataTable({
    DT::datatable(grow_nyc,
                 options = list(scrollX = TRUE))
  })
  
}