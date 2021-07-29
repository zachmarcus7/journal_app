import 'package:journal/db/journal_entry_dto.dart';


class Journal {

  List<JournalEntryDTO> entries;

  Journal({this.entries}); 

  bool isEmpty() {
    if (entries.length == 0)
      return true;
    return false;
  }

}