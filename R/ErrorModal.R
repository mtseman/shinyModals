#' ErrorModal_UI
#'
#' This shiny module UI runs a specified function and alerts tha the function was completed or shows an error with message parameter for most likely cause.
#' @param id Unique Identifier for the UI in the shiny app UI
#' @param title InfoBox title, Default is "My InfoModalBox
#' @param value Value to be displayed, typically a summary value. Default is 100
#' @param color Color of InfoBox, Default is "green" For options see shiny InfoBox documentation
#' @param color Icon to display, it is a call to shiny's icon() function. Default is "thumbs-up"
#' @keywords InfoBox shinydashboard ModalDialog
#' @export
#' @examples
#' ErrorModal_UI("RobustDo")
ErrorModal_UI<-function(id,label='Go'){

    ns<-NS(id)

    tagList(

       actionButton(ns('Robust_Do'),label=label)



    )

}

#' ErrorModal_UI
#'
#' This shiny module UI runs a specified function and alerts tha the function was completed or shows an error with message parameter for most likely cause.
#' @param title Title for the Error box, defaults to "Error", but could be custom message
#' @param subtitle Optional subtitle to describe the error
#' @param message Ideally most likely cause for error. Example would be
#' @param try_this User specified function to run. This will be completed if successful or on error the modal box will be shown
#' @keywords ErrorModal tryCatch shinydashboard ModalDialog
#' @export
#' @examples
#' callModule(ErrorModal,"TryThis_01",title="Error",subtitle=NULL,message='Sorry, invalid column selection',try_this=column_select(input$col))

ErrorModal<-function(input,output,session,title="Error",subtitle=NULL,message='Sorry, an error has occured',try_this){

  #ObserveEvent on Action button. Run "try_this" and toggle Modal if there is an error
  observeEvent(input$Robust_Do,{

    robust_do(try_this,subtitle=subtitle,message=message)


  })



  #*************************************************************************************************************
  #Wrapper on the tryCatch function that also takes a message and subtitle parameter to pass along to the modal
  #**************************************************************************************************************
    #Function that takes a try function and if error displays a message in a modal
    robust_do<-function(try_this,message=NULL,subtitle=NULL){


        Dialog_Error <- function(title='Error',message=NULL,id='shiny-modal',color='red',subtitle='Sorry an error has occured, please try again.') {

            HTML(paste('<div style="margin-top:50px;"></div><div class="modal sbs-modal fade" id="',id,'" tabindex="-1" data-sbs-trigger="tabBut">
              <div class="modal-dialog modal-lg">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                      <span>&times;</span>
                    </button>
                    <h4 class="modal-title"><div style="color:',color,';"><h3><b><center>',title,'</center></h3></b></div></h4>
                  </div>
                  <div class="modal-body">
                    <h4><center>',subtitle,'</center></h4><hr>
                    <p>',message,'<p>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                  </div>
                </div>
              </div>
            </div>
             <script>$("#shiny-modal").modal().focus();</script>',sep=''))

          }

        try_this_all<-function(try_this){

          try_this

          #if(include.successModal==T){


          #}

        }

        robust_do<-tryCatch(try_this,
                                warning=function(w){try_this},
                                error=function(e){

                                    showModal(Dialog_Error())


                                }
        )

    }
}
