import std.string;
import std.stdio;
import std.array;

string[] myHeaders; // at this scope so we can reuse in output

string oneRecord( string[] someTokens ) {
  string thisRecord = "{";
  string foo;
  auto thisLength = someTokens.length;
  for( int i=0; i<(thisLength-1); i++ ) {
    foo = replace( someTokens[ i ], "\"", " " );
    thisRecord = thisRecord ~ "\"" ~ myHeaders[i] ~ "\": \"" ~ foo ~ "\",";
  }
  foo = replace( someTokens[ thisLength-1 ], "\"", " " );
  thisRecord = thisRecord ~ "\"" ~ myHeaders[thisLength-1] ~ "\": \"" ~ foo ~ "\"}";
  return thisRecord;
}

void main( string[] args ) {
  if ( args.length > 1 ) {
    stderr.writef( "%s", "Usage: tsv2json\n\nreads a tsv file from stdin and writes a json file to stdout" );
    stderr.writef( "%s", "at the moment it just assumes there is a header record with reasonable JSON keys" );
  }
  string line;
  // get the headers
  readf(" %s\n ", &line);
  myHeaders = line.split( "\t" );
  writef( "[" ); // start array
  bool firstOne = true;
  while ( (readf(" %s\n ", &line)) >= 1 ) { // at least 1 char returned
    if( !firstOne ) {
      writef( "," );
    }
    firstOne = false;
    writef( "%s", oneRecord( line.split( "\t" ) ) );
  }
  writef( "]" );
}
