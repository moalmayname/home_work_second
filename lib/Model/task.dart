//final String tableNotes = 'notes';

//class NoteFields {
  //static final List<String> values = [
    /// Add all fields
    //id, isImportant, number, title, description, time
  //];

  //static final String id = '_id';
  //static final String isImportant = 'isImportant';
  //static final String number = 'number';
  //static final String title = 'title';
  //static final String description = 'description';
  //static final String time = 'time';
//}

class Task {
   int? id;
   String? title ;
   String? note;
   int? isComplited ;
  String? date;
   String? startTime;
   String? endTime;
   int? color;
   int? reminder;
   String? repeat;

 Task({
     this.id,
   this.title,
   this.note,
   this.isComplited,
   this.date,
   this.startTime,
   this.endTime,
   this.color,
   this.reminder,
     this.repeat,

});
 Task.fromjson(Map<String,dynamic> json ) {
   id =json          ['id'];
   title =json      ['title'];
   note = json        ['note'];
   isComplited= json [' isComplited'];
   date =json         ['date'];
   startTime = json   ['startTime'];
   endTime = json   ['endTime'];
   color = json    ['color'];
   reminder = json    ['reminder'];
   repeat = json      ['repeat'];


   }

//  Task copy({
  //  int? id,
    //bool? isImportant,
    //int? number,
    //String? title,
    //String? description,
    //DateTime? createdTime,
  //}) =>
    //  Task(
      //  id: id ?? this.id,
        //isImportant: isImportant ?? this.isImportant,
        //number: number ?? this.number,
        //title: title ?? this.title,
        //description: description ?? this.description,
        //createdTime: createdTime ?? this.createdTime,
      //);

  //static Note fromJson(Map<String, Object?> json) => Note(
    //id: json[NoteFields.id] as int?,
    //isImportant: json[NoteFields.isImportant] == 1,
    //number: json[NoteFields.number] as int,
    //title: json[NoteFields.title] as String,
    //description: json[NoteFields.description] as String,
    //createdTime: DateTime.parse(json[NoteFields.time] as String),
  //);

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> data= new Map<String,dynamic>();
   data['id']= this.id;
   data['title']= this.title;
    data['note']= this.note;
   data['date']= this.date;
   data ['startTime']= this.startTime;

   data['endTime']= this.endTime;


   data['isComplited']=this.isComplited;
   data['color']=this.color;
   data['reminder']=this.reminder;
   data['repeat']=this.repeat;
    return data;
  }
}
