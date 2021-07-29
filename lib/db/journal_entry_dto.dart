
class JournalEntryDTO {
  String title;
  String body;
  String date;
  int rating;

  JournalEntryDTO({this.title, this.body, this.date, this.rating});

  String toString() {
    return 'Title: $title, Body: $body, Time: $date, Rating: $rating';
  }

}