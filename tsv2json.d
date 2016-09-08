import std.string;
import std.stdio;

string stdRecord( string[] someTokens, string[] someHeaders ) {
  string thisRecord = "{";
  string thisData;
  auto thisLength = someTokens.length;
  for( int i=0; i<(thisLength-1); i++ ) {
    thisData = replace( someTokens[ i ], "\"", " " );
    thisRecord = thisRecord ~ "\"" ~ someHeaders[i] ~ "\": \"" ~ thisData ~ "\",";
  }
  thisData = replace( someTokens[ thisLength-1 ], "\"", " " );
  thisRecord = thisRecord ~ "\"" ~ someHeaders[thisLength-1] ~ "\": \"" ~ thisData ~ "\"}";
  return thisRecord;
}

string compactRecord( string[] someTokens ) {
  string thisRecord = "[";
  auto thisLength = someTokens.length;
  foreach( int i, string thisToken; someTokens ) {
    thisRecord = thisRecord ~ "\"" ~ replace( thisToken, "\"", " " ) ~ "\"";
    if( i < (thisLength -1) ) {
      thisRecord = thisRecord ~ ",";
    }
  }
  thisRecord = thisRecord ~ "]";
  return thisRecord;
}

string[] cleanHeaders( string aLine ) {
  string[] theseHeaders = aLine.split( "\t" );
  for( int i=0; i<theseHeaders.length; i++ ) {
    theseHeaders[ i ] = replace( theseHeaders[ i ], "\"", " " );
    theseHeaders[ i ] = replace( theseHeaders[ i ], " ", "_" );
  }
  return theseHeaders;
}

void stdOutput() {
  string line;
  // get the headers
  readf(" %s\n", &line);
  string[] myHeaders = cleanHeaders( line );
  writef( "[" ); // start output array
  bool firstOne = true;
  while ( (readf(" %s\n", &line)) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    writef( "%s", stdRecord( line.split( "\t" ), myHeaders ) );
    firstOne = false;
  }
  writef( "]" ); // end output array
}

void compactOutput() {
  string line;
  // get the headers
  readf(" %s\n", &line);
  string[] myHeaders = cleanHeaders( line );
  writef( "[{\"headers\":[" ); // start with headers array
  foreach( int counter, string oneHeader; myHeaders ) {
    writef( "\"" ~ oneHeader ~"\"" );
    if( counter < (myHeaders.length - 1) ) {
      writef( ",");
    }
  }
  writef( "],\"records\":["); // and then add records arrays
  bool firstOne = true;
  while ( (readf(" %s\n", &line)) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    writef( "%s", compactRecord( line.split( "\t" ) ) );
    firstOne = false;
  }
  writef( "]}]" ); // and close off the object
}

void usageOutput() {
  stderr.writeln( "Usage: tsv2json [-c | --compact]" );
  stderr.writeln( "       reads a tsv file from stdin and writes a json file to stdout" );
  stderr.writeln( "       assumes there is a header record to use as JSON keys" );
}

void main( string[] args ) {
  if( args.length == 1 ) {
    stdOutput();
  }
  else if( args.length == 2 ) {
    if( (args[1] == "-c") || (args[1] == "--compact") ) {
      compactOutput();
    }
    else {
      usageOutput();
    }
  }
  else if( args.length > 2 ) {
    usageOutput();
  }
}
