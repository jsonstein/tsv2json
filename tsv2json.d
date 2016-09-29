import std.string;
import std.stdio;

string stdRecord( string[] someTokens, string[] someHeaders ) {
  string thisRecord = "{";
  auto thisLength = someTokens.length;
  foreach( int i, string aToken; someTokens ) {
    thisRecord = thisRecord ~ "\"" ~ someHeaders[ i ] ~ "\":\"" ~ aToken.replace( "\"", " " ) ~ "\"";
    if( i < ( thisLength - 1 ) ) {
      thisRecord = thisRecord ~ ",";
    }
  }
  thisRecord = thisRecord ~ "}";
  return thisRecord;
}

string compactRecord( string[] someTokens ) {
  string thisRecord = "[";
  auto thisLength = someTokens.length;
  foreach( int i, string thisToken; someTokens ) {
    thisRecord = thisRecord ~ "\"" ~ thisToken.replace( "\"", " " ) ~ "\"";
    if( i < ( thisLength - 1 ) ) {
      thisRecord = thisRecord ~ ",";
    }
  }
  thisRecord = thisRecord ~ "]";
  return thisRecord;
}

string[] cleanHeaders( string aLine ) {
  string[] theseHeaders = aLine.split( "\t" );
  foreach( int i, string aHeader; theseHeaders ) {
    theseHeaders[ i ] = aHeader.replace( "\"", " " ).replace( " ", "_" );
  }
  return theseHeaders;
}

void stdOutput() {
  string line;
  readf( " %s\n", &line ); // get the headers
  string[] myHeaders = cleanHeaders( line );  // now kill some cruft
  writef( "[" ); // start output array
  bool firstOne = true;
  while ( ( readf( " %s\n", &line ) ) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    writef( "%s", stdRecord( line.split( "\t" ), myHeaders ) );  // one record at a time
    firstOne = false;
  }
  writef( "]" ); // and close off writing the output array
}

void compactOutput() {
  string line;
  readf( " %s\n", &line );  // get the headers
  string[] myHeaders = cleanHeaders( line );  // now kill some cruft
  writef( "[{\"headers\":[" ); // start writing with headers array
  auto thisLength = myHeaders.length;
  foreach( int counter, string oneHeader; myHeaders ) {
    writef( "\"" ~ oneHeader ~"\"" );
    if( counter < ( thisLength - 1 ) ) {
      writef( ",");
    }
  }
  writef( "],\"records\":[" ); // and then add records arrays
  bool firstOne = true;
  while ( ( readf( " %s\n", &line ) ) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    writef( "%s", compactRecord( line.split( "\t" ) ) ); // one record at a time
    firstOne = false;
  }
  writef( "]}]" ); // and close off writing the object
}

void usageOutput( string programName ) {
  stderr.writeln( "Usage: " ~ programName ~ " [-c | --compact]" );
  stderr.writeln( "       reads a tsv file from stdin and writes a json file to stdout" );
  stderr.writeln( "       assumes there is an inital header record to use as JSON keys" );
}

void main( string[] args ) {
  if( args.length == 1 ) {
    stdOutput();
  }
  else if( args.length == 2 ) {
    if( (args[ 1 ] == "-c") || (args[ 1 ] == "--compact") ) {
      compactOutput();
    }
    else {
      usageOutput( args[ 0 ] );
    }
  }
  else if( args.length > 2 ) {
    usageOutput( args[ 0 ] );
  }
}
