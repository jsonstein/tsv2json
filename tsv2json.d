import std.string;
import std.stdio;
import std.array;

string oneRecord( string[] someTokens, string[] someHeaders ) {
  string thisRecord = "{";
  string foo;
  auto thisLength = someTokens.length;
  for( int i=0; i<(thisLength-1); i++ ) {
    foo = replace( someTokens[ i ], "\"", " " );
    thisRecord = thisRecord ~ "\"" ~ someHeaders[i] ~ "\": \"" ~ foo ~ "\",";
  }
  foo = replace( someTokens[ thisLength-1 ], "\"", " " );
  thisRecord = thisRecord ~ "\"" ~ someHeaders[thisLength-1] ~ "\": \"" ~ foo ~ "\"}";
  return thisRecord;
}

string[] cleanHeaders( string aLine ) {
  string[] theseHeaders = aLine.split( "\t" );
  for( int i=0; i<theseHeaders.length; i++ ) {
    theseHeaders[ i ] = replace( theseHeaders[ i ], "\"", " " );
  }
  return theseHeaders;
}

void main( string[] args ) {
  if ( args.length > 1 ) {
    stderr.writef( "%s", "Usage: tsv2json\n\nreads a tsv file from stdin and writes a json file to stdout" );
    stderr.writef( "%s", "at the moment it just assumes there is a header record with reasonable JSON keys" );
  }
  string line;
  // get the headers
  readf(" %s\n ", &line);
  string[] myHeaders = cleanHeaders( line );
  writef( "[" ); // start array
  bool firstOne = true;
  while ( (readf(" %s\n ", &line)) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    firstOne = false;
    writef( "%s", oneRecord( line.split( "\t" ), myHeaders ) );
  }
  writef( "]" );
}
