# Command line TSV &amp; JSON Conversion and Manipulation Utilities in D

## Synopsis

Experiments with command line programs for streams processing in the D programming language, particularly focusing on TSV and stringified-JSON formats. note that these are Unixoid tools: reading their inputs from STDIN, writing their outputs to STDOUT, and writing usage and error messages to STDERR.

## Code Examples

tsv2json [-c | --compact]

      reads a tsv file from stdin and writes a json file to stdout

      assumes there is a header record to use as JSON keys

byCandidateName nameForSearch

      searches FEC candidates data by (possibly url-encoded) name
      and writes json file to stdout

      example: byCandidateName &quot;TRUMP, DONALD J.&quot;

memberInfo.sh twitterUserHandle listname

      uses [t](https://github.com/sferik/t) to get users who are members of a particular list, then <a href="https://github.com/eBay/tsv-utils-dlang" title="tsv utilities">csv2tsv</a> to pre-process into tsv, and finally **tsv2json** to produce output as reasonably-compact stringified-JSON.

## Motivation

### why streams?

there is an incredible amount of data which can usefully be thought of as a stream, and properly-written streams-processing programs can take arbitrarily-large data files as input... no more Mister Memory-Constrained for processing data.

### why JSON?

because I am largely a *Webbish* sorta person when it comes to communications,
and JSON-form data is useful and fast and easy to work with in a browser context.

## why CSV and TSV?

csv, because of all the

> rant removed because of the number of people it would offend

data capture that happens into spreadsheet form, often just because
all they have is a hammer and everydamnedthing looks like a nail

> another rant removed for the same reasons

and tsv because it is easier to work with to sanitize out all the cruft
the Multiverse guarantees will show up

> third and final rant redacted, writer cut off

## Installation



## API Reference

## Tests

## Contributors

<a href="mailto:jsonstein_at_gmail_dot_com?Subject=tsv2json_Page" title="email me">Prof. Jeffrey Sonstein</a>

## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
