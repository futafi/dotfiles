#!/usr/bin/env perl
@default_files = ('parents.tex');
$latex        = 'uplatex -synctex=1';
$latex_silent = 'uplatex -synctex=1 -interaction=batchmode';
$bibtex       = 'upbibtex';
$biber        = 'biber --bblencoding=utf8 -u -U --output_safechars';
$dvipdf       = 'dvipdfmx -z9 -V 4 %O -o %D %S';
$makeindex    = 'mendex %O -o %D %S';
$max_repeat   = 5;
$pdf_mode	  = 3;
$clean_ext   = 'aux dvi fdb_latexmk fls log synctex.gz tex.bak';
$pvc_view_file_via_temporary = 0;
