$(document).ready(
        function()
        {       
                $("#tab1").mouseover(function(){
                        $("#tab2view").css("visibility","hidden") ;
                        $("#tab3view").css("visibility","hidden") ;
                        $("#tab1view").css("visibility","visible") ;
                        $("#tab1").css("background-color","#2E3C69") ;
                        $("#tab2").css("background-color","#001452") ;                       
                        $("#tab3").css("background-color","#001452") ;
                        $("#tab1").css("background-color","#2E3C69") ; 
                        $("#tab1").css("border-bottom","4px solid green") ;                        
                        $("#tab2").css("border-bottom","4px solid #4EA44E") ;
                        $("#tab3").css("border-bottom","4px solid #4EA44E") ;                                              
                });
                $("#tab2").mouseover(function(){
                        $("#tab1view").css("visibility","hidden") ;
                        $("#tab3view").css("visibility","hidden") ;
                        $("#tab2view").css("visibility","visible") ;
                        $("#tab1").css("background-color","#001452") ;
                        $("#tab2").css("background-color","#2E3C69") ;                       
                        $("#tab3").css("background-color","#001452") ;   
                        $("#tab2").css("border-bottom","4px solid green") ;                        
                        $("#tab1").css("border-bottom","4px solid #4EA44E") ;
                        $("#tab3").css("border-bottom","4px solid #4EA44E") ;                                                
                });
                $("#tab3").mouseover(function(){
                        $("#tab2view").css("visibility","hidden") ;
                        $("#tab1view").css("visibility","hidden") ;
                        $("#tab3view").css("visibility","visible") ;
                        $("#tab1").css("background-color","#001452") ;
                        $("#tab2").css("background-color","#001452") ;                       
                        $("#tab3").css("background-color","#2E3C69") ;                        
                        $("#tab3").css("border-bottom","4px solid green") ;                        
                        $("#tab2").css("border-bottom","4px solid #4EA44E") ;
                        $("#tab1").css("border-bottom","4px solid #4EA44E") ;                                                 
                });        
        });

