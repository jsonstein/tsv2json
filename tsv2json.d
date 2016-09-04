import std.string;
import std.stdio;
import std.array;

string oneRecord( string[] someTokens, string[] someHeaders ) {
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

string[] cleanHeaders( string aLine ) {
  string[] theseHeaders = aLine.split( "\t" );
  for( int i=0; i<theseHeaders.length; i++ ) {
    theseHeaders[ i ] = replace( theseHeaders[ i ], "\"", " " );
    theseHeaders[ i ] = replace( theseHeaders[ i ], " ", "_" );
  }
  return theseHeaders;
}

void main( string[] args ) {
  if ( args.length > 1 ) {
    stderr.writeln( "Usage: tsv2json" );
    stderr.writeln( "       reads a tsv file from stdin and writes a json file to stdout" );
    stderr.writeln( "       at the moment it just assumes there is a header record to use as JSON keys" );
  }
  else {
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
      writef( "%s", oneRecord( line.split( "\t" ), myHeaders ) );
      firstOne = false;
    }
    writef( "]" );
  }
}
