import std.string;
import std.stdio;
import std.net.curl;

enum string requestPrefix = "https://api.open.fec.gov/v1/candidates/search/?api_key=";
enum string apiKey = "yourAPIkeyHere";
enum string searchFieldName = "&name=";
enum string requestPartTwo = "&sort=name&per_page=20&page=1";

// from https://gist.github.com/alphaKAI/9681145
import std.array;
import std.format;
string urlencode( string text ){
  string array[];
  array.length = text.length;
  string hexconv(T)(T s){
    auto t = appender!string();
    formattedWrite( t, "%x", s );
    return '%' ~ t.data;
  }
  foreach( i, charc; text ) {
    array[ i ] = hexconv( charc );
  }
  return array.join();
}

void usageOutput( string programName ) {
  stderr.writeln( "usage:   " ~ programName ~ " nameForSearch" );
  stderr.writeln( "         searches FEC candidates data by (possibly url-encoded) name" );
  stderr.writeln( "example: " ~ programName ~ " \"TRUMP, DONALD J.\"" );
}

void printOutput( string forWhom ) {
  write( get( requestPrefix ~ apiKey ~ searchFieldName ~ urlencode( forWhom ) ~ requestPartTwo ) );
}

void main( string[] args ) {
  if( args.length != 2 ) {
    usageOutput( args[ 0 ] );
  }
  else {
    printOutput( args[ 1 ] );
  }
}
