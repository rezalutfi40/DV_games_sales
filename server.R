function(input, output) {
    
    output$plot_sales_by_pub <- renderPlotly({
        
        sales_by_pub <- vg %>% 
            select(Publisher, Year, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales) %>%
            group_by(Publisher) %>% 
            mutate(NA_Sales = sum(NA_Sales),
                   EU_Sales = sum(EU_Sales),
                   JP_Sales = sum(JP_Sales),
                   Other_Sales = sum(Other_Sales)) %>% 
            pivot_longer(c("NA_Sales","EU_Sales","JP_Sales","Other_Sales"),names_to = "Sales",values_to = "Value") %>% 
            distinct(Value, .keep_all = T) %>% 
            arrange(-Global_Sales) %>%
            mutate(Sales = str_replace_all(Sales, pattern = "_",replacement = " ")) %>% 
            head(40)
        
        plot_sales_by_pub <- sales_by_pub %>% 
            ggplot(aes(Value, reorder(Publisher, Value),
                       text = glue("Publisher: {Publisher}
                         Sales: {Value}")))+
            geom_col(position = "stack", aes(fill = Sales))+
            labs(title = "Top 10 Publisher by Sales",
                 x = "Sales (in Million Copies)",
                 y = NULL)+
            scale_y_discrete(labels = wrap_format(25))+
            scale_fill_manual(values = c("chocolate1","gray40","black","firebrick"))+
            theme_minimal()+
            theme(legend.position = "top")
        
        ggplotly(plot_sales_by_pub, tooltip = "text")
        
    })
    
    output$data_set <- renderDataTable({
        datatable(vg, options = list(scrollx = T))
        
    })
    
    output$plot_sales_by_name <- renderPlotly({
        
        sales_by_name <- vg %>% 
            select(Name, Publisher, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales) %>%
            group_by(Publisher) %>% 
            pivot_longer(c("NA_Sales","EU_Sales","JP_Sales","Other_Sales"),names_to = "Sales",values_to = "Value") %>% 
            arrange(-Global_Sales) %>% 
            mutate(Sales = str_replace_all(Sales, pattern = "_",replacement = " ")) %>% 
            head(40)
        
        plot_sales_by_name <- sales_by_name %>% 
            ggplot(aes(Value, reorder(Name, Value),
                       text = glue("Game: {Name}
                         Sales: {Value}")))+
            geom_col(position = "stack", aes(fill = Sales))+
            labs(title = "Top 10 Games by Sales",
                 x = "Sales (in Million Copies)",
                 y = NULL)+
            scale_y_discrete(labels = wrap_format(35))+
            scale_fill_manual(values = c("chocolate1","gray40","black","firebrick"))+
            theme_minimal()+
            theme(legend.position = "top")
        
        ggplotly(plot_sales_by_name, tooltip = "text")
        
    })
    
    output$plot_sales_year_by_pub <- renderPlotly({
        sales_year_by_pub <- vg %>% 
            select(Publisher, Year, Global_Sales) %>%
            filter(Year == input$year) %>% 
            group_by(Publisher) %>% 
            mutate(aggregate(Global_Sales~Publisher, FUN = sum)) %>%  
            arrange(-Global_Sales) %>%  
            distinct(Publisher, .keep_all = T) %>% 
            head(10)
    
    plot_sales_year_by_pub <- sales_year_by_pub %>% 
        ggplot(aes(Global_Sales, reorder(Publisher, Global_Sales),
                   text = glue("Publisher: {Publisher}
                         Sales: {Global_Sales}")))+
        geom_col(aes(fill = Publisher), fill = "chocolate1")+
        labs(x = "Sales (in Million Copies)",
             y = NULL)+
        scale_y_discrete(labels = wrap_format(25))+
        theme_minimal()+
        theme(legend.position = "none")
    
    ggplotly(plot_sales_year_by_pub, tooltip = "text")
   
    }) 
    
    output$plot_sales_year_by_plat <- renderPlotly({
        
        sales_year_by_plat <- vg %>% 
            filter(Year == input$year) %>% 
            select(Platform, Year, Global_Sales) %>%
            group_by(Platform) %>% 
            mutate(aggregate(Global_Sales~Platform, FUN = sum)) %>% 
            distinct(Platform, .keep_all = T) %>% 
            arrange(-Global_Sales)
        
        plot_sales_year_by_plat <- sales_year_by_plat %>% 
            ggplot(aes(Global_Sales, reorder(Platform, Global_Sales),
                       text = glue("Platform: {Platform}
                                   Sales: {Global_Sales}")))+
            geom_col(fill = "firebrick")+
            labs(x = "Sales (in Million Copies)",
                 y = NULL)+
            scale_y_discrete(labels = wrap_format(20))+
            theme_minimal()+
            theme(legend.position = "none")
    
        ggplotly(plot_sales_year_by_plat, tooltip = "text")
    
    })
    
    output$plot_sales_year_by_game <- renderPlotly({
        
        sales_year_by_game <- vg %>% 
            select(Name, Year, Global_Sales) %>%
            filter(Year == input$year) %>% 
            group_by(Name) %>% 
            mutate(aggregate(Global_Sales~Name, FUN = sum)) %>% 
            arrange(-Global_Sales) %>% 
            distinct(Name, .keep_all = T) %>% 
            head(10)
        
        plot_sales_year_by_game <- sales_year_by_game %>% 
            ggplot(aes(Global_Sales, reorder(Name, Global_Sales),
                       text = glue("Game: {Name}
                                   Sales: {Global_Sales}")))+
            geom_col(fill = "gray40")+
            labs(x = "Sales (in Million Copies)",
                 y = NULL)+
            scale_y_discrete(labels = wrap_format(20))+
            theme_minimal()+
            theme(legend.position = "none")
        
        ggplotly(plot_sales_year_by_game, tooltip = "text")
        
    })
    
    output$plot_game_sales <- renderPlotly({
        
        game_sales <- vg %>% 
            select(Year, Publisher, Global_Sales) %>% 
            group_by(Year) %>% 
            mutate(aggregate(Global_Sales ~ Year, FUN = sum)) %>% 
            distinct(Global_Sales, .keep_all = T)
    
        plot_game_sales <- game_sales %>%
            ggplot(aes(Year, Global_Sales, group = 1,
                       text = glue("Year: {Year}
                     Global Sales: {Global_Sales}")))+
            geom_line(color="firebrick", size=1, alpha=0.9)+
            geom_point()+
            labs(x = "Year",
                 y = "Global Sales (in Million Copies)")+
            scale_x_discrete(breaks = seq(1980,2020,5))+
            theme_minimal()  
        
        ggplotly(plot_game_sales, tooltip = "text")
        
    })
    
    output$plot_cor_eu <- renderPlotly({
        
    cor <- vg %>% 
        select(Genre, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales) %>% 
        filter(Genre == input$genre) %>% 
        group_by(Genre)
    
    plot_cor_eu <- cor %>% 
        ggplot(aes(Global_Sales, EU_Sales,
                   text = glue("Global Sales: {Global_Sales}
                               EU Sales: {EU_Sales}")))+
        geom_jitter(col = "firebrick")+
        geom_smooth()+
        labs(x = "Global Sales",
             y = "EU Sales")+
        theme_minimal()
    
    ggplotly(plot_cor_eu, tooltip = "text")
    
    })
    
    output$plot_cor_na <- renderPlotly({
    
    cor <- vg %>% 
        select(Genre, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales) %>% 
        filter(Genre == input$genre) %>% 
        group_by(Genre)
    
    plot_cor_na <- cor %>% 
        ggplot(aes(Global_Sales, NA_Sales,
                   text = glue("Global Sales: {Global_Sales}
                               NA Sales: {NA_Sales}")))+
        geom_jitter(col = "black")+
        geom_smooth()+
        labs(x = "Global Sales",
             y = "NA Sales")+
        theme_minimal()
    
    ggplotly(plot_cor_na, tooltip = "text")
    
    })
    
    output$plot_cor_jp <- renderPlotly({
        
        cor <- vg %>% 
            select(Genre, NA_Sales, EU_Sales, JP_Sales, Other_Sales, Global_Sales) %>% 
            filter(Genre == input$genre) %>% 
            group_by(Genre)
        
        plot_cor_jp <- cor %>% 
            ggplot(aes(Global_Sales, JP_Sales,
                       text = glue("Global Sales: {Global_Sales}
                               JP Sales: {JP_Sales}")))+
            geom_jitter(col = "chocolate1")+
            geom_smooth()+
            labs(x = "Global Sales",
                 y = "JP Sales")+
            theme_minimal()
        
        ggplotly(plot_cor_jp, tooltip = "text")
        
    })
    
    }

