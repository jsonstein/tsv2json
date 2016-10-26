/*
  modified from code at http://dpaste.dzfl.pl/bcb14d6aang
*/

import std.json, std.stdio, std.range, std.file, std.string, std.algorithm;

void recurse( JSONValue j, string indent="", string name="") {
	assert( indent.length <= 100 ); // recursion guard: >50 levels deep means there is danger
	if( name.length ) {
		write( indent, name, ": " );
	}
	else {
		write(indent);
	}
	if( j.type == std.json.JSON_TYPE.STRING ) {
		writeln( "(string): ", j.str );
	}
	else if( j.type == std.json.JSON_TYPE.INTEGER ) {
		writeln( "(int): ", j.integer );
	}
	else if( j.type == std.json.JSON_TYPE.UINTEGER ) {
		writeln( "(uint): ", j.uinteger );
	}
	else if( j.type == std.json.JSON_TYPE.FLOAT ) {
		writeln( "(float): ", j.floating );
	}
	else if( j.type == std.json.JSON_TYPE.OBJECT ) {
		writeln( "(object): {" );
		indent = indent ~ "  ";
		foreach( key, val; j.object ) {
			recurse(val, indent, key);
		}
		indent.popBackN( 2 );
		writeln( indent, "}" );
	}
	else if( j.type == std.json.JSON_TYPE.ARRAY ) {
		writeln( "(array): [" );
		indent = indent ~ "  ";
		foreach( val; j.array ) {
			recurse( val, indent );
		}
		indent.popBackN( 2 );
		writeln( indent, "]" );
	}
}

void usageMessage( string programName ) {
	stderr.writeln( "Usage: " ~ programName ~ " somefile.json" );
	stderr.writeln( "       or" );
	stderr.writeln( "      " ~ programName ~ " < somefile.json" );
}

void main( string[] args ) {
	if( args.length == 1 ) { // get from stdin
		string bigassJsonString;
		readf( "%s", &bigassJsonString );
		recurse( parseJSON( bigassJsonString ) );
  }
  else if( args.length == 2 ) {
    if( args[ 1 ].startsWith( "-" ) ) { // first check for dash argument
      usageMessage( args[ 0 ] );
    }
    else {  // else must be a filename
      recurse( parseJSON( readText( args[ 1 ] ) ) );
    }
  }
  else {  // too many arguments
    usageMessage( args[ 0 ] );
  }
}
