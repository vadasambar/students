var app = angular.module("recorder", ["ngResource"]);



app.controller("studentsController", function($scope, $resource){
  // console.log(document.getElementsByName("csrf-token")[0].getAttribute("content"));
  // for cross site forgery protection. Get csrf-token from html and send it with requests to the server
  var csrfToken = document.getElementsByName("csrf-token")[0].getAttribute("content");
  var headerWithCsrf = {"X-CSRF-Token": csrfToken};

  Students = $resource('/records/:id', {id: "@id"}, {save: {method: "POST", headers: headerWithCsrf },                                                                                   delete: {method: "DELETE", headers: headerWithCsrf},
                                                     update: {method: "PUT", headers: headerWithCsrf},
                                                     last: {method: "GET", url: "/last"}}); // @id is the id of the object I query from the server 
  
  $scope.toEdit = {};   // edit student details 
  $scope.isEditInvalid = false; // initialize
  $scope.isInputInvalid = false; 

  // show 
  $scope.students= Students.query();

  // add new 
  $scope.addStudent = function() {
    // check if the input is valid
    student = angular.copy($scope.newStudent);

    if(isStudentInvalid(student)){
      $scope.isInputInvalid = true;
      throwError(student); 
      
    } else { 
      $scope.students.push(student);
      var index = $scope.students.indexOf(student); // get index of new student in $scope.students

      // make sure the student is saved before quering for id 
      Students.save(student).$promise.then(function(saveResponse){
              Students.last().$promise.then(function(lastResponse){ 
                $scope.students[index].id = lastResponse.id;});
      });  

      $scope.isInputInvalid = false;      
      // wait till the promise is fulfilled 
      // update new student with its true id when the promise is fulfilled.
      // very hacky but works
      // console.log("LAST STUDENT: ", Students.last());
      $scope.students[index].id = Students.last(); // put in an object for now to make it display. 
      $scope.newStudent = {}; // empty new student so that input fields become empty 
    }
  };

  // edit 
  $scope.saveEdit = function(index){
    if(isStudentInvalid($scope.toEdit)){
      // console.log("Student is indeed invalid");
      // console.log("Invalid Student: ", $scope.toEdit);
      $scope.isEditInvalid = true; 

    } else {
      $scope.students[index] = $scope.toEdit;
      Students.update($scope.students[index]);    
      $scope.reset();
      $scope.isEditInvalid = false; 
    } };

  // delete  
  $scope.delStudent = function(index){
    toRemove = $scope.students[index];
    Students.delete(toRemove); // remove student from server
    $scope.students.splice(index, 1); // remove from $scope
    };



  // HELPER METHODS 
  //================

  // make a record of student to edit
  $scope.editStudent = function(student){
    $scope.isEditInvalid = false;  // false until I hit the save button and it checks for data validity. check saveEdit() 
    $scope.toEdit = angular.copy(student); // angular.copy does deep copy. I don't want to change my original object
    console.log("To edit: ", $scope.toEdit);
  };

  // empty toEdit once finished with editing 
  $scope.reset = function(){ $scope.toEdit ={};};

  // valid student data
  var isStudentInvalid = function(student){
    return student.name === undefined || student.name.trim() === "" || student.grade === undefined || student.roll === undefined;  
  };

  // display normal template or edit template depending on the button pressed
  $scope.getTemplate = function(student){
    // console.log("inside get template\n=================");
    // console.log("students: ", $scope.students);
    // console.log("to edit: ", $scope.toEdit);
    // console.log("......................../");
    if (student.id == $scope.toEdit.id) {
      return 'edit';
    } else {
      return 'display';
    }
  };

  // throw error for invalid input 
  var throwError = function(student){
    errorMessage = document.getElementById('input-error');
    errorMessage.innerHTML = "<b>Invalid Data!<b> ";

    if(student.name === undefined || student.name.trim() === ""){
      errorMessage.innerHTML += "Enter a valid name! ";
    }

    if(student.grade === undefined){
      errorMessage.innerHTML += "Enter a valid class! ";
    }

    if(student.roll === undefined){
      errorMessage.innerHTML += "Enter a valid roll number!";
    }
  };

});
