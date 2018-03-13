#' InfoBoxModal_UI
#'
#' This shiny module UI creates an InfoBox that can be clicked on to bring up a modal dialof with expanded details of the summary in the InfoBox.
#' @param id Unique Identifier for the UI in the shiny app UI
#' @param title InfoBox title, Default is "My InfoModalBox
#' @param value Value to be displayed, typically a summary value. Default is 100
#' @param color Color of InfoBox, Default is "green" For options see shiny InfoBox documentation
#' @param color Icon to display, it is a call to shiny's icon() function. Default is "thumbs-up"
#' @keywords InfoBox shinydashboard ModalDialog
#' @export
#' @examples
#' InfoBoxModal_UI("InfoBox")
InfoBoxModal_UI<-function(id,title='My InfoModalBox',color='red',value=100,icon='thumbs-up'){

    ns<-NS(id)

    tagList(
      useShinyjs(),

      tags$div(id=ns("box1"),style="cursor:pointer;",

      HTML(paste('<div class="col-sm-4">
              <div class="info-box bg-',color,'">
                <span class="info-box-icon">
                  ',icon(icon),'
                </span>
                <div class="info-box-content">
                  <span class="info-box-text">',title,'</span>
                  <span class="info-box-number">',value,'</span>
                </div>
              </div>
            </div>
           ',sep=''))
        #infoBox("Average mpg of mtcars", value=NULL,icon = icon('car'), color = "blue", width = 4,fill=T,href = NULL)
      ))


}

#' InfoBoxModal
#'
#' This shiny module server function registers a click event on the InfoBox and pulls up a shinyDialog Box. The function accepts whatever tagList of UI elements you wish to display in the pop up.
#' @param title Modal Dialog title
#' @param size Modal Dialog title
#' @param elements A tagList of UI elements to be shown in the modal box
#' @keywords InfoBox shinydashboard ModalDialog
#' @export
#' @examples
#' callModule(InfoBoxModal,"InfoBox",tagList(fluidRow(column(6,h3('Header for Stuff for Modal')),column(6,h3('More Stuff')))))
InfoBoxModal<-function(input,output,session,title="My InfoModalBox Modal Title",size='l',elements){

    #Use shiny js to create click event to call modal dialog
    onclick("box1",showModal(dataModal_InfoBox(title)))

    #Based on shiny Modal Dialog but customized some here
    dataModal_InfoBox<-function(title='Complete Dataset for mtcars'){

      modalDialog(title=HTML(paste('<center><h3>',title,'</h3></center>')),size=size,


                  elements


        )
    }
}
