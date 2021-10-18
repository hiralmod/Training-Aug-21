function startExam(){
    alert("You can start the exam");
      window.open("assignment.html");
    
}
function stopExam(){
    setTimeout(() =>{
        alert("Exam is Over");
        window.close();
    }, 1000 * 60 );
   
}

