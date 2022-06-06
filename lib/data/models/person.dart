class Person{

   int? id;
   String? name;
   String? profilePath;
   String? knowForDepartment;
   double? popularity;



    Person.fromJson(Map<String ,dynamic> json){

    id= json['id'];
    name= json['name'];
    profilePath= json['profile_path'];
    knowForDepartment= json['known_for_department'];
    popularity= json['popularity'];

  }
}