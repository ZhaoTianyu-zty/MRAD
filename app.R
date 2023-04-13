library(shiny)
library(shinydashboard)
library(shinythemes)
library(shinyWidgets)
library(shinycustomloader)
library(bslib)
library(tidyverse)
library(readxl)
library(DT)
library(data.table)
library(plotly)
library(htmlwidgets)

# Load Data
data1 = readRDS('Data/data1.RDS')
data2 = readRDS('Data/data2.RDS')
data3 = readRDS('Data/data3.RDS')
id_exposure = readRDS('Data/id_exposure.RDS')


ui = navbarPage(title = tags$img(src = 'Picture/logo.png',
                                 style = 'height: 80px'),
                id = 'alltabs',
                windowTitle = 'MARD',
                inverse = T,
                collapsible = T,
                
                theme = bs_add_variables(bs_theme(bootswatch = bootswatch_themes()[20], # bootswatch_themes()[20] 
                                                  # bg = '#343c8c',
                                                  # fg = '#343c8c',
                                                  primary = '#343c8c',
                                                  secondary = 'white'),
                                         'body-bg' = 'white',
                                         'font-size' = '100%'),
                
                tabPanel(title = tags$text('Home',style = 'color: white; font-size: 20px'),
                         value = 'home',
                         
                         fluidRow(tags$h4("Mendelian randomization for Alzheimer's disease",
                                          style = 'text-align: center; color: black')),
                         fluidRow(column(width = 2),
                                  column(width = 8,
                                         searchInput(
                                           inputId = 'search_content',
                                           label = NULL,
                                           value = '',
                                           resetValue = '',
                                           placeholder = 'e.g. LDL cholesterol, ebi-a-GCST000759',
                                           btnSearch = icon(name = 'glyphicon glyphicon-search',
                                                            lib = 'glyphicon',
                                                            style = 'color: #343c8c'),
                                           btnReset = icon('xmark',
                                                           style = 'color: #343c8c'),
                                           width = '100%')),
                                  column(width = 2)),  # 搜索框
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 25%',
                                                    align = "left",
                                                    tags$text("The MRAD(Mendelian randomization for Alzheimer's disease) app was created to identify risk or protective factors for Alzheimer's disease. The Inverse Variance Weighted (IVW) random effects model was used as the primary analytical method to performed mendelian randomization analysis. To assess the robustness of the IVW results, 6 other models were used as sensitivity analyses. Meanwhile, heterogeneity test and egger intercept test were used to assess heterogeneity and horizontal pleiotropy. The app includes 73,129 records based on IVW method, of that 4,840 exposure traits split into 10 categories, with MR results available for multiple Alzheimer's disease outcome GWAS. Click ",
                                                              style = 'font-size: 100%; color: black'),
                                                    
                                                    actionLink(inputId = 'home_to_study_design',
                                                               label = 'here',
                                                               style = 'font-size: 100%; color: red; text-decoration:none'),
                                                    
                                                    tags$text(' to see our study design.',
                                                              style = 'font-size: 100%; color: black')),
                                            tags$td(style = 'width: 50%',
                                                    align = 'center',
                                                    tags$div(tags$img(src = 'Picture/Home.png',
                                                                      style = 'width: 80%; height: 80%; display: block; margin-left: auto; margin-right: auto'))),
                                            tags$td(style = 'width: 25%',
                                                    align = 'left',
                                                    
                                                    tags$text('You can only choose one option below:',
                                                              style = 'color: grey; opacity: 1'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 80%; opacity: 0')),
                                                    
                                                    checkboxInput(inputId = 'disease',
                                                                  label = tags$text('Disease',
                                                                                    style = 'color: #6b99d0; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'medical_laboratory_science',
                                                                  label = tags$text('Medical laboratory science',
                                                                                    style = 'color: #de8443; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'imaging',
                                                                  label = tags$text('Imaging',
                                                                                    style = 'color: #a4a4a4; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'anthropometric',
                                                                  label = tags$text('Anthropometric',
                                                                                    style = 'color: #f5c343; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'treatment',
                                                                  label = tags$text('Treatment',
                                                                                    style = 'color: #7c89c0; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'molecular_trait',
                                                                  label = tags$text('Molecular trait',
                                                                                    style = 'color: #7eab54; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'gut_microbiota',
                                                                  label = tags$text('Gut microbiota',
                                                                                    style = 'color: #b8a9a6; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'past_history',
                                                                  label = tags$text('Past history',
                                                                                    style = 'color: #934d20; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'family_history',
                                                                  label = tags$text('Family history',
                                                                                    style = 'color: #636363; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F),
                                                    
                                                    checkboxInput(inputId = 'lifestyle_trait',
                                                                  label = tags$text('Lifestyle trait',
                                                                                    style = 'color: #937424; font-weight: bold; font-size: 100%; text-decoration:none'),
                                                                  value = F)))),
                         
                         fluidRow(tags$text('x',style = 'font-size: 200%; opacity: 0')),
                         
                         tags$table(style = 'width: 100%',
                                    tags$tr(tags$td(style = 'width: 100%',
                                                    align = 'center',
                                                    tags$text("Copyright © 2023 Tianyu Zhao. All Rights Reserved.",
                                                              style = 'text-align: center; color: #939393; font-size: 100%')))),
                         
                         tags$div(style = "width:300px; margin:0 auto; padding:20px 0;",
                                  align = 'center',
                                  
                                  tags$a(
                                    target = "_blank",
                                    style = "display:inline-block;text-decoration:none;height:20px;line-height:20px;",
                                    href = "http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=22017202000367",
                                    tags$img(src = "Picture/beian.png",
                                             style = "float:left;"),
                                    tags$p(style = "float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px; color:#939393;",
                                           '吉公网安备 22017202000367号')),
                                  
                                  tags$a(
                                    target = "_blank",
                                    style = "display:inline-block;text-decoration:none;height:20px;line-height:20px;",
                                    href = "https://beian.miit.gov.cn/",
                                    tags$p(style = "float:left;height:20px;line-height:20px;margin: 0px 0px 0px 5px; color:#939393;",
                                           '吉ICP备2023001303号-1'))
                         )
                         
                         
                         
                         
                ),
                
                tabPanel(title = tags$text('Study design',style = 'color: white; font-size: 20px'),
                         value = 'study_design',
                         
                         fluidRow(title = 'Study Design',
                                  tags$div(tags$img(src = 'Picture/study design.png',
                                                    style = 'width: 100%; display: block; margin-left: auto; margin-right: auto'))),
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(
                                      tags$td(style = 'width: 40%; height: 100%',
                                              align = 'left'),
                                      
                                      tags$td(style = 'width: 3%; height: 100%',
                                              align = 'center',
                                              tags$text('x',style = 'opacity: 0')),
                                      
                                      tags$td(style = 'width: 57%; height: 100%',
                                              align = 'left',
                                              tags$text('You can only choose one option below:',
                                                        style = 'color: grey; opacity: 1')))),
                         
                         fluidRow(tags$text('x',style = 'font-size: 80%; opacity: 0')),
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%; height: 100%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/method.png',
                                                             style = 'width: 100%; display: block; margin-left: auto; margin-right: auto'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 100%; opacity: 0'))
                                                    
                                                    
                                    ),
                                    
                                    tags$td(style = 'width: 3%',
                                            align = 'center',
                                            tags$text('x',style = 'opacity: 0')),
                                    
                                    tags$td(style = 'width: 57%; height: 100%',
                                            align = 'left',
                                            checkboxInput(inputId = 'data2_42335',
                                                          label = tags$text(tags$text('Basic information of ',
                                                                                      style = 'color: black; font-size: 100%'),
                                                                            tags$text('42335',style = 'font-size: 100%; font-weight: bold; color: red; text-decoration:none'),
                                                                            tags$text('GWAS summary datasets on OpenGWAS',
                                                                                      style = 'color: black; font-size: 100%')),
                                                          value = F,
                                                          width = '100%'),
                                            
                                            checkboxInput(inputId = 'data2_18097',
                                                          label = tags$text(tags$text('Basic information of ',
                                                                                      style = 'color: black; font-size: 100%'),
                                                                            tags$text('18097',style = 'font-size: 100%; font-weight: bold; color: red; text-decoration:none'),
                                                                            tags$text(' exposure GWAS traits',
                                                                                      style = 'color: black; font-size: 100%')),
                                                          value = F,
                                                          width = '100%'),
                                            
                                            checkboxInput(inputId = 'data2_16',
                                                          label = tags$text(tags$text('Basic information of ',
                                                                                      style = 'color: black; font-size: 100%'),
                                                                            tags$text('16',style = 'font-size: 100%; font-weight: bold; color: red; text-decoration:none'),
                                                                            tags$text(" Alzheimer's disease outcome GWAS traits",
                                                                                      style = 'color: black; font-size: 100%')),
                                                          value = F,
                                                          width = '100%')
                                            
                                    ))),
                         
                         fluidRow(tags$text('x',style = 'font-size: 250%; opacity: 0')),
                         
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/80.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                    
                                                    checkboxInput(inputId = 'data3_80',
                                                                  label = tags$text(tags$text('80',style = 'font-size: 100%; font-weight: bold; color: #4674f8; text-decoration:none'),
                                                                                    tags$text(' exposure traits with consistent effect across three main outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_6',
                                                                  label = tags$text(tags$text('6',style = 'font-size: 100%; font-weight: bold; color: #7e7469; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of effect on AD_ieu-b-5067 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_102',
                                                                  label = tags$text(tags$text('102',style = 'font-size: 100%; font-weight: bold; color: #90ce27; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of effect on AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_119',
                                                                  label = tags$text(tags$text('119',style = 'font-size: 100%; font-weight: bold; color: #82e652; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of effect on AD_ieu-b-2 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_223',
                                                                  label = tags$text(tags$text('223',style = 'font-size: 100%; font-weight: bold; color: #1eea04; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of effect on AD_ieu-b-2',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_57',
                                                                  label = tags$text(tags$text('57',style = 'font-size: 100%; font-weight: bold; color: #4c895e; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of effect on AD_ieu-b-2 and AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_270',
                                                                  label = tags$text(tags$text('270',style = 'font-size: 100%; font-weight: bold; color: #985fc7; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of effect on AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 250%; opacity: 0'))
                                                    
                                            ))),
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/63.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                   
                                                    checkboxInput(inputId = 'data3_63',
                                                                  label = tags$text(tags$text('63',style = 'font-size: 100%; font-weight: bold; color: #4976f8; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with positive effect across three main outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_4c',
                                                                  label = tags$text(tags$text('4',style = 'font-size: 100%; font-weight: bold; color: #81786c; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of positive effect on AD_ieu-b-5067 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_48',
                                                                  label = tags$text(tags$text('48',style = 'font-size: 100%; font-weight: bold; color: #8cc925; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of positive effect on AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_41',
                                                                  label = tags$text(tags$text('41',style = 'font-size: 100%; font-weight: bold; color: #82e652; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of positive effect on AD_ieu-b-2 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_65',
                                                                  label = tags$text(tags$text('65',style = 'font-size: 100%; font-weight: bold; color: #5ae460; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of positive effect on AD_ieu-b-2',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_35',
                                                                  label = tags$text(tags$text('35',style = 'font-size: 100%; font-weight: bold; color: #4c895e; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of positive effect on AD_ieu-b-2 and AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_149',
                                                                  label = tags$text(tags$text('149',style = 'font-size: 100%; font-weight: bold; color: #7526b2; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of positive effect on AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 250%; opacity: 0'))
                                                    
                                            ))),
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/16.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                   
                                                    checkboxInput(inputId = 'data3_16',
                                                                  label = tags$text(tags$text('16',style = 'font-size: 100%; font-weight: bold; color: #4875f8; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with negative effect across three main outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_2',
                                                                  label = tags$text(tags$text('2',style = 'font-size: 100%; font-weight: bold; color: #81786c; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of negative effect on AD_ieu-b-5067 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_54',
                                                                  label = tags$text(tags$text('54',style = 'font-size: 100%; font-weight: bold; color: #8bc923; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of negative effect on AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_79',
                                                                  label = tags$text(tags$text('79',style = 'font-size: 100%; font-weight: bold; color: #82e652; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of negative effect on AD_ieu-b-2 and AD_ieu-a-297',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_161',
                                                                  label = tags$text(tags$text('161',style = 'font-size: 100%; font-weight: bold; color: #5ae460; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of negative effect on AD_ieu-b-2',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    checkboxInput(inputId = 'data3_19',
                                                                  label = tags$text(tags$text('19',style = 'font-size: 100%; font-weight: bold; color: #4c895e; text-decoration:none'),
                                                                                    tags$text(' common exposure traits with evidence of negative effect on AD_ieu-b-2 and AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    checkboxInput(inputId = 'data3_125',
                                                                  label = tags$text(tags$text('125',style = 'font-size: 100%; font-weight: bold; color: #7c31b6; text-decoration:none'),
                                                                                    tags$text(' exclusive exposure traits with evidence of negative effect on  AD_ieu-b-5067',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 250%; opacity: 0'))
                                                    
                                            ))),
                         
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/30.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                    
                                                    checkboxInput(inputId = 'data3_30',
                                                                  label = tags$text(tags$text('30',style = 'font-size: 100%; font-weight: bold; color: #393939; text-decoration:none'),
                                                                                    tags$text(' exposure traits with consistent effect across 13 FinnGen outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 350%; opacity: 0'))
                                                    
                                            ))),
                         
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/26.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                    
                                                    checkboxInput(inputId = 'data3_26',
                                                                  label = tags$text(tags$text('26',style = 'font-size: 100%; font-weight: bold; color: #393939; text-decoration:none'),
                                                                                    tags$text(' exposure traits with positive effect across 13 FinnGen outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 350%; opacity: 0'))
                                                    
                                            ))),
                         
                         tags$table(style = 'width: 100%; height: 100%',
                                    tags$tr(tags$td(style = 'width: 40%',
                                                    align = 'left',
                                                    tags$img(src = 'Picture/4_o.png',
                                                             style = 'width: 75%; display: block; margin-left: auto; margin-right: auto')),
                                            tags$td(style = 'width: 3%',
                                                    align = 'center',
                                                    tags$text('x',style = 'opacity: 0')),
                                            tags$td(style = 'width: 57%',
                                                    align = 'left',
                                                    
                                                    checkboxInput(inputId = 'data3_4e',
                                                                  label = tags$text(tags$text('4',style = 'font-size: 100%; font-weight: bold; color: #393939; text-decoration:none'),
                                                                                    tags$text(' exposure traits with negative effect across 13 FinnGen outcome datasets',
                                                                                              style = 'color: black; font-size: 100%')),
                                                                  value = F,
                                                                  width = '100%'),
                                                    
                                                    fluidRow(tags$text('x',style = 'font-size: 350%; opacity: 0'))
                                                    
                                            )))),
                
                
                
                tabPanel(title = tags$text('IVW interactive',style = 'color: white; font-size: 20px'),
                         
                         
                         h2(HTML("IVW results for Alzheimer's disease outcomes"),
                            align = 'center'),
                         
                         htmlOutput(outputId = 'IVW_title'),
                         br(),
                         
                         fluidRow(column(width = 3,
                                         
                                         selectInput(inputId = 'IVW_class1',
                                                     label = strong('Classification I:'),
                                                     choices = c('Please select Classification I' = '',unique(data1$`Classification I`)),
                                                     selected = 'Medical laboratory science',
                                                     multiple = T),
                                         
                                         uiOutput(outputId = 'UI_IVW_class2'),
                                         
                                         uiOutput(outputId = 'UI_IVW_class3'),
                                         
                                         textInput(inputId = 'IVW_id_exposure',
                                                   label = strong('id.exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input id.exposure'),
                                         
                                         textInput(inputId = 'IVW_exposure',
                                                   label = strong('exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input exposure')
                                         
                                         ),
                                  
                                  column(width = 3,
                                         
                                         selectInput(inputId = 'IVW_id_outcome',
                                                     label = strong('id.outcome:'),
                                                     choices = c('Please select id.outcome' = '',unique(data1$id.outcome)),
                                                     multiple = T),
                                         
                                         selectInput(inputId = 'IVW_method',
                                                     label = strong('method:'),
                                                     choices = c('Please select method' = '','Inverse variance weighted'),
                                                     multiple = T),
                                         
                                         numericInput(inputId = 'IVW_p_min',
                                                      label = strong('Min pval:'),
                                                      min = 0,
                                                      max = 1,
                                                      value = 0,
                                                      step = 0.0001),
                                         
                                         numericInput(inputId = 'IVW_p_max',
                                                      label = strong('Max pval:'),
                                                      min = 0,
                                                      max = 1,
                                                      value = 1,
                                                      step = 0.0001),
                                         
                                         selectInput(inputId = 'IVW_effect_direction',
                                                     label = strong('effect_direction:'),
                                                     choices = c('Please select effect_direction' = '',unique(data1$effect_direction)),
                                                     multiple = T)
                                         ),
                                  
                                  column(width = 3,
                                         
                                         selectInput(inputId = 'IVW_consortium',
                                                     label = strong('Consortium:'),
                                                     choices = c('Please select Consortium' = '',unique(data1$Consortium)),
                                                     multiple = T),
                                         
                                         selectInput(inputId = 'IVW_sex',
                                                     label = strong('Sex:'),
                                                     choices = c('Please select Sex' = '',unique(data1$Sex)),
                                                     multiple = T),
                                         
                                         textInput(inputId = 'IVW_uniprot_entry_id',
                                                   label = strong('Uniprot Entry ID:'),
                                                   value = '',
                                                   placeholder = 'Please input Uniprot Entry ID'),
                                         
                                         
                                         textInput(inputId = 'IVW_gene_names',
                                                   label = strong('Gene Names:'),
                                                   value = '',
                                                   placeholder = 'Please input Gene Names'),
                                         
                                         sliderInput(inputId = 'IVW_year',
                                                     label = strong('Year range:'),
                                                     min = min(data1$Year,na.rm = T),
                                                     max = max(data1$Year,na.rm = T),
                                                     value = c(min(data1$Year,na.rm = T),
                                                               max(data1$Year,na.rm = T)),
                                                     step = 1,
                                                     sep = '',
                                                     width = '100%')
                                         ),
                                  
                                  column(width = 3,
                                         
                                         strong('Exposures with no effect'),
                                         checkboxInput(inputId = 'IVW_no_effect',
                                                       label = "Don't show",
                                                       value = T),
                                         
                                         strong('Heterogeneity test:'),
                                         checkboxInput(inputId = 'IVW_heterogeneity_pval',
                                                       label = 'no heterogeneity',
                                                       value = F),
                                         
                                         
                                         strong('Egger Intercept test:'),
                                         checkboxInput(inputId = 'IVW_horizontal_pval',
                                                       label = 'no pleiotropy',
                                                       value = F),
                                         
                                         strong('80 traits with consistent effect'),
                                         br(),
                                         strong('across three main outcome datasets:'),
                                         checkboxInput(inputId = 'IVW_80_id_exposure',
                                                       label = 'show',
                                                       value = F),
                                         
                                         
                                         fluidRow(
                                           
                                           downloadButton(outputId = 'IVW_download_data',
                                                          label = 'Download Data',
                                                          icon = icon('download')),
                                           
                                           fluidRow(tags$text('x',style = 'font-size: 100%; opacity: 0')),
                                           
                                           downloadButton(outputId = 'IVW_download_html',
                                                          label = 'Download Interactive',
                                                          icon = icon('download')))
                                         )
                                  ),
                         
                         
                         withLoader(plotlyOutput(outputId = 'IVW',
                                                 height = 'auto',
                                                 width = "100%"))
                           
                           ),
                
                tabPanel(title = tags$text('IVW static',style = 'color: white; font-size: 20px'),
                         
                         
                         h2(HTML("IVW results for Alzheimer's disease outcomes"),
                            align = 'center'),
                         
                         htmlOutput(outputId = 'IVW_static_title'),
                         br(),
                         
                         fluidRow(column(width = 3,
                                         
                                         selectInput(inputId = 'IVW_static_class1',
                                                     label = strong('Classification I:'),
                                                     choices = c('Please select Classification I' = '',unique(data1$`Classification I`)),
                                                     selected = 'Medical laboratory science',
                                                     multiple = T),
                                         
                                         uiOutput(outputId = 'UI_IVW_static_class2'),
                                         
                                         uiOutput(outputId = 'UI_IVW_static_class3'),
                                         
                                         textInput(inputId = 'IVW_static_id_exposure',
                                                   label = strong('id.exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input id.exposure'),
                                         
                                         textInput(inputId = 'IVW_static_exposure',
                                                   label = strong('exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input exposure')
                                         
                         ),
                         
                         column(width = 3,
                                
                                selectInput(inputId = 'IVW_static_id_outcome',
                                            label = strong('id.outcome:'),
                                            choices = c('Please select id.outcome' = '',unique(data1$id.outcome)),
                                            multiple = T),
                                
                                selectInput(inputId = 'IVW_static_method',
                                            label = strong('method:'),
                                            choices = c('Please select method' = '','Inverse variance weighted'),
                                            multiple = T),
                                
                                numericInput(inputId = 'IVW_static_p_min',
                                             label = strong('Min pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 0,
                                             step = 0.0001),
                                
                                numericInput(inputId = 'IVW_static_p_max',
                                             label = strong('Max pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 1,
                                             step = 0.0001),
                                
                                selectInput(inputId = 'IVW_static_effect_direction',
                                            label = strong('effect_direction:'),
                                            choices = c('Please select effect_direction' = '',unique(data1$effect_direction)),
                                            multiple = T)
                         ),
                         
                         column(width = 3,
                                
                                selectInput(inputId = 'IVW_static_consortium',
                                            label = strong('Consortium:'),
                                            choices = c('Please select Consortium' = '',unique(data1$Consortium)),
                                            multiple = T),
                                
                                selectInput(inputId = 'IVW_static_sex',
                                            label = strong('Sex:'),
                                            choices = c('Please select Sex' = '',unique(data1$Sex)),
                                            multiple = T),
                                
                                textInput(inputId = 'IVW_static_uniprot_entry_id',
                                          label = strong('Uniprot Entry ID:'),
                                          value = '',
                                          placeholder = 'Please input Uniprot Entry ID'),
                                
                                
                                textInput(inputId = 'IVW_static_gene_names',
                                          label = strong('Gene Names:'),
                                          value = '',
                                          placeholder = 'Please input Gene Names'),
                                
                                sliderInput(inputId = 'IVW_static_year',
                                            label = strong('Year range:'),
                                            min = min(data1$Year,na.rm = T),
                                            max = max(data1$Year,na.rm = T),
                                            value = c(min(data1$Year,na.rm = T),
                                                      max(data1$Year,na.rm = T)),
                                            step = 1,
                                            sep = '',
                                            width = '100%')
                         ),
                         
                         column(width = 3,
                                
                                strong('Exposures with no effect'),
                                checkboxInput(inputId = 'IVW_static_no_effect',
                                              label = "Don't show",
                                              value = T),
                                
                                strong('Heterogeneity test:'),
                                checkboxInput(inputId = 'IVW_static_heterogeneity_pval',
                                              label = 'no heterogeneity',
                                              value = F),
                                
                                
                                strong('Egger Intercept test:'),
                                checkboxInput(inputId = 'IVW_static_horizontal_pval',
                                              label = 'no pleiotropy',
                                              value = F),
                                
                                strong('80 traits with consistent effect'),
                                br(),
                                strong('across three main outcome datasets:'),
                                checkboxInput(inputId = 'IVW_static_80_id_exposure',
                                              label = 'show',
                                              value = F),
                                
                                
                                fluidRow(
                                  
                                  downloadButton(outputId = 'IVW_static_download_data',
                                                 label = 'Download Data',
                                                 icon = icon('download')))
                         )
                         ),
                         
                         
                         withLoader(plotOutput(outputId = 'IVW_static',
                                               height = 'auto',
                                               width = "100%"))
                         
                         
                ),
                
                tabPanel(title = tags$text('Sensitivity analysis interactive',style = 'color: white; font-size: 20px'),
                         
                         htmlOutput(outputId = 'SA_title_main'),

                         htmlOutput(outputId = 'SA_title'),
                         br(),

                         fluidRow(column(width = 3,

                                         selectInput(inputId = 'SA_class1',
                                                     label = strong('Classification I:'),
                                                     choices = c('Please select Classification I' = '',unique(data1$`Classification I`)),
                                                     selected = 'Medical laboratory science',
                                                     multiple = T),

                                         uiOutput(outputId = 'UI_SA_class2'),

                                         uiOutput(outputId = 'UI_SA_class3'),

                                         textInput(inputId = 'SA_id_exposure',
                                                   label = strong('id.exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input id.exposure'),

                                         textInput(inputId = 'SA_exposure',
                                                   label = strong('exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input exposure')

                         ),

                         column(width = 3,

                                selectInput(inputId = 'SA_id_outcome',
                                            label = strong('id.outcome:'),
                                            choices = c('Please select id.outcome' = '',unique(data1$id.outcome)),
                                            selected = 'ieu-b-2'),

                                selectInput(inputId = 'SA_method',
                                            label = strong('method:'),
                                            choices = c('Please select method' = '',unique(data1$method)),
                                            multiple = T),

                                numericInput(inputId = 'SA_p_min',
                                             label = strong('Min pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 0,
                                             step = 0.0001),

                                numericInput(inputId = 'SA_p_max',
                                             label = strong('Max pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 1,
                                             step = 0.0001),

                                selectInput(inputId = 'SA_effect_direction',
                                            label = strong('effect_direction:'),
                                            choices = c('Please select effect_direction' = '',unique(data1$effect_direction)),
                                            multiple = T)
                         ),

                         column(width = 3,

                                selectInput(inputId = 'SA_consortium',
                                            label = strong('Consortium:'),
                                            choices = c('Please select Consortium' = '',unique(data1$Consortium)),
                                            multiple = T),

                                selectInput(inputId = 'SA_sex',
                                            label = strong('Sex:'),
                                            choices = c('Please select Sex' = '',unique(data1$Sex)),
                                            multiple = T),

                                textInput(inputId = 'SA_uniprot_entry_id',
                                          label = strong('Uniprot Entry ID:'),
                                          value = '',
                                          placeholder = 'Please input Uniprot Entry ID'),


                                textInput(inputId = 'SA_gene_names',
                                          label = strong('Gene Names:'),
                                          value = '',
                                          placeholder = 'Please input Gene Names'),

                                sliderInput(inputId = 'SA_year',
                                            label = strong('Year range:'),
                                            min = min(data1$Year,na.rm = T),
                                            max = max(data1$Year,na.rm = T),
                                            value = c(min(data1$Year,na.rm = T),
                                                      max(data1$Year,na.rm = T)),
                                            step = 1,
                                            sep = '',
                                            width = '100%')
                         ),

                         column(width = 3,

                                strong('Exposures with no effect'),
                                checkboxInput(inputId = 'SA_no_effect',
                                              label = "Don't show",
                                              value = T),

                                strong('Heterogeneity test:'),
                                checkboxInput(inputId = 'SA_heterogeneity_pval',
                                              label = 'no heterogeneity',
                                              value = F),


                                strong('Egger Intercept test:'),
                                checkboxInput(inputId = 'SA_horizontal_pval',
                                              label = 'no pleiotropy',
                                              value = F),
                                
                                selectInput(inputId = 'SA_passed',
                                            label = strong('Sensitivity analysis passed:'),
                                            choices = c('Please select sensitivity analysis passed' = '',
                                                        'Inverse variance weighted passed',
                                                        'MR Egger passed',
                                                        'Weighted median passed',
                                                        'Simple mode passed',
                                                        'Weighted mode passed',
                                                        'Maximum likelihood passed',
                                                        'Penalised weighted median passed'),
                                            multiple = T),

                                fluidRow(

                                  downloadButton(outputId = 'SA_download_data',
                                                 label = 'Download Data',
                                                 icon = icon('download')),
                                  
                                  fluidRow(tags$text('x',style = 'font-size: 100%; opacity: 0')),
                                  
                                  downloadButton(outputId = 'SA_download_html',
                                                 label = 'Download Interactive',
                                                 icon = icon('download')))
                         )
                         ),
                         
                         
                         withLoader(plotlyOutput(outputId = 'SA',
                                                 height = 'auto',
                                                 width = "100%"))


                ),


                tabPanel(title = tags$text('Sensitivity analysis static',style = 'color: white; font-size: 20px'),


                         h2(HTML("Sensitivity analysis results for Alzheimer's disease outcomes"),
                            align = 'center'),

                         htmlOutput(outputId = 'SA_static_title'),
                         br(),

                         fluidRow(column(width = 3,

                                         selectInput(inputId = 'SA_static_class1',
                                                     label = strong('Classification I:'),
                                                     choices = c('Please select Classification I' = '',unique(data1$`Classification I`)),
                                                     selected = 'Medical laboratory science',
                                                     multiple = T),

                                         uiOutput(outputId = 'UI_SA_static_class2'),

                                         uiOutput(outputId = 'UI_SA_static_class3'),

                                         textInput(inputId = 'SA_static_id_exposure',
                                                   label = strong('id.exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input id.exposure'),

                                         textInput(inputId = 'SA_static_exposure',
                                                   label = strong('exposure:'),
                                                   value = '',
                                                   placeholder = 'Please input exposure')

                         ),

                         column(width = 3,

                                selectInput(inputId = 'SA_static_id_outcome',
                                            label = strong('id.outcome:'),
                                            choices = c('Please select id.outcome' = '',unique(data1$id.outcome)),
                                            selected = 'ieu-b-2'),

                                selectInput(inputId = 'SA_static_method',
                                            label = strong('method:'),
                                            choices = c('Please select method' = '',unique(data1$method)),
                                            multiple = T),

                                numericInput(inputId = 'SA_static_p_min',
                                             label = strong('Min pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 0,
                                             step = 0.0001),

                                numericInput(inputId = 'SA_static_p_max',
                                             label = strong('Max pval:'),
                                             min = 0,
                                             max = 1,
                                             value = 1,
                                             step = 0.0001),

                                selectInput(inputId = 'SA_static_effect_direction',
                                            label = strong('effect_direction:'),
                                            choices = c('Please select effect_direction' = '',unique(data1$effect_direction)),
                                            multiple = T)
                         ),

                         column(width = 3,

                                selectInput(inputId = 'SA_static_consortium',
                                            label = strong('Consortium:'),
                                            choices = c('Please select Consortium' = '',unique(data1$Consortium)),
                                            multiple = T),

                                selectInput(inputId = 'SA_static_sex',
                                            label = strong('Sex:'),
                                            choices = c('Please select Sex' = '',unique(data1$Sex)),
                                            multiple = T),

                                textInput(inputId = 'SA_static_uniprot_entry_id',
                                          label = strong('Uniprot Entry ID:'),
                                          value = '',
                                          placeholder = 'Please input Uniprot Entry ID'),


                                textInput(inputId = 'SA_static_gene_names',
                                          label = strong('Gene Names:'),
                                          value = '',
                                          placeholder = 'Please input Gene Names'),

                                sliderInput(inputId = 'SA_static_year',
                                            label = strong('Year range:'),
                                            min = min(data1$Year,na.rm = T),
                                            max = max(data1$Year,na.rm = T),
                                            value = c(min(data1$Year,na.rm = T),
                                                      max(data1$Year,na.rm = T)),
                                            step = 1,
                                            sep = '',
                                            width = '100%')
                         ),

                         column(width = 3,

                                strong('Exposures with no effect'),
                                checkboxInput(inputId = 'SA_static_no_effect',
                                              label = "Don't show",
                                              value = T),

                                strong('Heterogeneity test:'),
                                checkboxInput(inputId = 'SA_static_heterogeneity_pval',
                                              label = 'no heterogeneity',
                                              value = F),


                                strong('Egger Intercept test:'),
                                checkboxInput(inputId = 'SA_static_horizontal_pval',
                                              label = 'no pleiotropy',
                                              value = F),
                                
                                selectInput(inputId = 'SA_static_passed',
                                            label = strong('Sensitivity analysis passed:'),
                                            choices = c('Please select sensitivity analysis passed' = '',
                                                        'Inverse variance weighted passed',
                                                        'MR Egger passed',
                                                        'Weighted median passed',
                                                        'Simple mode passed',
                                                        'Weighted mode passed',
                                                        'Maximum likelihood passed',
                                                        'Penalised weighted median passed'),
                                            multiple = T),


                                fluidRow(

                                  downloadButton(outputId = 'SA_static_download_data',
                                                 label = 'Download Data',
                                                 icon = icon('download'))
                                  )
                         )
                         ),


                         withLoader(plotOutput(outputId = 'SA_static',
                                               height = 'auto',
                                               width = "100%"))


                ),
                
                
                
                
                tabPanel(title = tags$text('About',style = 'color: white; font-size: 20px'),
                         
                         strong('Licence',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("MRAD grants you a non-exclusive, non-transferable revocable licence to access and use the app for private or non-commercial research purposes only. If you wish to access and use the app for commercial research purposes, please forward your enquiry to zhaoty22@ mails.jlu.edu.cn.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Ownership of MRAD',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("Subject to the Licence, nothing in these Terms grants you any right to, or in, any intellectual property rights of any nature (whether existing now or in the future and whether registered or unregistered) in the app.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Anti-racism',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("You agree to not use the data or methods in the app to make claims about racial superiority. You agree to strictly adhere to the American Society of Human Genetics (ASHG) position statement ASHG Denounces Attempts to Link Genetics and Racial Supremacy and the International Genetic Epidemiology Society Statement on Racism and Genetic Epidemiology.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Vulnerable groups',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text('You agree to adhere to the principles articulated in the final two sections articulated by the ASHG position on Advancing Diverse Participation in Research with Special Consideration for Vulnerable Populations, namely, "In the Conduct of Research with Vulnerable Populations, Researchers Must Address Concerns that Participation May Lead to Group Harm" and "The Benefits of Research Participation Are Profound, Yet the Potential Danger that Unethical Application of Genetics Might Stigmatize, Discriminate against, or Persecute Vulnerable Populations Persists."',
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Disclaimers',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("We do not guarantee that (a) the app or any MRAD Data will always be available or interrupted; (b) the app or any MRAD Data will be accurate, complete, free from errors or omissions or secure or free from bugs or viruses; or (c) that the result of using the app or any MRAD Data will be accurate, adequate or fit for any particular purpose. Where the app contains links to other sites or resources provided by third parties, these links are provided for your information only and you acknowledge that we have no control over the content of those sites or resources. All warranties, representations, conditions and all other terms of any kind whatsoever implied by statute or common law, to the fullest extent permitted by applicable, law, excluding from these Terms. Any medical or genetic information is provided for research, educational and informational purposes only. It is not in any way intended to be used as a substitute for professional medical advice, diagnosis, treatment or care.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Limitation of liability',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("You assume sole responsibility for the results obtained from the use of the app and any MRAD Data and for conclusions drawn from such use. MRAD shall have no liability for any damage or other loss whatsoever arising out of or in connection with your use of the app or any MRAD Data. MRAD shall not be liable in any circumstances whether in contract, tort (including for negligence), misrepresentation (whether innocent or negligent), restitution or otherwise for any special, indirect or consequential loss, costs, damages, charges or expenses however arising under these Terms including but not limited to loss of funding or loss of opportunity, goodwill or reputation. Nothing in these Terms excludes or limits any liability which cannot be excluded or limited by applicable law.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Suspension and termination',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("MRAD may, at its sole discretion, suspend, withdraw, discontinue or change all or any part of the app (in respect of any single user, group of users or all users of the app) without notice and whether or not arising from any breach of these Terms. MRAD will not be liable to you in such circumstances.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Changes to these Terms',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("MRAD may revise these Terms at any time by amending this page. Please check this page from time to time to take notice of any changes, as they will be legally binding on you.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Dependencies',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("The MRAD app project is built upon many important open source software projects.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("The MR analysis for all pairs of exposures and outcomes were extracted from MRC IEU",
                                   style = 'font-size: 100%; color: black'),
                         tags$a("OpenGWAS",
                                href = 'https://gwas.mrcieu.ac.uk/',
                                style = 'font-size: 100%'),
                         tags$text(".",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         
                         tags$text("The MR analysis was performed based on ",
                                   style = 'font-size: 100%; color: black'),
                         tags$a("R",
                                href = 'https://cran.r-project.org/',
                                style = 'font-size: 100%'),
                         tags$text(" packages.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         
                         tags$text("The information and links to proteins were from ",
                                   style = 'font-size: 100%; color: black'),
                         tags$a("UniProt",
                                href = 'https://www.uniprot.org/',
                                style = 'font-size: 100%'),
                         tags$text(".",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('Credits',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("You agree to cite any use of the MRAD in the form set out in the “About” page. You further agree to observe and comply with any notice requiring you to cite the original source of any MRAD Data in your analyses in the form set out in such notice.",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         br(),
                         
                         strong('How to cite MRAD',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("",
                                   style = 'font-size: 100%; color: black'),
                         
                         br(),
                         br(),
                         
                         strong('Contact us',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("All comments and suggestions are welcome, especially those suggesting new cases of MRAD and possible improvements on the app. We can be reached at",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("Tianyu Zhao;",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("Address: Department of Pharmacology, College of Basic Medical Sciences, Jilin University; 126 Xinmin Street, Changchun City, Jilin Province, People’s Republic of China;",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("Postcode: 130021",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("E-mail: zhaoty22@ mails.jlu.edu.cn",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("Tel:+8613756283023",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("WeChat: 1172721320",
                                   style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("If you find any error in data or bug in web service, please kindly report it to us.",
                                   style = 'font-size: 100%; color: black'),
                         
                         tags$img(src = 'Picture/WeChat.png',
                                  style = 'width: 10%; height: 10%; display: block;'),
                         
                         strong('Effective Date',
                                style = 'font-size: 100%; color: black'),
                         br(),
                         tags$text("This policy is effective as of 3/10/2023.",
                                   style = 'font-size: 100%; color: black')
                         
                         
                         
                         
                         ),
                
                
                tabPanel(title = tags$text('Data1',style = 'opacity: 0; font-size: 1px'),
                         value = 'data1',
                         h2(HTML("MRAD(Mendelian randomization for Alzheimer's disease)"),
                            align = 'center'),
                         br(),
                         
                         sidebarLayout(
                           sidebarPanel(width = 3,
                                        
                                        shinyjs::useShinyjs(),
                                        id = 'data1_side_panel',
                                        
                                        selectInput(inputId = 'data1_class1',
                                                    label = strong('Classification I:'),
                                                    choices = c('Please select Classification I' = '',unique(data1$`Classification I`)),
                                                    multiple = T),
                                        
                                        uiOutput(outputId = 'UI_data1_class2'),
                                        
                                        uiOutput(outputId = 'UI_data1_class3'),
                                        
                                        textInput(inputId = 'data1_id_exposure',
                                                  label = strong('id.exposure:'),
                                                  value = '',
                                                  placeholder = 'Please input id.exposure'),
                                        
                                        textInput(inputId = 'data1_exposure',
                                                  label = strong('exposure:'),
                                                  value = '',
                                                  placeholder = 'Please input exposure'),
                                        
                                        selectInput(inputId = 'data1_id_outcome',
                                                    label = strong('id.outcome:'),
                                                    choices = c('Please select id.outcome' = '',unique(data1$id.outcome)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data1_method',
                                                    label = strong('method:'),
                                                    choices = c('Please select method' = '',unique(data1$method)),
                                                    multiple = T),
                                        
                                        numericInput(inputId = 'data1_p_min',
                                                     label = strong('Min pval:'),
                                                     min = 0,
                                                     max = 1,
                                                     value = 0,
                                                     step = 0.0001),
                                        
                                        numericInput(inputId = 'data1_p_max',
                                                     label = strong('Max pval:'),
                                                     min = 0,
                                                     max = 1,
                                                     value = 1,
                                                     step = 0.0001),
                                        
                                        selectInput(inputId = 'data1_effect_direction',
                                                    label = strong('effect_direction:'),
                                                    choices = c('Please select effect_direction' = '',unique(data1$effect_direction)),
                                                    multiple = T),
                                        
                                        strong('Heterogeneity test:'),
                                        checkboxInput(inputId = 'data1_heterogeneity_pval',
                                                      label = 'no heterogeneity',
                                                      value = F),
                                        
                                        
                                        strong('Egger Intercept test:'),
                                        checkboxInput(inputId = 'data1_horizontal_pval',
                                                      label = 'no pleiotropy',
                                                      value = F),
                                        
                                        
                                        selectInput(inputId = 'data1_consortium',
                                                    label = strong('Consortium:'),
                                                    choices = c('Please select Consortium' = '',unique(data1$Consortium)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data1_sex',
                                                    label = strong('Sex:'),
                                                    choices = c('Please select Sex' = '',unique(data1$Sex)),
                                                    multiple = T),
                                        
                                        
                                        sliderInput(inputId = 'data1_year',
                                                    label = strong('Year range:'),
                                                    min = min(data1$Year,na.rm = T),
                                                    max = max(data1$Year,na.rm = T),
                                                    value = c(min(data1$Year,na.rm = T),
                                                              max(data1$Year,na.rm = T)),
                                                    step = 1,
                                                    sep = '',
                                                    width = '100%'),
                                        
                                        textInput(inputId = 'data1_uniprot_entry_id',
                                                  label = strong('Uniprot Entry ID:'),
                                                  value = '',
                                                  placeholder = 'Please input Uniprot Entry ID'),
                                        
                                        
                                        textInput(inputId = 'data1_gene_names',
                                                  label = strong('Gene Names:'),
                                                  value = '',
                                                  placeholder = 'Please input Gene Names'),
                                        
                                        fluidRow(
                                          downloadButton(outputId = 'data1_download',
                                                         label = 'Download',
                                                         icon = icon('download'),
                                                         class = 'btn-info'),
                                          
                                          actionButton(inputId = 'data1_reset',
                                                       label = 'Reset',
                                                       icon = icon(name = 'rotate-left',lib = 'font-awesome')),
                                          
                                          actionButton(inputId = 'data1_back',
                                                       label = 'Back',
                                                       icon = icon(name = 'house',lib = 'font-awesome'))
                                          
                                        )
                                        
                           ),
                           
                           mainPanel(width = 9,
                                     
                                     DTOutput(outputId = 'data1'))
                           
                         )),
                
                
                tabPanel(title = tags$text('Data2',style = 'opacity: 0; font-size: 1px'),
                         value = 'data2',
                         
                         htmlOutput(outputId = 'data2_title'),
                         br(),
                         
                         sidebarLayout(
                           sidebarPanel(width = 3,
                                        
                                        shinyjs::useShinyjs(),
                                        id = 'data2_side_panel',
                                        
                                        textInput(inputId = 'data2_gwas_id',
                                                  label = strong('GWAS ID:'),
                                                  value = '',
                                                  placeholder = 'Please input GWAS ID'),
                                        
                                        textInput(inputId = 'data2_trait',
                                                  label = strong('Trait:'),
                                                  value = '',
                                                  placeholder = 'Please input Trait'),
                                        
                                        textInput(inputId = 'data2_consortium',
                                                  label = strong('Consortium:'),
                                                  value = '',
                                                  placeholder = 'Please input Consortium'),
                                        
                                        selectInput(inputId = 'data2_population',
                                                    label = strong('Population:'),
                                                    choices = c('Please select Population' = '',unique(data2$Population)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data2_sex',
                                                    label = strong('Sex:'),
                                                    choices = c('Please select Sex' = '',unique(data2$Sex)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data2_category',
                                                    label = strong('Category:'),
                                                    choices = c('Please select Category' = '',unique(data2$Category)),
                                                    multiple = T),
                                        
                                        sliderInput(inputId = 'data2_year',
                                                    label = strong('Year range:'),
                                                    min = min(data2$Year,na.rm = T),
                                                    max = max(data2$Year,na.rm = T),
                                                    value = c(min(data2$Year,na.rm = T),
                                                              max(data2$Year,na.rm = T)),
                                                    step = 1,
                                                    sep = '',
                                                    width = '100%'),
                                        
                                        fluidRow(
                                          downloadButton(outputId = 'data2_download',
                                                         label = 'Download',
                                                         icon = icon('download'),
                                                         class = 'btn-info'),
                                          
                                          actionButton(inputId = 'data2_reset',
                                                       label = 'Reset',
                                                       icon = icon(name = 'rotate-left',lib = 'font-awesome'))
                                          
                                        )
                                        
                           ),
                           
                           mainPanel(width = 9,
                                     DTOutput(outputId = 'data2'))
                           
                         )),
                
                
                tabPanel(title = tags$text('Data3',style = 'opacity: 0; font-size: 1px'),
                         value = 'data3',
                         
                         htmlOutput(outputId = 'data3_title'),
                         br(),
                         
                         sidebarLayout(
                           sidebarPanel(width = 3,
                                        
                                        shinyjs::useShinyjs(),
                                        id = 'data3_side_panel',
                                        
                                        selectInput(inputId = 'data3_class1',
                                                    label = strong('Classification I:'),
                                                    choices = c('Please select Classification I' = '',unique(data3$`Classification I`)),
                                                    multiple = T),
                                        
                                        uiOutput(outputId = 'UI_data3_class2'),
                                        
                                        uiOutput(outputId = 'UI_data3_class3'),
                                        
                                        textInput(inputId = 'data3_id_exposure',
                                                  label = strong('id.exposure:'),
                                                  value = '',
                                                  placeholder = 'Please input id.exposure'),
                                        
                                        textInput(inputId = 'data3_exposure',
                                                  label = strong('exposure:'),
                                                  value = '',
                                                  placeholder = 'Please input exposure'),
                                        
                                        selectInput(inputId = 'data3_id_outcome',
                                                    label = strong('id.outcome:'),
                                                    choices = c('Please select id.outcome' = '',unique(data3$id.outcome)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data3_method',
                                                    label = strong('method:'),
                                                    choices = c('Please select method' = '',unique(data3$method)),
                                                    multiple = T),
                                        
                                        numericInput(inputId = 'data3_p_min',
                                                     label = strong('Min pval:'),
                                                     min = 0,
                                                     max = 1,
                                                     value = 0,
                                                     step = 0.0001),
                                        
                                        numericInput(inputId = 'data3_p_max',
                                                     label = strong('Max pval:'),
                                                     min = 0,
                                                     max = 1,
                                                     value = 1,
                                                     step = 0.0001),
                                        
                                        selectInput(inputId = 'data3_effect_direction',
                                                    label = strong('effect_direction:'),
                                                    choices = c('Please select effect_direction' = '',unique(data3$effect_direction)),
                                                    multiple = T),
                                        
                                        strong('Heterogeneity test:'),
                                        checkboxInput(inputId = 'data3_heterogeneity_pval',
                                                      label = 'no heterogeneity',
                                                      value = F),
                                        
                                        
                                        strong('Egger Intercept test:'),
                                        checkboxInput(inputId = 'data3_horizontal_pval',
                                                      label = 'no pleiotropy',
                                                      value = F),
                                        
                                        
                                        selectInput(inputId = 'data3_consortium',
                                                    label = strong('Consortium:'),
                                                    choices = c('Please select Consortium' = '',unique(data3$Consortium)),
                                                    multiple = T),
                                        
                                        selectInput(inputId = 'data3_sex',
                                                    label = strong('Sex:'),
                                                    choices = c('Please select Sex' = '',unique(data3$Sex)),
                                                    multiple = T),
                                        
                                        
                                        sliderInput(inputId = 'data3_year',
                                                    label = strong('Year range:'),
                                                    min = min(data3$Year,na.rm = T),
                                                    max = max(data3$Year,na.rm = T),
                                                    value = c(min(data3$Year,na.rm = T),
                                                              max(data3$Year,na.rm = T)),
                                                    step = 1,
                                                    sep = '',
                                                    width = '100%'),
                                        
                                        
                                        fluidRow(
                                          downloadButton(outputId = 'data3_download',
                                                         label = 'Download',
                                                         icon = icon('download'),
                                                         class = 'btn-info'),
                                          
                                          actionButton(inputId = 'data3_reset',
                                                       label = 'Reset',
                                                       icon = icon(name = 'rotate-left',lib = 'font-awesome'))
                                          
                                        )
                                        
                           ),
                           
                           mainPanel(width = 9,
                                     
                                     DTOutput(outputId = 'data3'))
                           
                         )
                         
                         
                         
                )
                
)

server = function(input,output,session){
  
  observeEvent(eventExpr = input$disease,
               handlerExpr = {
                 if(input$disease==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$medical_laboratory_science,
               handlerExpr = {
                 if(input$medical_laboratory_science==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  
  observeEvent(eventExpr = input$anthropometric,
               handlerExpr = {
                 if(input$anthropometric==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$lifestyle_trait,
               handlerExpr = {
                 if(input$lifestyle_trait==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$imaging,
               handlerExpr = {
                 if(input$imaging==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$molecular_trait,
               handlerExpr = {
                 if(input$molecular_trait==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$family_history,
               handlerExpr = {
                 if(input$family_history==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$treatment,
               handlerExpr = {
                 if(input$treatment==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$gut_microbiota,
               handlerExpr = {
                 if(input$gut_microbiota==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  observeEvent(eventExpr = input$past_history,
               handlerExpr = {
                 if(input$past_history==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data1')}
               })
  
  
  observeEvent(eventExpr = input$search_content_search,
               handlerExpr = {updateNavbarPage(session = session,
                                               inputId = 'alltabs',
                                               selected = 'data1')})
  
  observeEvent(eventExpr = input$data1_back,
               handlerExpr = {updateNavbarPage(session = session,
                                               inputId = 'alltabs',
                                               selected = 'home')})
  
  observeEvent(eventExpr = input$data1_reset,
               handlerExpr = {shinyjs::reset('data1_side_panel')})
  
  observeEvent(eventExpr = input$data2_reset,
               handlerExpr = {shinyjs::reset('data2_side_panel')})
  
  observeEvent(eventExpr = input$data3_reset,
               handlerExpr = {shinyjs::reset('data3_side_panel')})
  
  
  observeEvent(eventExpr = input$home_to_study_design,
               handlerExpr = {updateNavbarPage(session = session,
                                               inputId = 'alltabs',
                                               selected = 'study_design')})
  
  observeEvent(eventExpr = input$data2_42335,
               handlerExpr = {
                 
                 if(input$data2_42335==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data2')}
               })
  
  observeEvent(eventExpr = input$data2_18097,
               handlerExpr = {
                 
                 if(input$data2_18097==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data2')}
               })
  
  observeEvent(eventExpr = input$data2_16,
               handlerExpr = {
                 if(input$data2_16==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data2')}
               })

  observeEvent(eventExpr = input$data3_80,
               handlerExpr = {
                 if(input$data3_80==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_6,
               handlerExpr = {
                 if(input$data3_6==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_102,
               handlerExpr = {
                 if(input$data3_102==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_119,
               handlerExpr = {
                 if(input$data3_119==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_223,
               handlerExpr = {
                 if(input$data3_223==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_57,
               handlerExpr = {
                 if(input$data3_57==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_270,
               handlerExpr = {
                 if(input$data3_270==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_63,
               handlerExpr = {
                 if(input$data3_63==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_4c,
               handlerExpr = {
                 if(input$data3_4c==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_48,
               handlerExpr = {
                 if(input$data3_48==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_41,
               handlerExpr = {
                 if(input$data3_41==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_65,
               handlerExpr = {
                 if(input$data3_65==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_35,
               handlerExpr = {
                 if(input$data3_35==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_149,
               handlerExpr = {
                 if(input$data3_149==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })

  observeEvent(eventExpr = input$data3_16,
               handlerExpr = {
                 if(input$data3_16==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_2,
               handlerExpr = {
                 if(input$data3_2==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_54,
               handlerExpr = {
                 if(input$data3_54==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_79,
               handlerExpr = {
                 if(input$data3_79==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_161,
               handlerExpr = {
                 if(input$data3_161==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_19,
               handlerExpr = {
                 if(input$data3_19==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_125,
               handlerExpr = {
                 if(input$data3_125==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_30,
               handlerExpr = {
                 if(input$data3_30==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })

  observeEvent(eventExpr = input$data3_26,
               handlerExpr = {
                 if(input$data3_26==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })

  observeEvent(eventExpr = input$data3_4e,
               handlerExpr = {
                 if(input$data3_4e==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  observeEvent(eventExpr = input$data3_4e,
               handlerExpr = {
                 if(input$data3_4e==T){
                   updateNavbarPage(session = session,
                                    inputId = 'alltabs',
                                    selected = 'data3')}
               })
  
  
  temp_data1_class2 = reactive({
    
    if(length(input$data1_class1)==0){
      unique(data1$`Classification II`)
    } else{
      data1 %>% 
        filter(`Classification I` %in% input$data1_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_data1_class2 = renderUI({
    selectInput(inputId = 'data1_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_data1_class2()),
                multiple = T)
  })
  
  temp_data1_class3 = reactive({
    
    if(length(input$data1_class1)==0 & length(input$data1_class2)==0){
      unique(data1$`Classification III`)
    } else if(length(input$data1_class1)==0 & length(input$data1_class2)!=0){
      data1 %>% 
        filter(`Classification II` %in% input$data1_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$data1_class1)!=0 & length(input$data1_class2)==0){
      data1 %>% 
        filter(`Classification I` %in% input$data1_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data1 %>% 
        filter(`Classification I` %in% input$data1_class1,
               `Classification II` %in% input$data1_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
    
  })
  
  output$UI_data1_class3 = renderUI({
    selectInput(inputId = 'data1_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_data1_class3()),
                multiple = T)
  })
  
  # Data1
  final_data1 = reactive({
    
    final_data1 = data1
    
    if(input$search_content!=''){
      final_data1 = final_data1 %>%
        filter(str_detect(str_to_lower(final_data1$id.exposure),
                          str_to_lower(input$search_content))|
                 str_detect(str_to_lower(final_data1$exposure),
                            str_to_lower(input$search_content)))
    }
    
    if(input$disease){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Disease',
               method=='Inverse variance weighted')
    }
    
    if(input$medical_laboratory_science){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Medical laboratory science',
               method=='Inverse variance weighted')
    }
    
    if(input$imaging){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Imaging',
               method=='Inverse variance weighted')
    }
    
    if(input$anthropometric){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Anthropometric',
               method=='Inverse variance weighted')
    }
    
    if(input$treatment){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Treatment',
               method=='Inverse variance weighted')
    }
    
    if(input$molecular_trait){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Molecular trait',
               method=='Inverse variance weighted')
    }
    
    if(input$gut_microbiota){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Gut microbiota',
               method=='Inverse variance weighted')
    }
    
    if(input$past_history){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Past history',
               method=='Inverse variance weighted')
    }
    
    if(input$family_history){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Family history',
               method=='Inverse variance weighted')
    }
    
    if(input$lifestyle_trait){
      final_data1 = final_data1 %>% 
        filter(`Classification I`=='Lifestyle trait',
               method=='Inverse variance weighted')
    }
    
    
    select_class_1 = if(length(input$data1_class1)==0){
      unique(data1$`Classification I`)
    } else{
      input$data1_class1
    }
    
    select_class_2 = if(length(input$data1_class1)==0 & length(input$data1_class2)==0){
      unique(data1$`Classification II`)
    } else if(length(input$data1_class1)==0 & length(input$data1_class2)!=0){
      input$data1_class2
    } else if(length(input$data1_class1)!=0 & length(input$data1_class2)==0){
      unique(data1$`Classification II`)
    } else{
      input$data1_class2
    }
    
    select_class_3 = if(length(input$data1_class1)==0 & length(input$data1_class2)==0 & length(input$data1_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$data1_class1)==0 & length(input$data1_class2)==0 & length(input$data1_class3)!=0){
      input$data1_class3
    } else if(length(input$data1_class1)==0 & length(input$data1_class2)!=0 & length(input$data1_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$data1_class1)!=0 & length(input$data1_class2)==0 & length(input$data1_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$data1_class1)==0 & length(input$data1_class2)!=0 & length(input$data1_class3)!=0){
      input$data1_class3
    } else if(length(input$data1_class1)!=0 & length(input$data1_class2)==0 & length(input$data1_class3)!=0){
      input$data1_class3
    } else if(length(input$data1_class1)!=0 & length(input$data1_class2)!=0 & length(input$data1_class3)==0){
      unique(data1$`Classification III`)
    } else{
      input$data1_class3
    }
    
    final_data1 = final_data1 %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$data1_id_exposure!=''){
      final_data1 = final_data1 %>%
        filter(str_detect(str_to_lower(final_data1$id.exposure),str_to_lower(input$data1_id_exposure)))
    }
    
    if(input$data1_exposure!=''){
      final_data1 = final_data1 %>%
        filter(str_detect(str_to_lower(final_data1$exposure),str_to_lower(input$data1_exposure)))
    }
    
    if(!is.null(input$data1_id_outcome)) {
      final_data1 = final_data1 %>%
        filter(id.outcome %in% input$data1_id_outcome)
    }
    
    if(!is.null(input$data1_method)) {
      final_data1 = final_data1 %>%
        filter(method %in% input$data1_method)
    }
    
    if(!(input$data1_p_min==0 & input$data1_p_max==1)){
      
      final_data1 = final_data1 %>% 
        filter(pval>=input$data1_p_min)
      
      final_data1 = final_data1 %>% 
        filter(pval<=input$data1_p_max)
      
    }
    
    
    if(!is.null(input$data1_effect_direction)) {
      final_data1 = final_data1 %>%
        filter(effect_direction %in% input$data1_effect_direction)
    }
    
    if(input$data1_heterogeneity_pval){
      final_data1 = final_data1 %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$data1_horizontal_pval){
      final_data1 = final_data1 %>% 
        filter(Horizontal_pval>0.05)
    }
    
    if(!is.null(input$data1_consortium)) {
      final_data1 = final_data1 %>%
        filter(Consortium %in% input$data1_consortium)
    }
    
    
    if(!is.null(input$data1_sex)) {
      final_data1 = final_data1 %>%
        filter(Sex %in% input$data1_sex)
    }
    
    
    final_data1 = final_data1 %>% 
      filter(Year>=input$data1_year[1],
             Year<=input$data1_year[2])
    
    
    if(input$data1_uniprot_entry_id!=''){
      final_data1 = final_data1 %>%
        filter(str_detect(str_to_lower(final_data1$`Uniprot Entry ID`),
                          str_to_lower(input$data1_uniprot_entry_id)))
    }
    
    if(input$data1_gene_names!=''){
      final_data1 = final_data1 %>%
        filter(str_detect(str_to_lower(final_data1$`Gene Names`),
                          str_to_lower(input$data1_gene_names)))
    }
    
    final_data1 = final_data1 %>% 
      mutate(`Uniprot Entry ID Link` = str_c('<a href="https://www.uniprot.org/uniprot/',
                                             `Uniprot Entry ID`,
                                             '" target="_blank">',
                                             `Uniprot Entry ID`,
                                             '</a>'))
    
    index_uniprot_entry_id = which(colnames(final_data1)=='Uniprot Entry ID')
    
    final_data1 %>% 
      select(1:index_uniprot_entry_id,
             `Uniprot Entry ID Link`,
             (index_uniprot_entry_id+1):ncol(final_data1))
    
  })
  
  output$data1 = renderDT({
    
    final_data1() %>%
      datatable(selection = 'single',
                escape = F,
                options = list(lengthMenu = c('5','10','15','20','30','40','60','80','100'),
                               lengthChange = T,
                               pageLength = 40,
                               autoWidth = F,
                               scrollX = T),
                rownames = F,
                class = 'display nowrap',
                editable = F) %>%
      formatStyle(columns = 1,backgroundColor = '#f3f3f3', fontWeight = 'bold')
    
    
  })
  
  output$data1_download = downloadHandler(
    filename = "MRAD(Mendelian randomization for Alzheimer's disease).csv",
    content = function(file) {
      write.csv(final_data1(),file,row.names = F)
    }
  )
  
  output$data2_title = renderUI({
    
    if(input$data2_42335!=0){
      data2_title = "Basic information of 42,335 GWAS summary datasets on <a href='https://gwas.mrcieu.ac.uk/'>OpenGWAS</a>"
    }
    
    if(input$data2_18097!=0){
      data2_title = "Basic information of 18,097 exposure GWAS traits"
    }
    
    if(input$data2_16!=0){
      data2_title = "Basic information of 16 Alzheimer's disease outcome GWAS traits"
    }
    h2(HTML(data2_title),align = 'center')
  })
  
  # Data2
  final_data2 = reactive({
    
    final_data2 = data2
    
    if(input$data2_42335){
      final_data2 = final_data2 %>% 
        filter(file_name=='42335')
    }
    
    if(input$data2_18097){
      final_data2 = final_data2 %>% 
        filter(file_name=='18097')
    }
    
    if(input$data2_16){
      final_data2 = final_data2 %>% 
        filter(file_name=='16')
    }
    
    if(input$data2_gwas_id!=''){
      final_data2 = final_data2 %>%
        filter(str_detect(str_to_lower(final_data2$`GWAS ID`),
                          str_to_lower(input$data2_gwas_id)))
    }
    
    if(input$data2_trait!=''){
      final_data2 = final_data2 %>%
        filter(str_detect(str_to_lower(final_data2$Trait),
                          str_to_lower(input$data2_trait)))
    }
    
    if(input$data2_consortium!=''){
      final_data2 = final_data2 %>%
        filter(str_detect(str_to_lower(final_data2$Consortium),
                          str_to_lower(input$data2_consortium)))
    }
    
    if(!is.null(input$data2_population)) {
      final_data2 = final_data2 %>%
        filter(Population %in% input$data2_population)
    }
    
    if(!is.null(input$data2_sex)) {
      final_data2 = final_data2 %>%
        filter(Sex %in% input$data2_sex)
    }
    
    if(!is.null(input$data2_category)) {
      final_data2 = final_data2 %>%
        filter(Category %in% input$data2_category)
    }
    
    if(!(input$data2_year[1]==min(data2$Year,na.rm = T) & input$data2_year[2]==max(data2$Year,na.rm = T))){
      
      final_data2 = final_data2 %>% 
        filter(Year>=input$data2_year[1])
      
      final_data2 = final_data2 %>% 
        filter(Year<=input$data2_year[2])
      
    }
    
    final_data2 = final_data2 %>% select(-file_name)
    final_data2
    
  })
  
  output$data2 = renderDT({
    
    final_data2() %>%
      datatable(selection = 'single',
                escape = F,
                options = list(lengthMenu = c('5','10','15','20','30','40','60','80','100'),
                               lengthChange = T,
                               pageLength = 15,
                               autoWidth = F,
                               scrollX = T),
                rownames = F,
                class = 'display nowrap',
                editable = F) %>%
      formatStyle(columns = 1,backgroundColor = '#f3f3f3', fontWeight = 'bold')
    
  })
  
  output$data2_download = downloadHandler(
    filename = "Basic information.csv",
    content = function(file) {
      write.csv(final_data2(),file,row.names = F)
    }
  )
  
  
  # Data3
  temp_data3_class2 = reactive({
    
    if(length(input$data3_class1)==0){
      unique(data3$`Classification II`)
    } else{
      data3 %>% 
        filter(`Classification I` %in% input$data3_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_data3_class2 = renderUI({
    selectInput(inputId = 'data3_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_data3_class2()),
                multiple = T)
  })
  
  temp_data3_class3 = reactive({
    
    if(length(input$data3_class1)==0 & length(input$data3_class2)==0){
      unique(data3$`Classification III`)
    } else if(length(input$data3_class1)==0 & length(input$data3_class2)!=0){
      data3 %>% 
        filter(`Classification II` %in% input$data3_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$data3_class1)!=0 & length(input$data3_class2)==0){
      data3 %>% 
        filter(`Classification I` %in% input$data3_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data3 %>% 
        filter(`Classification I` %in% input$data3_class1,
               `Classification II` %in% input$data3_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
  })
  
  output$UI_data3_class3 = renderUI({
    selectInput(inputId = 'data3_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_data3_class3()),
                multiple = T)
  })
  
  final_data3 = reactive({
    
    final_data3 = data3
    
    if(input$data3_80){
      final_data3 = final_data3 %>% 
        filter(file_name=='80')
    }
    
    if(input$data3_6){
      final_data3 = final_data3 %>% 
        filter(file_name=='6')
    }
    
    if(input$data3_102){
      final_data3 = final_data3 %>% 
        filter(file_name=='102')
    }
    
    if(input$data3_119){
      final_data3 = final_data3 %>% 
        filter(file_name=='119')
    }
    
    if(input$data3_223){
      final_data3 = final_data3 %>% 
        filter(file_name=='223')
    }
    
    if(input$data3_57){
      final_data3 = final_data3 %>% 
        filter(file_name=='57')
    }
    
    if(input$data3_270){
      final_data3 = final_data3 %>% 
        filter(file_name=='270')
    }
    
    if(input$data3_63){
      final_data3 = final_data3 %>% 
        filter(file_name=='63')
    }
    
    if(input$data3_4c){
      final_data3 = final_data3 %>% 
        filter(file_name=='4c')
    }
    
    if(input$data3_48){
      final_data3 = final_data3 %>% 
        filter(file_name=='48')
    }
    
    if(input$data3_41){
      final_data3 = final_data3 %>% 
        filter(file_name=='41')
    }
    
    if(input$data3_65){
      final_data3 = final_data3 %>% 
        filter(file_name=='65')
    }
    
    if(input$data3_35){
      final_data3 = final_data3 %>% 
        filter(file_name=='35')
    }
    
    if(input$data3_149){
      final_data3 = final_data3 %>% 
        filter(file_name=='149')
    }

    if(input$data3_16){
      final_data3 = final_data3 %>% 
        filter(file_name=='16')
    }
    
    if(input$data3_2){
      final_data3 = final_data3 %>% 
        filter(file_name=='2')
    }
    
    if(input$data3_54){
      final_data3 = final_data3 %>% 
        filter(file_name=='54')
    }
    
    if(input$data3_79){
      final_data3 = final_data3 %>% 
        filter(file_name=='79')
    }
    
    if(input$data3_161){
      final_data3 = final_data3 %>% 
        filter(file_name=='161')
    }
    
    if(input$data3_19){
      final_data3 = final_data3 %>% 
        filter(file_name=='19')
    }
    
    if(input$data3_125){
      final_data3 = final_data3 %>% 
        filter(file_name=='125')
    }

    if(input$data3_30){
      final_data3 = final_data3 %>% 
        filter(file_name=='30')
    }

    if(input$data3_26){
      final_data3 = final_data3 %>% 
        filter(file_name=='26')
    }

    if(input$data3_4e){
      final_data3 = final_data3 %>% 
        filter(file_name=='4e')
    }
    
    select_class_1 = if(length(input$data3_class1)==0){
      unique(data3$`Classification I`)
    } else{
      input$data3_class1
    }
    
    select_class_2 = if(length(input$data3_class1)==0 & length(input$data3_class2)==0){
      unique(data3$`Classification II`)
    } else if(length(input$data3_class1)==0 & length(input$data3_class2)!=0){
      input$data3_class2
    } else if(length(input$data3_class1)!=0 & length(input$data3_class2)==0){
      unique(data3$`Classification II`)
    } else{
      input$data3_class2
    }
    
    select_class_3 = if(length(input$data3_class1)==0 & length(input$data3_class2)==0 & length(input$data3_class3)==0){
      unique(data3$`Classification III`)
    } else if(length(input$data3_class1)==0 & length(input$data3_class2)==0 & length(input$data3_class3)!=0){
      input$data3_class3
    } else if(length(input$data3_class1)==0 & length(input$data3_class2)!=0 & length(input$data3_class3)==0){
      unique(data3$`Classification III`)
    } else if(length(input$data3_class1)!=0 & length(input$data3_class2)==0 & length(input$data3_class3)==0){
      unique(data3$`Classification III`)
    } else if(length(input$data3_class1)==0 & length(input$data3_class2)!=0 & length(input$data3_class3)!=0){
      input$data3_class3
    } else if(length(input$data3_class1)!=0 & length(input$data3_class2)==0 & length(input$data3_class3)!=0){
      input$data3_class3
    } else if(length(input$data3_class1)!=0 & length(input$data3_class2)!=0 & length(input$data3_class3)==0){
      unique(data3$`Classification III`)
    } else{
      input$data3_class3
    }
    
    final_data3 = final_data3 %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$data3_id_exposure!=''){
      final_data3 = final_data3 %>%
        filter(str_detect(str_to_lower(final_data3$id.exposure),str_to_lower(input$data3_id_exposure)))
    }
    
    if(input$data3_exposure!=''){
      final_data3 = final_data3 %>%
        filter(str_detect(str_to_lower(final_data3$exposure),str_to_lower(input$data3_exposure)))
    }
    
    if(!is.null(input$data3_id_outcome)) {
      final_data3 = final_data3 %>%
        filter(id.outcome %in% input$data3_id_outcome)
    }
    
    if(!is.null(input$data3_method)) {
      final_data3 = final_data3 %>%
        filter(method %in% input$data3_method)
    }
    
    if(!(input$data3_p_min==0 & input$data3_p_max==1)){
      
      final_data3 = final_data3 %>% 
        filter(pval>=input$data3_p_min)
      
      final_data3 = final_data3 %>% 
        filter(pval<=input$data3_p_max)
      
    }
    
    
    if(!is.null(input$data3_effect_direction)) {
      final_data3 = final_data3 %>%
        filter(effect_direction %in% input$data3_effect_direction)
    }
    
    if(input$data3_heterogeneity_pval){
      final_data3 = final_data3 %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$data3_horizontal_pval){
      final_data3 = final_data3 %>% 
        filter(Horizontal_pval>0.05)
    }
    
    if(!is.null(input$data3_consortium)) {
      final_data3 = final_data3 %>%
        filter(Consortium %in% input$data3_consortium)
    }
    
    
    if(!is.null(input$data3_sex)) {
      final_data3 = final_data3 %>%
        filter(Sex %in% input$data3_sex)
    }
    
    
    final_data3 = final_data3 %>% 
      filter(Year>=input$data3_year[1],
             Year<=input$data3_year[2])
    
    final_data3 %>% 
      select(-file_name)
    
  })
  
  output$data3 = renderDT({
    
    final_data3() %>%
      datatable(selection = 'single',
                escape = F,
                options = list(lengthMenu = c('5','10','15','20','30','40','60','80','100'),
                               lengthChange = T,
                               pageLength = 40,
                               autoWidth = F,
                               scrollX = T),
                rownames = F,
                class = 'display nowrap',
                editable = F) %>%
      formatStyle(columns = 1,backgroundColor = '#f3f3f3', fontWeight = 'bold')
    
  })
  
  output$data3_download = downloadHandler(
    filename = "Major analysis using IVW.csv",
    content = function(file) {
      write.csv(final_data3(),file,row.names = F)
    }
  )
  
  output$data3_title = renderUI({
    
    if(input$data3_80){
      data3_title = "80 exposure traits with consistent effect across three main outcome datasets"
    }
    
    if(input$data3_6){
      data3_title = "6 common exposure traits with evidence of effect on AD_ieu-b-5067 and AD_ieu-a-297"
    }
    
    if(input$data3_102){
      data3_title = "102 exclusive exposure traits with evidence of effect on AD_ieu-a-297"
    }
    
    if(input$data3_119){
      data3_title = "119 common exposure traits with evidence of effect on AD_ieu-b-2 and AD_ieu-a-297"
    }
    
    if(input$data3_223){
      data3_title = "223 exclusive exposure traits with evidence of effect on AD_ieu-b-2"
    }
    
    if(input$data3_57){
      data3_title = "57 common exposure traits with evidence of effect on AD_ieu-b-2 and AD_ieu-b-5067"
    }
    
    if(input$data3_270){
      data3_title = "270 exclusive exposure traits with evidence of effect on AD_ieu-b-5067"
    }
    
    if(input$data3_63){
      data3_title = "63 common exposure traits with positive effect across three main outcome datasets"
    }
    
    if(input$data3_4c){
      data3_title = "4 common exposure traits with evidence of positive effect on AD_ieu-b-5067 and AD_ieu-a-297"
    }
    
    if(input$data3_48){
      data3_title = "48 exclusive exposure traits with evidence of positive effect on AD_ieu-a-297"
    }
    
    if(input$data3_41){
      data3_title = "41 common exposure traits with evidence of positive effect on AD_ieu-b-2 and AD_ieu-a-297"
    }
    
    if(input$data3_65){
      data3_title = "65 exclusive exposure traits with evidence of positive effect on AD_ieu-b-2"
    }
    
    if(input$data3_35){
      data3_title = "35 common exposure traits with evidence of positive effect on AD_ieu-b-2 and AD_ieu-b-5067"
    }
    
    if(input$data3_149){
      data3_title = "149 exclusive exposure traits with evidence of positive effect on AD_ieu-b-5067"
    }

    if(input$data3_16){
      data3_title = "16 common exposure traits with negative effect across three main outcome datasets"
    }
    
    if(input$data3_2){
      data3_title = "2 common exposure traits with evidence of negative effect on AD_ieu-b-5067 and AD_ieu-a-297"
    }
    
    if(input$data3_54){
      data3_title = "54 exclusive exposure traits with evidence of negative effect on AD_ieu-a-297"
    }
    
    if(input$data3_79){
      data3_title = "79 common exposure traits with evidence of negative effect on AD_ieu-b-2 and AD_ieu-a-297"
    }
    
    if(input$data3_161){
      data3_title = "161 exclusive exposure traits with evidence of negative effect on AD_ieu-b-2"
    }
    
    if(input$data3_19){
      data3_title = "19 common exposure traits with evidence of negative effect on AD_ieu-b-2 and AD_ieu-b-5067"
    }
    
    if(input$data3_125){
      data3_title = "125 exclusive exposure traits with evidence of negative effect on  AD_ieu-b-5067"
    }

    if(input$data3_30){
      data3_title = "30 exposure traits with consistent effect across 13 FinnGen outcome datasets"
    }

    if(input$data3_26){
      data3_title = "26 exposure traits with positive effect across 13 FinnGen outcome datasets"
    }

    if(input$data3_4e){
      data3_title = "4 exposure traits with negative effect across 13 FinnGen outcome datasets"
    }
    
    h2(HTML(data3_title),align = 'center')
  })
  
  # IVW
  
  temp_IVW_class2 = reactive({
    
    if(length(input$IVW_class1)==0){
      unique(data1$`Classification II`)
    } else{
      data1 %>% 
        filter(`Classification I` %in% input$IVW_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_IVW_class2 = renderUI({
    selectInput(inputId = 'IVW_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_IVW_class2()),
                selected = 'blood lipids and lipoproteins',
                multiple = T)
  })
  
  temp_IVW_class3 = reactive({
    
    if(length(input$IVW_class1)==0 & length(input$IVW_class2)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_class1)==0 & length(input$IVW_class2)!=0){
      data1 %>% 
        filter(`Classification II` %in% input$IVW_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$IVW_class1)!=0 & length(input$IVW_class2)==0){
      data1 %>% 
        filter(`Classification I` %in% input$IVW_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data1 %>% 
        filter(`Classification I` %in% input$IVW_class1,
               `Classification II` %in% input$IVW_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
    
  })
  
  output$UI_IVW_class3 = renderUI({
    selectInput(inputId = 'IVW_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_IVW_class3()),
                multiple = T)
  })
  
  
  IVW_data = reactive({
    
    IVW_data = data1 %>%
      drop_na(pval) %>% 
      filter(method=='Inverse variance weighted') %>% 
      mutate(Exposure = str_c(exposure,id.exposure,sep = '\n'))
    
    
    select_class_1 = if(length(input$IVW_class1)==0){
      unique(data1$`Classification I`)
    } else{
      input$IVW_class1
    }
    
    select_class_2 = if(length(input$IVW_class1)==0 & length(input$IVW_class2)==0){
      unique(data1$`Classification II`)
    } else if(length(input$IVW_class1)==0 & length(input$IVW_class2)!=0){
      input$IVW_class2
    } else if(length(input$IVW_class1)!=0 & length(input$IVW_class2)==0){
      unique(data1$`Classification II`)
    } else{
      input$IVW_class2
    }
    
    select_class_3 = if(length(input$IVW_class1)==0 & length(input$IVW_class2)==0 & length(input$IVW_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_class1)==0 & length(input$IVW_class2)==0 & length(input$IVW_class3)!=0){
      input$IVW_class3
    } else if(length(input$IVW_class1)==0 & length(input$IVW_class2)!=0 & length(input$IVW_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_class1)!=0 & length(input$IVW_class2)==0 & length(input$IVW_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_class1)==0 & length(input$IVW_class2)!=0 & length(input$IVW_class3)!=0){
      input$IVW_class3
    } else if(length(input$IVW_class1)!=0 & length(input$IVW_class2)==0 & length(input$IVW_class3)!=0){
      input$IVW_class3
    } else if(length(input$IVW_class1)!=0 & length(input$IVW_class2)!=0 & length(input$IVW_class3)==0){
      unique(data1$`Classification III`)
    } else{
      input$IVW_class3
    }
    
    IVW_data = IVW_data %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$IVW_id_exposure!=''){
      IVW_data = IVW_data %>%
        filter(str_detect(str_to_lower(IVW_data$id.exposure),str_to_lower(input$IVW_id_exposure)))
    }
    
    if(input$IVW_exposure!=''){
      IVW_data = IVW_data %>%
        filter(str_detect(str_to_lower(IVW_data$exposure),str_to_lower(input$IVW_exposure)))
    }
    
    if(!is.null(input$IVW_id_outcome)) {
      IVW_data = IVW_data %>%
        filter(id.outcome %in% input$IVW_id_outcome)
    }
    
    if(!is.null(input$IVW_method)) {
      IVW_data = IVW_data %>%
        filter(method %in% input$IVW_method)
    }
    
    if(!(input$IVW_p_min==0 & input$IVW_p_max==1)){
      
      IVW_data = IVW_data %>% 
        filter(pval>=input$IVW_p_min)
      
      IVW_data = IVW_data %>% 
        filter(pval<=input$IVW_p_max)
      
    }
    
    
    if(!is.null(input$IVW_effect_direction)) {
      IVW_data = IVW_data %>%
        filter(effect_direction %in% input$IVW_effect_direction)
    }
    
    if(input$IVW_heterogeneity_pval){
      IVW_data = IVW_data %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$IVW_horizontal_pval){
      IVW_data = IVW_data %>% 
        filter(Horizontal_pval>0.05)
    }
    
    if(input$IVW_80_id_exposure){
      IVW_data = IVW_data %>%
        filter(id.exposure %in% id_exposure)
    }
    
    if(!is.null(input$IVW_consortium)) {
      IVW_data = IVW_data %>%
        filter(Consortium %in% input$IVW_consortium)
    }
    
    if(!is.null(input$IVW_sex)) {
      IVW_data = IVW_data %>%
        filter(Sex %in% input$IVW_sex)
    }
    
    IVW_data = IVW_data %>% 
      filter(Year>=input$IVW_year[1],
             Year<=input$IVW_year[2])
    
    
    if(input$IVW_uniprot_entry_id!=''){
      IVW_data = IVW_data %>%
        filter(str_detect(str_to_lower(IVW_data$`Uniprot Entry ID`),
                          str_to_lower(input$IVW_uniprot_entry_id)))
    }
    
    if(input$IVW_gene_names!=''){
      IVW_data = IVW_data %>%
        filter(str_detect(str_to_lower(IVW_data$`Gene Names`),
                          str_to_lower(input$IVW_gene_names)))
    }
    
    if(input$IVW_no_effect==T){
      
      length_total_id_outcome = length(unique(data1$id.outcome))
      temp_id_outcome = unique(IVW_data$id.outcome)
      length_temp_id_outcome = length(temp_id_outcome)
      
      remove_exposure = IVW_data %>% 
        group_by(Exposure) %>% 
        summarise(length_method = n(),
                  length_na_method = length_temp_id_outcome-length_method,
                  length_no_effect = sum(pval>0.05)+length_na_method) %>% 
        ungroup() %>% 
        filter(length_no_effect==length_temp_id_outcome) %>% 
        pull(Exposure)
      
      IVW_data = IVW_data %>% 
        filter(!(Exposure %in% remove_exposure))
      
    }
    
    IVW_data
    
  })
  
  IVW_plot = reactive({
    
    color_tab = data.frame(effect_size = -4:4) %>% 
      mutate(effect_size_label = factor(effect_size,
                                        labels = c('<-1','-1:-0.1','-0.1:-0.001','>-0.001',
                                                   '0','<0.001','0.001:0.1','0.1:1','>1')),
             color = c('#343c8c','#6764a5','#a29dc6','#d9d7e6','grey','#faebf3','#f3c1dc','#e9a3c9','#c51b7d'),
             effect_size_label = fct_rev(effect_size_label))
    
    cols = color_tab$color
    names(cols) = as.character(color_tab$effect_size_label)
    
    size_range = IVW_data() %>%
      pull(pval) %>% 
      range()
    size_breaks = seq(size_range[1],size_range[2],length = 4)
    
    IVW_data() %>%
      mutate(
        group = case_when(
          id.outcome %in% c('ieu-b-2','ieu-b-5067','ieu-a-297') ~ 'Main',
          !(id.outcome %in% c('ieu-b-2','ieu-b-5067','ieu-a-297')) ~ 'FinnGen'),
        group = fct_relevel(group,'Main','FinnGen'),
        effect_size = case_when(
          pval<0.05 & b>=1 ~ 4,
          pval<0.05 & b>0.1 & b<1 ~ 3,
          pval<0.05 & b>0.001 & b<0.1 ~ 2,
          pval<0.05 & b>=0 & b<0.001 ~ 1,
          pval>0.05 ~ 0,
          pval<0.05 & b>-0.001 & b<0 ~ -1,
          pval<0.05 & b>-0.1 & b<=-0.001 ~ -2,
          pval<0.05 & b>-1 & b<=-0.1 ~ -3,
          pval<0.05 & b<=-1 ~ -4)) %>%
      left_join(color_tab,by = 'effect_size') %>% 
      mutate(id.outcome = fct_relevel(id.outcome,
                                     'ieu-b-2',
                                     'ieu-b-5067',
                                     'ieu-a-297',
                                     'finn-b-G6_ALZHEIMER',
                                     'finn-b-G6_ALZHEIMER_EXMORE',
                                     'finn-b-G6_AD_WIDE',
                                     'finn-b-G6_AD_WIDE_EXMORE',
                                     'finn-b-G6_ALZHEIMER_INCLAVO',
                                     'finn-b-AD_AM',
                                     'finn-b-AD_AM_EXMORE',
                                     'finn-b-AD_EO',
                                     'finn-b-AD_EO_EXMORE',
                                     'finn-b-AD_LO',
                                     'finn-b-AD_LO_EXMORE',
                                     'finn-b-AD_U',
                                     'finn-b-AD_U_EXMORE')) %>% 
      ggplot(aes(x = id.outcome,
                 y = Exposure,
                 size = -log10(pval),
                 color = effect_size_label,
                 text = paste('</br>id.exposure: ',id.exposure,
                              '</br>exposure: ',exposure,
                              '</br>id.outcome: ',id.outcome,
                              '</br>outcome: ',outcome,
                              '</br>beta: ',b,
                              '</br>OR_CI: ',OR_CI,
                              '</br>pval: ',pval,
                              '</br>-log10(pval): ',-log10(pval),
                              '</br>nsnp: ',nsnp,
                              '</br>method: ',method,
                              '</br>Heterogeneity test: ',heterogeneity_pval,
                              '</br>Egger Intercept test: ',Horizontal_pval))) +
      geom_point() +
      # scale_size_continuous(trans = 'reverse',
      #                       breaks = size_breaks,
      #                       labels = round(size_breaks,4)) +
      scale_colour_manual(values = cols) +
      facet_grid(~group,scales = 'free_x',space = 'free_x') +
      labs(x = NULL,
           y = NULL,
           color = 'beta') +
      theme_light() +
      theme(axis.text.x = element_text(angle = 15,hjust = 1,size = 6),
            axis.text.y = element_text(size = 6))
    
    
  })
  
  output$IVW = renderPlotly({

    IVW_plot() %>%
      ggplotly(tooltip = c('text'),
               height = max((3 * 10 * length(unique(IVW_data()$Exposure)) + 300),300))

  })
  
  output$IVW_title = renderUI({
    IVW_title = str_c('Showing the results for exposure trait category: ',
                      str_c(input$IVW_class1,collapse = ', '))
    h6(HTML(IVW_title),align = 'center')
  })
  
  output$IVW_download_data = downloadHandler(
    filename = "IVW results for Alzheimer's disease outcomes.csv",
    content = function(file) {
      write.csv(IVW_data() %>% select(-Exposure),file,row.names = F)
    }
  )
  
  output$IVW_download_html = downloadHandler(
    filename = "IVW results for Alzheimer's disease outcomes.html",
    content = function(file) {
      
      IVW_plot() %>%
        ggplotly(tooltip = c('text'),
                 height = max((3 * 10 * length(unique(IVW_data()$Exposure)) + 300),300)) %>% 
        saveWidget(file = file)
      
    }
  )
  
  
  
  # IVW static
  
  temp_IVW_static_class2 = reactive({
    
    if(length(input$IVW_static_class1)==0){
      unique(data1$`Classification II`)
    } else{
      data1 %>% 
        filter(`Classification I` %in% input$IVW_static_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_IVW_static_class2 = renderUI({
    selectInput(inputId = 'IVW_static_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_IVW_static_class2()),
                selected = 'blood lipids and lipoproteins',
                multiple = T)
  })
  
  temp_IVW_static_class3 = reactive({
    
    if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)!=0){
      data1 %>% 
        filter(`Classification II` %in% input$IVW_static_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$IVW_static_class1)!=0 & length(input$IVW_static_class2)==0){
      data1 %>% 
        filter(`Classification I` %in% input$IVW_static_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data1 %>% 
        filter(`Classification I` %in% input$IVW_static_class1,
               `Classification II` %in% input$IVW_static_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
    
  })
  
  output$UI_IVW_static_class3 = renderUI({
    selectInput(inputId = 'IVW_static_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_IVW_static_class3()),
                multiple = T)
  })
  
  
  IVW_static_data = reactive({
    
    IVW_static_data = data1 %>%
      drop_na(pval) %>% 
      filter(method=='Inverse variance weighted') %>% 
      mutate(Exposure = str_c(exposure,id.exposure,sep = '\n'))
    
    
    select_class_1 = if(length(input$IVW_static_class1)==0){
      unique(data1$`Classification I`)
    } else{
      input$IVW_static_class1
    }
    
    select_class_2 = if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)==0){
      unique(data1$`Classification II`)
    } else if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)!=0){
      input$IVW_static_class2
    } else if(length(input$IVW_static_class1)!=0 & length(input$IVW_static_class2)==0){
      unique(data1$`Classification II`)
    } else{
      input$IVW_static_class2
    }
    
    select_class_3 = if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)==0 & length(input$IVW_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)==0 & length(input$IVW_static_class3)!=0){
      input$IVW_static_class3
    } else if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)!=0 & length(input$IVW_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_static_class1)!=0 & length(input$IVW_static_class2)==0 & length(input$IVW_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$IVW_static_class1)==0 & length(input$IVW_static_class2)!=0 & length(input$IVW_static_class3)!=0){
      input$IVW_static_class3
    } else if(length(input$IVW_static_class1)!=0 & length(input$IVW_static_class2)==0 & length(input$IVW_static_class3)!=0){
      input$IVW_static_class3
    } else if(length(input$IVW_static_class1)!=0 & length(input$IVW_static_class2)!=0 & length(input$IVW_static_class3)==0){
      unique(data1$`Classification III`)
    } else{
      input$IVW_static_class3
    }
    
    IVW_static_data = IVW_static_data %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$IVW_static_id_exposure!=''){
      IVW_static_data = IVW_static_data %>%
        filter(str_detect(str_to_lower(IVW_static_data$id.exposure),str_to_lower(input$IVW_static_id_exposure)))
    }
    
    if(input$IVW_static_exposure!=''){
      IVW_static_data = IVW_static_data %>%
        filter(str_detect(str_to_lower(IVW_static_data$exposure),str_to_lower(input$IVW_static_exposure)))
    }
    
    if(!is.null(input$IVW_static_id_outcome)) {
      IVW_static_data = IVW_static_data %>%
        filter(id.outcome %in% input$IVW_static_id_outcome)
    }
    
    if(!is.null(input$IVW_static_method)) {
      IVW_static_data = IVW_static_data %>%
        filter(method %in% input$IVW_static_method)
    }
    
    if(!(input$IVW_static_p_min==0 & input$IVW_static_p_max==1)){
      
      IVW_static_data = IVW_static_data %>% 
        filter(pval>=input$IVW_static_p_min)
      
      IVW_static_data = IVW_static_data %>% 
        filter(pval<=input$IVW_static_p_max)
      
    }
    
    
    if(!is.null(input$IVW_static_effect_direction)) {
      IVW_static_data = IVW_static_data %>%
        filter(effect_direction %in% input$IVW_static_effect_direction)
    }
    
    if(input$IVW_static_heterogeneity_pval){
      IVW_static_data = IVW_static_data %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$IVW_static_horizontal_pval){
      IVW_static_data = IVW_static_data %>% 
        filter(Horizontal_pval>0.05)
    }
    
    if(input$IVW_static_80_id_exposure){
      
      IVW_static_data = IVW_static_data %>%
        filter(id.exposure %in% id_exposure)
    }
    
    if(!is.null(input$IVW_static_consortium)) {
      IVW_static_data = IVW_static_data %>%
        filter(Consortium %in% input$IVW_static_consortium)
    }
    
    if(!is.null(input$IVW_static_sex)) {
      IVW_static_data = IVW_static_data %>%
        filter(Sex %in% input$IVW_static_sex)
    }
    
    IVW_static_data = IVW_static_data %>% 
      filter(Year>=input$IVW_static_year[1],
             Year<=input$IVW_static_year[2])
    
    
    if(input$IVW_static_uniprot_entry_id!=''){
      IVW_static_data = IVW_static_data %>%
        filter(str_detect(str_to_lower(IVW_static_data$`Uniprot Entry ID`),
                          str_to_lower(input$IVW_static_uniprot_entry_id)))
    }
    
    if(input$IVW_static_gene_names!=''){
      IVW_static_data = IVW_static_data %>%
        filter(str_detect(str_to_lower(IVW_static_data$`Gene Names`),
                          str_to_lower(input$IVW_static_gene_names)))
    }
    
    if(input$IVW_static_no_effect){
      
      length_total_id_outcome = length(unique(data1$id.outcome))
      temp_id_outcome = unique(IVW_static_data$id.outcome)
      length_temp_id_outcome = length(temp_id_outcome)
      
      remove_exposure = IVW_static_data %>% 
        group_by(Exposure) %>% 
        summarise(length_method = n(),
                  length_na_method = length_temp_id_outcome-length_method,
                  length_no_effect = sum(pval>0.05)+length_na_method) %>% 
        ungroup() %>% 
        filter(length_no_effect==length_temp_id_outcome) %>% 
        pull(Exposure)
      
      IVW_static_data = IVW_static_data %>% 
        filter(!(Exposure %in% remove_exposure))
      
    }
    
    IVW_static_data
    
  })
  
  IVW_static_plot = reactive({
    
    color_tab = data.frame(effect_size = -4:4) %>% 
      mutate(effect_size_label = factor(effect_size,
                                        labels = c('<-1','-1:-0.1','-0.1:-0.001','>-0.001',
                                                   '0','<0.001','0.001:0.1','0.1:1','>1')),
             color = c('#343c8c','#6764a5','#a29dc6','#d9d7e6','grey','#faebf3','#f3c1dc','#e9a3c9','#c51b7d'),
             effect_size_label = fct_rev(effect_size_label))
    
    cols = color_tab$color
    names(cols) = as.character(color_tab$effect_size_label)
    
    # size_range = IVW_static_data() %>%
    #   pull(pval) %>% 
    #   range()
    # size_breaks = seq(size_range[1],size_range[2],length = 4)
    
    IVW_static_data() %>%
      mutate(
        group = case_when(
          id.outcome %in% c('ieu-b-2','ieu-b-5067','ieu-a-297') ~ 'Main',
          !(id.outcome %in% c('ieu-b-2','ieu-b-5067','ieu-a-297')) ~ 'FinnGen'),
        group = fct_relevel(group,'Main','FinnGen'),
        effect_size = case_when(
          pval<0.05 & b>=1 ~ 4,
          pval<0.05 & b>0.1 & b<1 ~ 3,
          pval<0.05 & b>0.001 & b<0.1 ~ 2,
          pval<0.05 & b>=0 & b<0.001 ~ 1,
          pval>0.05 ~ 0,
          pval<0.05 & b>-0.001 & b<0 ~ -1,
          pval<0.05 & b>-0.1 & b<=-0.001 ~ -2,
          pval<0.05 & b>-1 & b<=-0.1 ~ -3,
          pval<0.05 & b<=-1 ~ -4)) %>%
      left_join(color_tab,by = 'effect_size') %>% 
      mutate(id.outcome = fct_relevel(id.outcome,
                                     'ieu-b-2',
                                     'ieu-b-5067',
                                     'ieu-a-297',
                                     'finn-b-G6_ALZHEIMER',
                                     'finn-b-G6_ALZHEIMER_EXMORE',
                                     'finn-b-G6_AD_WIDE',
                                     'finn-b-G6_AD_WIDE_EXMORE',
                                     'finn-b-G6_ALZHEIMER_INCLAVO',
                                     'finn-b-AD_AM',
                                     'finn-b-AD_AM_EXMORE',
                                     'finn-b-AD_EO',
                                     'finn-b-AD_EO_EXMORE',
                                     'finn-b-AD_LO',
                                     'finn-b-AD_LO_EXMORE',
                                     'finn-b-AD_U',
                                     'finn-b-AD_U_EXMORE')) %>% 
      ggplot(aes(x = id.outcome,
                 y = Exposure,
                 size = -log10(pval),
                 color = effect_size_label,
                 text = paste('</br>id.exposure: ',id.exposure,
                              '</br>exposure: ',exposure,
                              '</br>id.outcome: ',id.outcome,
                              '</br>outcome: ',outcome,
                              '</br>OR_CI: ',OR_CI,
                              '</br>pval: ',pval,
                              '</br>nsnp: ',nsnp,
                              '</br>method: ',method))) +
      geom_point() +
      # scale_size_continuous(trans = 'reverse',
      #                       breaks = size_breaks,
      #                       labels = round(size_breaks,4)) +
      scale_colour_manual(values = cols) +
      facet_grid(~group,scales = 'free_x',space = 'free_x') +
      labs(x = "Alzheimer's disease outcomes",
           y = 'Exposures',
           color = 'beta') +
      theme_light() +
      theme(axis.text.x = element_text(angle = 30,hjust = 1),
            text = element_text(size = 12),
            axis.title = element_text(size = 14))
    
    
  })
  
  output$IVW_static = renderPlot(
    expr = {
      IVW_static_plot()},
    
    height = function(){max(3 * 10 * length(unique(IVW_static_data()$Exposure)) + 220,250)}
    )
  
  output$IVW_static_title = renderUI({
    IVW_static_title = str_c('Showing the results for exposure trait category: ',
                             str_c(input$IVW_static_class1,collapse = ', '))
    h6(HTML(IVW_static_title),align = 'center')
  })
  
  output$IVW_static_download_data = downloadHandler(
    filename = "IVW results for Alzheimer's disease outcomes.csv",
    content = function(file) {
      write.csv(IVW_static_data() %>% select(-Exposure),file,row.names = F)
    }
  )
  
  
  # Sensitivity Analysis
  # SA
  
  temp_SA_class2 = reactive({
    
    if(length(input$SA_class1)==0){
      unique(data1$`Classification II`)
    } else{
      data1 %>% 
        filter(`Classification I` %in% input$SA_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_SA_class2 = renderUI({
    selectInput(inputId = 'SA_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_SA_class2()),
                selected = 'blood lipids and lipoproteins',
                multiple = T)
  })
  
  temp_SA_class3 = reactive({
    
    if(length(input$SA_class1)==0 & length(input$SA_class2)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_class1)==0 & length(input$SA_class2)!=0){
      data1 %>% 
        filter(`Classification II` %in% input$SA_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$SA_class1)!=0 & length(input$SA_class2)==0){
      data1 %>% 
        filter(`Classification I` %in% input$SA_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data1 %>% 
        filter(`Classification I` %in% input$SA_class1,
               `Classification II` %in% input$SA_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
    
  })
  
  output$UI_SA_class3 = renderUI({
    selectInput(inputId = 'SA_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_SA_class3()),
                multiple = T)
  })
  
  SA_data = reactive({
    
    SA_data = data1 %>%
      drop_na(pval,heterogeneity_pval,Horizontal_pval) %>% 
      filter(id.outcome %in% input$SA_id_outcome) %>% 
      mutate(Exposure = str_c(exposure,id.exposure,sep = '\n'))
    
    select_class_1 = if(length(input$SA_class1)==0){
      unique(data1$`Classification I`)
    } else{
      input$SA_class1
    }
    
    select_class_2 = if(length(input$SA_class1)==0 & length(input$SA_class2)==0){
      unique(data1$`Classification II`)
    } else if(length(input$SA_class1)==0 & length(input$SA_class2)!=0){
      input$SA_class2
    } else if(length(input$SA_class1)!=0 & length(input$SA_class2)==0){
      unique(data1$`Classification II`)
    } else{
      input$SA_class2
    }
    
    select_class_3 = if(length(input$SA_class1)==0 & length(input$SA_class2)==0 & length(input$SA_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_class1)==0 & length(input$SA_class2)==0 & length(input$SA_class3)!=0){
      input$SA_class3
    } else if(length(input$SA_class1)==0 & length(input$SA_class2)!=0 & length(input$SA_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_class1)!=0 & length(input$SA_class2)==0 & length(input$SA_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_class1)==0 & length(input$SA_class2)!=0 & length(input$SA_class3)!=0){
      input$SA_class3
    } else if(length(input$SA_class1)!=0 & length(input$SA_class2)==0 & length(input$SA_class3)!=0){
      input$SA_class3
    } else if(length(input$SA_class1)!=0 & length(input$SA_class2)!=0 & length(input$SA_class3)==0){
      unique(data1$`Classification III`)
    } else{
      input$SA_class3
    }
    
    SA_data = SA_data %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$SA_id_exposure!=''){
      SA_data = SA_data %>%
        filter(str_detect(str_to_lower(SA_data$id.exposure),str_to_lower(input$SA_id_exposure)))
    }
    
    if(input$SA_exposure!=''){
      SA_data = SA_data %>%
        filter(str_detect(str_to_lower(SA_data$exposure),str_to_lower(input$SA_exposure)))
    }
    
    # if(!is.null(input$SA_id_outcome)) {
    #   SA_data = SA_data %>%
    #     filter(id.outcome %in% input$SA_id_outcome)
    # }
    
    if(!is.null(input$SA_method)) {
      SA_data = SA_data %>%
        filter(method %in% input$SA_method)
    }
    
    if(!(input$SA_p_min==0 & input$SA_p_max==1)){
      
      SA_data = SA_data %>% 
        filter(pval>=input$SA_p_min)
      
      SA_data = SA_data %>% 
        filter(pval<=input$SA_p_max)
      
    }
    
    
    if(!is.null(input$SA_effect_direction)) {
      SA_data = SA_data %>%
        filter(effect_direction %in% input$SA_effect_direction)
    }
    
    if(input$SA_heterogeneity_pval){
      SA_data = SA_data %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$SA_horizontal_pval){
      SA_data = SA_data %>% 
        filter(Horizontal_pval>0.05)
    }
    
    if(!is.null(input$SA_consortium)) {
      SA_data = SA_data %>%
        filter(Consortium %in% input$SA_consortium)
    }
    
    if(!is.null(input$SA_sex)) {
      SA_data = SA_data %>%
        filter(Sex %in% input$SA_sex)
    }
    
    SA_data = SA_data %>% 
      filter(Year>=input$SA_year[1],
             Year<=input$SA_year[2])
    
    
    if(input$SA_uniprot_entry_id!=''){
      SA_data = SA_data %>%
        filter(str_detect(str_to_lower(SA_data$`Uniprot Entry ID`),
                          str_to_lower(input$SA_uniprot_entry_id)))
    }
    
    if(input$SA_gene_names!=''){
      SA_data = SA_data %>%
        filter(str_detect(str_to_lower(SA_data$`Gene Names`),
                          str_to_lower(input$SA_gene_names)))
    }
    
    if(input$SA_no_effect){
      
      temp_method = unique(SA_data$method)
      length_temp_method = length(temp_method)
      
      remove_exposure = SA_data %>% 
        pivot_wider(names_from = 'method',
                    values_from = 'pval') %>% 
        group_by(Exposure) %>% 
        fill(temp_method,.direction = 'downup') %>% 
        ungroup() %>% 
        select(Exposure,temp_method,heterogeneity_pval,Horizontal_pval) %>% 
        pivot_longer(cols = temp_method,
                     names_to = 'method',
                     values_to = 'pval') %>% 
        group_by(Exposure) %>% 
        summarise(length_no_effect = sum(pval>0.05)+
                    as.numeric(heterogeneity_pval<=0.05)+
                    as.numeric(Horizontal_pval<=0.05)) %>% 
        ungroup() %>% 
        filter(length_no_effect==length_temp_method+2) %>% 
        pull(Exposure)
      
      SA_data = SA_data %>% 
        filter(!(Exposure %in% remove_exposure))
      
    }
    
    if(!is.null(input$SA_passed)){
      
      temp_method = str_remove_all(input$SA_passed,' passed')
      
      passed_exposure = SA_data %>% 
        pivot_wider(names_from = 'method',
                    values_from = 'pval') %>% 
        group_by(Exposure) %>%
        fill(temp_method,.direction = 'downup') %>%
        ungroup() %>%
        filter_at(.vars = vars(temp_method),all_vars(.<0.05)) %>%
        pull(Exposure)
      
      SA_data = SA_data %>%
        filter(Exposure %in% passed_exposure)
    }
    
    SA_data
    
  })
  
  SA_plot = reactive({
    
    color_tab = data.frame(effect_size = -4:4) %>% 
      mutate(effect_size_label = factor(effect_size,
                                        labels = c('<-1','-1:-0.1','-0.1:-0.001','>-0.001',
                                                   '0','<0.001','0.001:0.1','0.1:1','>1')),
             color = c('#343c8c','#6764a5','#a29dc6','#d9d7e6','grey','#faebf3','#f3c1dc','#e9a3c9','#c51b7d'),
             effect_size_label = fct_rev(effect_size_label))
    
    cols = c(color_tab$color)
    names(cols) = as.character(color_tab$effect_size_label)
    
    temp_SA_data1 = SA_data() %>%
      mutate(
        effect_size = case_when(
          pval<0.05 & b>=1 ~ 4,
          pval<0.05 & b>0.1 & b<1 ~ 3,
          pval<0.05 & b>0.001 & b<0.1 ~ 2,
          pval<0.05 & b>=0 & b<0.001 ~ 1,
          pval>0.05 ~ 0,
          pval<0.05 & b>-0.001 & b<0 ~ -1,
          pval<0.05 & b>-0.1 & b<=-0.001 ~ -2,
          pval<0.05 & b>-1 & b<=-0.1 ~ -3,
          pval<0.05 & b<=-1 ~ -4),
        Exposure = str_c(Exposure,'\n','SNPs:',nsnp)) %>%
      left_join(color_tab,by = 'effect_size') %>% 
      select(Exposure,method,nsnp,b,pval,effect_size_label,
             id.exposure,exposure,id.outcome,outcome,OR_CI)
    
    temp_SA_data2 = SA_data() %>% 
      select(Exposure,nsnp,b,heterogeneity_pval,Horizontal_pval,
             id.exposure,exposure,id.outcome,outcome,OR_CI) %>% 
      mutate(OR_CI = NA,
             b = NA) %>% 
      pivot_longer(cols = c('heterogeneity_pval','Horizontal_pval'),
                   names_to = 'method',
                   values_to = 'pval') %>% 
      mutate(Exposure = str_c(Exposure,'\n','SNPs:',nsnp),
             effect_size_label = ifelse(pval>0.05,'>1','0'),
             effect_size_label = factor(effect_size_label,
                                        levels = levels(color_tab$effect_size_label)))
    
    bind_rows(temp_SA_data1,temp_SA_data2) %>%
      mutate(method = factor(method,
                             levels = c('Inverse variance weighted',
                                        'MR Egger',
                                        'Weighted median',
                                        'Simple mode',
                                        'Weighted mode',
                                        'Maximum likelihood',
                                        'Penalised weighted median',
                                        'heterogeneity_pval',
                                        'Horizontal_pval'),
                             labels = c('Inverse variance weighted',
                                        'MR egger',
                                        'Weighted median',
                                        'Simple mode',
                                        'Weighted mode',
                                        'Maximum likelihood',
                                        'Penalised weighted median',
                                        'Heterogeneity test',
                                        'Egger Intercept test'))) %>% 
      ggplot(mapping = aes(x = method,
                           y = Exposure,
                           color = effect_size_label,
                           text = paste('</br>id.exposure: ',id.exposure,
                                        '</br>exposure: ',exposure,
                                        '</br>id.outcome: ',id.outcome,
                                        '</br>outcome: ',outcome,
                                        '</br>beta: ',b,
                                        '</br>OR_CI: ',OR_CI,
                                        '</br>pval: ',pval,
                                        '</br>nsnp: ',nsnp,
                                        '</br>method: ',method))) +
      geom_point(shape = 15,size = 7) +
      scale_colour_manual(values = cols) +
      scale_x_discrete(position = 'top') +
      # coord_fixed(ratio = 1) +
      labs(x = NULL,
           y = NULL,
           color = c('beta\npval')) +
      theme_light() +
      theme(axis.text.x.top = element_text(angle = 30,hjust = 0),
            axis.text.x = element_text(angle = 30,hjust = 0))
    
    
    
  })
  
  output$SA = renderPlotly({
    
    SA_plot() %>%
      ggplotly(tooltip = c('text'),
               height = max((4.5 * 10 * length(unique(SA_data()$Exposure)) + 300),300))
    
  })
  
  output$SA_title_main = renderUI({
    SA_title_main = str_c("Sensitivity analysis results for Alzheimer's disease outcomes: ",
                     str_c(input$SA_id_outcome))
    h2(HTML(SA_title_main),align = 'center')
  })
  
  output$SA_title = renderUI({
    SA_title = str_c('Showing the results for exposure trait category: ',
                     str_c(input$SA_class1,collapse = ', '))
    h6(HTML(SA_title),align = 'center')
  })
  
  output$SA_download_data = downloadHandler(
    filename = str_c("Sensitivity analysis results for Alzheimer's disease outcomes ",
                     input$SA_id_outcome,
                     ".csv"),
    content = function(file) {
      write.csv(SA_data() %>% select(-Exposure),file,row.names = F)
    }
  )
  
  output$SA_download_html = downloadHandler(
    filename = str_c("Sensitivity analysis results for Alzheimer's disease outcomes ",
                     input$SA_id_outcome,
                     ".html"),
    content = function(file) {
      
      SA_plot() %>%
        ggplotly(tooltip = c('text'),
                 height = max((5.5 * 10 * length(unique(SA_data()$Exposure)) + 300),300)) %>% 
        saveWidget(file = file)
      
    }
  )
  
  
  # SA
  
  temp_SA_static_class2 = reactive({
    
    if(length(input$SA_static_class1)==0){
      unique(data1$`Classification II`)
    } else{
      data1 %>% 
        filter(`Classification I` %in% input$SA_static_class1) %>% 
        pull(`Classification II`) %>% 
        unique()
    }
    
  })
  
  output$UI_SA_static_class2 = renderUI({
    selectInput(inputId = 'SA_static_class2',
                label = strong('Classification II:'),
                choices = c('Please select Classification II' = '',temp_SA_static_class2()),
                selected = 'blood lipids and lipoproteins',
                multiple = T)
  })
  
  temp_SA_static_class3 = reactive({
    
    if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)!=0){
      data1 %>% 
        filter(`Classification II` %in% input$SA_static_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else if(length(input$SA_static_class1)!=0 & length(input$SA_static_class2)==0){
      data1 %>% 
        filter(`Classification I` %in% input$SA_static_class1) %>% 
        pull(`Classification III`) %>% 
        unique()
    } else {
      data1 %>% 
        filter(`Classification I` %in% input$SA_static_class1,
               `Classification II` %in% input$SA_static_class2) %>% 
        pull(`Classification III`) %>% 
        unique()
    }
    
    
  })
  
  output$UI_SA_static_class3 = renderUI({
    selectInput(inputId = 'SA_static_class3',
                label = strong('Classification III:'),
                choices = c('Please select Classification III' = '',temp_SA_static_class3()),
                multiple = T)
  })
  
  SA_static_data = reactive({
    
    SA_static_data = data1 %>%
      drop_na(pval,heterogeneity_pval,Horizontal_pval) %>% 
      filter(id.outcome %in% input$SA_static_id_outcome) %>% 
      mutate(Exposure = str_c(exposure,id.exposure,sep = '\n'))
    
    select_class_1 = if(length(input$SA_static_class1)==0){
      unique(data1$`Classification I`)
    } else{
      input$SA_static_class1
    }
    
    select_class_2 = if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)==0){
      unique(data1$`Classification II`)
    } else if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)!=0){
      input$SA_static_class2
    } else if(length(input$SA_static_class1)!=0 & length(input$SA_static_class2)==0){
      unique(data1$`Classification II`)
    } else{
      input$SA_static_class2
    }
    
    select_class_3 = if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)==0 & length(input$SA_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)==0 & length(input$SA_static_class3)!=0){
      input$SA_static_class3
    } else if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)!=0 & length(input$SA_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_static_class1)!=0 & length(input$SA_static_class2)==0 & length(input$SA_static_class3)==0){
      unique(data1$`Classification III`)
    } else if(length(input$SA_static_class1)==0 & length(input$SA_static_class2)!=0 & length(input$SA_static_class3)!=0){
      input$SA_static_class3
    } else if(length(input$SA_static_class1)!=0 & length(input$SA_static_class2)==0 & length(input$SA_static_class3)!=0){
      input$SA_static_class3
    } else if(length(input$SA_static_class1)!=0 & length(input$SA_static_class2)!=0 & length(input$SA_static_class3)==0){
      unique(data1$`Classification III`)
    } else{
      input$SA_static_class3
    }
    
    SA_static_data = SA_static_data %>% 
      filter(`Classification I` %in% select_class_1) %>%
      filter(`Classification II` %in% select_class_2) %>%
      filter(`Classification III` %in% select_class_3)
    
    if(input$SA_static_id_exposure!=''){
      SA_static_data = SA_static_data %>%
        filter(str_detect(str_to_lower(SA_static_data$id.exposure),str_to_lower(input$SA_static_id_exposure)))
    }
    
    if(input$SA_static_exposure!=''){
      SA_static_data = SA_static_data %>%
        filter(str_detect(str_to_lower(SA_static_data$exposure),str_to_lower(input$SA_static_exposure)))
    }
    
    if(!is.null(input$SA_static_method)) {
      SA_static_data = SA_static_data %>%
        filter(method %in% input$SA_static_method)
    }
    
    if(!(input$SA_static_p_min==0 & input$SA_static_p_max==1)){
      
      SA_static_data = SA_static_data %>% 
        filter(pval>=input$SA_static_p_min)
      
      SA_static_data = SA_static_data %>% 
        filter(pval<=input$SA_static_p_max)
      
    }
    
    
    if(!is.null(input$SA_static_effect_direction)) {
      SA_static_data = SA_static_data %>%
        filter(effect_direction %in% input$SA_static_effect_direction)
    }
    
    if(input$SA_static_heterogeneity_pval){
      SA_static_data = SA_static_data %>% 
        filter(heterogeneity_pval>0.05)
    }
    
    if(input$SA_static_horizontal_pval){
      SA_static_data = SA_static_data %>% 
        filter(Horizontal_pval>0.05)
    }

    
    if(!is.null(input$SA_static_consortium)) {
      SA_static_data = SA_static_data %>%
        filter(Consortium %in% input$SA_static_consortium)
    }
    
    if(!is.null(input$SA_static_sex)) {
      SA_static_data = SA_static_data %>%
        filter(Sex %in% input$SA_static_sex)
    }
    
    SA_static_data = SA_static_data %>% 
      filter(Year>=input$SA_static_year[1],
             Year<=input$SA_static_year[2])
    
    
    if(input$SA_static_uniprot_entry_id!=''){
      SA_static_data = SA_static_data %>%
        filter(str_detect(str_to_lower(SA_static_data$`Uniprot Entry ID`),
                          str_to_lower(input$SA_static_uniprot_entry_id)))
    }
    
    if(input$SA_static_gene_names!=''){
      SA_static_data = SA_static_data %>%
        filter(str_detect(str_to_lower(SA_static_data$`Gene Names`),
                          str_to_lower(input$SA_static_gene_names)))
    }
    
    if(input$SA_static_no_effect){
      
      temp_method = unique(SA_static_data$method)
      length_temp_method = length(temp_method)
      
      remove_exposure = SA_static_data %>% 
        pivot_wider(names_from = 'method',
                    values_from = 'pval') %>% 
        group_by(Exposure) %>% 
        fill(temp_method,.direction = 'downup') %>% 
        ungroup() %>% 
        select(Exposure,temp_method,heterogeneity_pval,Horizontal_pval) %>% 
        pivot_longer(cols = temp_method,
                     names_to = 'method',
                     values_to = 'pval') %>% 
        group_by(Exposure) %>% 
        summarise(length_no_effect = sum(pval>0.05) +
                    as.numeric(heterogeneity_pval<=0.05) +
                    as.numeric(Horizontal_pval<=0.05)) %>% 
        ungroup() %>% 
        filter(length_no_effect==length_temp_method+2) %>% 
        pull(Exposure)
      
      SA_static_data = SA_static_data %>% 
        filter(!(Exposure %in% remove_exposure))
      
    }
    
    if(!is.null(input$SA_static_passed)){
      
      temp_method = str_remove_all(input$SA_static_passed,' passed')
      
      passed_exposure = SA_static_data %>% 
        pivot_wider(names_from = 'method',
                    values_from = 'pval') %>% 
        group_by(Exposure) %>%
        fill(temp_method,.direction = 'downup') %>%
        ungroup() %>%
        filter_at(.vars = vars(temp_method),all_vars(.<0.05)) %>%
        pull(Exposure)

      SA_static_data = SA_static_data %>%
        filter(Exposure %in% passed_exposure)
    }
    
    
    SA_static_data
    
  })
  
  SA_static_plot = reactive({
    
    color_tab = data.frame(effect_size = -4:4) %>% 
      mutate(effect_size_label = factor(effect_size,
                                        labels = c('<-1','-1:-0.1','-0.1:-0.001','>-0.001',
                                                   '0','<0.001','0.001:0.1','0.1:1','>1')),
             color = c('#343c8c','#6764a5','#a29dc6','#d9d7e6','grey','#faebf3','#f3c1dc','#e9a3c9','#c51b7d'),
             effect_size_label = fct_rev(effect_size_label))
    
    cols = c(color_tab$color)
    names(cols) = as.character(color_tab$effect_size_label)
    
    temp_SA_static_data1 = SA_static_data() %>%
      mutate(
        effect_size = case_when(
          pval<0.05 & b>=1 ~ 4,
          pval<0.05 & b>0.1 & b<1 ~ 3,
          pval<0.05 & b>0.001 & b<0.1 ~ 2,
          pval<0.05 & b>=0 & b<0.001 ~ 1,
          pval>0.05 ~ 0,
          pval<0.05 & b>-0.001 & b<0 ~ -1,
          pval<0.05 & b>-0.1 & b<=-0.001 ~ -2,
          pval<0.05 & b>-1 & b<=-0.1 ~ -3,
          pval<0.05 & b<=-1 ~ -4),
        Exposure = str_c(Exposure,'\n','SNPs:',nsnp)) %>%
      left_join(color_tab,by = 'effect_size') %>% 
      select(Exposure,method,nsnp,b,pval,effect_size_label,
             id.exposure,exposure,id.outcome,outcome,OR_CI)
    
    temp_SA_static_data2 = SA_static_data() %>% 
      select(Exposure,nsnp,b,heterogeneity_pval,Horizontal_pval,
             id.exposure,exposure,id.outcome,outcome,OR_CI) %>% 
      mutate(OR_CI = NA,
             b = NA) %>% 
      pivot_longer(cols = c('heterogeneity_pval','Horizontal_pval'),
                   names_to = 'method',
                   values_to = 'pval') %>% 
      mutate(Exposure = str_c(Exposure,'\n','SNPs:',nsnp),
             effect_size_label = ifelse(pval>0.05,'>1','0'),
             effect_size_label = factor(effect_size_label,
                                        levels = levels(color_tab$effect_size_label)))
    
    bind_rows(temp_SA_static_data1,temp_SA_static_data2) %>%
      mutate(method = factor(method,
                             levels = c('Inverse variance weighted',
                                        'MR Egger',
                                        'Weighted median',
                                        'Simple mode',
                                        'Weighted mode',
                                        'Maximum likelihood',
                                        'Penalised weighted median',
                                        'heterogeneity_pval',
                                        'Horizontal_pval'),
                             labels = c('Inverse variance weighted',
                                        'MR egger',
                                        'Weighted median',
                                        'Simple mode',
                                        'Weighted mode',
                                        'Maximum likelihood',
                                        'Penalised weighted median',
                                        'Heterogeneity test',
                                        'Egger Intercept test'))) %>% 
      ggplot(mapping = aes(x = method,
                           y = Exposure,
                           color = effect_size_label,
                           text = paste('</br>id.exposure: ',id.exposure,
                                        '</br>exposure: ',exposure,
                                        '</br>id.outcome: ',id.outcome,
                                        '</br>outcome: ',outcome,
                                        '</br>beta: ',b,
                                        '</br>OR_CI: ',OR_CI,
                                        '</br>pval: ',pval,
                                        '</br>nsnp: ',nsnp,
                                        '</br>method: ',method))) +
      geom_point(shape = 15,size = 10) +
      scale_colour_manual(values = cols) +
      scale_x_discrete(position = 'top') +
      # coord_fixed(ratio = 1) +
      labs(x = NULL,
           y = NULL,
           color = c('beta\npval')) +
      theme_light() +
      theme(axis.text.x.top = element_text(angle = 30,hjust = 0),
            text = element_text(size = 12))
    
    
    
  })
  
  output$SA_static = renderPlot(expr = {
    SA_static_plot()
  },
  height = function(){max(4.5 * 10 * length(unique(SA_static_data()$Exposure)) + 300,250)})
  
  output$SA_static_title_main = renderUI({
    SA_static_title_main = str_c("Sensitivity analysis results for Alzheimer's disease outcomes: ",
                                 str_c(input$SA_static_id_outcome))
    h2(HTML(SA_static_title_main),align = 'center')
  })
  
  output$SA_static_title = renderUI({
    SA_static_title = str_c('Showing the results for exposure trait category: ',
                            str_c(input$SA_static_class1,collapse = ', '))
    h6(HTML(SA_static_title),align = 'center')
  })
  
  
  output$SA_static_download_data = downloadHandler(
    filename = str_c("Sensitivity analysis results for Alzheimer's disease outcomes ",
                     input$SA_static_id_outcome,
                     ".csv"),
    content = function(file) {
      write.csv(SA_static_data() %>% select(-Exposure),file,row.names = F)
    }
  )
  
  
}

shinyApp(ui = ui,server = server)

