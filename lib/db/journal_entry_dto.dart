
class JournalEntryDTO {
  String title;
  String body;
  String date;
  int rating;

  JournalEntryDTO({required this.title, required this.body, required this.date, required this.rating});

  String toString() {
    return 'Title: $title, Body: $body, Time: $date, Rating: $rating';
  }

}