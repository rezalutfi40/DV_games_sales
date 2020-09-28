dashboardPage(title = "Games Sales Analysis",
              skin = "black",
              dashboardHeader(title = "Games Sales Analysis"),
              dashboardSidebar(
                  sidebarMenu(
                      menuItem(
                          text = "Top Games",
                          tabName = "game",
                          icon = icon("fas fa-trophy")
                      ),
                      menuItem(
                        text = "Top by Year",
                        tabName = "by_year",
                        icon = icon("far fa-calendar-alt")
                      ),
                      selectInput(inputId = "year",
                                    label = "Select Year",
                                    choices = sort(unique(vg$Year))
                      ),
                      
                      menuItem(
                        text = "Correlation",
                        tabName = "cor",
                        icon = icon("fas fa-link")
                      ),
                      radioButtons(inputId = "genre",
                                   label = "Select Genre", 
                                   choices = unique(vg$Genre)
                      ),
                      menuItem(
                          text = "About",
                          tabName = "about",
                          icon = icon("fas fa-user")
                      ),
                      menuItem(
                          text = "Data",
                          tabName = "data",
                          icon = icon("database")
                      )
                  )
              ),
              dashboardBody(
                tabItems(
                  tabItem(tabName = "game",
                          fluidRow(
                            column(width = 12, 
                                   box(width = 6,
                                       h3(strong("Top Publisher"),
                                          align = "center"),
                                       h2(strong("Nintendo"),
                                          align = "center"),
                                       background = "black"
                                   ),
                                   box(width = 6,
                                       h3(strong("Top Games"),
                                          align = "center"),
                                       h2(strong("Wii Sports"),
                                          align = "center"),
                                       background = "black"
                                   )
                            ),
                            column(width = 12,
                                   box(width = 6,
                                       h4(strong("Top 10 Games by Publisher"),
                                          align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_sales_by_pub")
                                       ),
                                   box(width = 6,
                                       h4(strong("Top 10 Games by Name"),
                                          align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_sales_by_name")
                                       )
                                   )
                            )
                          ),
                  tabItem(tabName = "by_year",
                          fluidRow(
                            column(width = 12,
                                   box(width = 12,
                                       h2(strong("Total Global Sales Games Each Year"),
                                          align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_game_sales")
                                   ),
                                   box(width = 4,
                                       h4(strong("Top Publisher by Year"),
                                       align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_sales_year_by_pub"),
                                       background = "black"
                                       ),
                                   box(width = 4,
                                       h4(strong("Top Platform by Year"),
                                          align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_sales_year_by_plat"),
                                       background = "black"
                                       ),
                                   box(width = 4,
                                       h4(strong("Top Games by Year"),
                                          align = "center"),
                                       status = NULL,
                                       plotlyOutput(outputId = "plot_sales_year_by_game"),
                                       background = "black"
                                   )
                                   ),
                            column(width = 12,
                                   box(width = 12,
                                       status = NULL
                                       )
                                   )
                            )
                          ),
                  tabItem(tabName = "cor",
                          fluidRow(
                            column(width = 12,
                                   box(width = 6,
                                       status = NULL,
                                       h3(strong("Most Correlated Region Sales vs Global Sales"),
                                          align = "center"),
                                       h2(strong("Nort America (NA)"),
                                          align = "center"),
                                       background = "black"
                                       ),
                                   box(width = 6,
                                       status = NULL,
                                       h3(strong("Most Uncorrelated Region Sales vg Global Sales"),
                                          align = "center"),
                                       h2(strong("Japan (JP)"),
                                          align = "center"),
                                       background = "black"
                                       )
                            ),
                            column(width = 12,
                                   box(width = 4,
                                       status = NULL,
                                       h4(strong("Global Sales vs Europe Sales"),
                                          align = "center"),
                                       plotlyOutput(outputId = "plot_cor_eu")
                                       ),
                                   box(width = 4,
                                       status = NULL,
                                       h4(strong("Global Sales vs North America Sales"),
                                          align = "center"),
                                       plotlyOutput(outputId = "plot_cor_na")
                                       ),
                                   box(width = 4,
                                       status = NULL,
                                       h4(strong("Global Sales vs Japan Sales"),
                                          align = "center"),
                                       plotlyOutput(outputId = "plot_cor_jp")
                                       )
                                   )
                            )
                          ),
                  tabItem(tabName = "data",
                          dataTableOutput(outputId = "data_set")
                          ),
                  tabItem(tabName = "about",
                          h1(strong("Data Visualization Capstone Project: Games Sales Analysis")),
                          h4("Create by Reza Lutfi Ismail"),
                          h4("This project contains Games Sales analysis in the world from 1980 - 2020, using r studio"),
                          h4("i got data from [kaggle] : https://www.kaggle.com/gregorut/videogamesales"),
                          h4("- EU Sales: Games sales in Euro"),
                          h4("- NA Sales: Games sales in North America"),
                          h4("- JP Sales: Games sales in Japan"),
                          h4("- Other_Sales: Sales in the rest of the world"),
                          h4("- Global_Sales: Total worldwide sales")
                          )
                      )
                  )
              )


