<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>EmacsWiki: whitespace.el</title><link rel="alternate" type="application/wiki" title="Edit this page" href="http://www.emacswiki.org/emacs?action=edit;id=whitespace.el" />
<link type="text/css" rel="stylesheet" href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" />
<link type="text/css" rel="stylesheet" href="/css/bootstrap.css" />
<meta name="robots" content="INDEX,FOLLOW" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki" href="http://www.emacswiki.org/emacs?action=rss" /><link rel="alternate" type="application/rss+xml" title="EmacsWiki: whitespace.el" href="http://www.emacswiki.org/emacs?action=rss;rcidonly=whitespace.el" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content"
      href="http://www.emacswiki.org/full.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki with page content and diff"
      href="http://www.emacswiki.org/full-diff.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Emacs Wiki including minor differences"
      href="http://www.emacswiki.org/minor-edits.rss" />
<link rel="alternate" type="application/rss+xml"
      title="Changes for whitespace.el only"
      href="http://www.emacswiki.org/emacs?action=rss;rcidonly=whitespace.el" /><meta name="viewport" content="width=device-width" />
<script type="text/javascript" src="/outliner.0.5.0.62-toc.js"></script>
<script type="text/javascript">

  function addOnloadEvent(fnc) {
    if ( typeof window.addEventListener != "undefined" )
      window.addEventListener( "load", fnc, false );
    else if ( typeof window.attachEvent != "undefined" ) {
      window.attachEvent( "onload", fnc );
    }
    else {
      if ( window.onload != null ) {
	var oldOnload = window.onload;
	window.onload = function ( e ) {
	  oldOnload( e );
	  window[fnc]();
	};
      }
      else
	window.onload = fnc;
    }
  }

  // https://stackoverflow.com/questions/280634/endswith-in-javascript
  if (typeof String.prototype.endsWith !== 'function') {
    String.prototype.endsWith = function(suffix) {
      return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
  }

  var initToc=function() {

    var outline = HTML5Outline(document.body);
    if (outline.sections.length == 1) {
      outline.sections = outline.sections[0].sections;
    }

    if (outline.sections.length > 1
	|| outline.sections.length == 1
           && outline.sections[0].sections.length > 0) {

      var toc = document.getElementById('toc');

      if (!toc) {
	var divs = document.getElementsByTagName('div');
	for (var i = 0; i < divs.length; i++) {
	  if (divs[i].getAttribute('class') == 'toc') {
	    toc = divs[i];
	    break;
	  }
	}
      }

      if (!toc) {
	var h2 = document.getElementsByTagName('h2')[0];
	if (h2) {
	  toc = document.createElement('div');
	  toc.setAttribute('class', 'toc');
	  h2.parentNode.insertBefore(toc, h2);
	}
      }

      if (toc) {
        var html = outline.asHTML(true);
        toc.innerHTML = html;

	items = toc.getElementsByTagName('a');
	for (var i = 0; i < items.length; i++) {
	  while (items[i].textContent.endsWith('â')) {
            var text = items[i].childNodes[0].nodeValue;
	    items[i].childNodes[0].nodeValue = text.substring(0, text.length - 1);
	  }
	}
      }
    }
  }

  addOnloadEvent(initToc);
  </script>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://emacswiki.org/bootstrap.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head><body class="default"><div class="header"><div class="menu"><span class="gotobar bar"><a class="local" href="http://www.emacswiki.org/emacs/SiteMap">SiteMap</a> <a href="http://www.emacswiki.org/emacs/Search" class="local">Search</a> <a href="http://www.emacswiki.org/emacs/ElispArea" class="local">ElispArea</a> <a href="http://www.emacswiki.org/emacs/HowTo" class="local">HowTo</a> <a href="http://www.emacswiki.org/emacs/Glossary" class="local">Glossary</a> <a class="local" href="http://www.emacswiki.org/emacs/RecentChanges">RecentChanges</a> <a class="local" href="http://www.emacswiki.org/emacs/News">News</a> <a class="local" href="http://www.emacswiki.org/emacs/Problems">Problems</a> <a class="local" href="http://www.emacswiki.org/emacs/Suggestions">Suggestions</a> </span><form method="get" action="http://www.emacswiki.org/emacs" enctype="multipart/form-data" class="search" accept-charset="utf-8"><p><label for="search">Search:</label> <input type="text" name="search"  size="20" accesskey="f" id="search" /> <label for="searchlang">Language:</label> <input type="text" name="lang"  size="10" id="searchlang" /> <input type="submit" name="dosearch" value="Go!" /></p></form></div><h1><a rel="nofollow" title="Click to search for references to this page" href="http://www.emacswiki.org/emacs?search=%22whitespace%5c.el%22">whitespace.el</a></h1></div><div class="wrapper"><div class="content browse"><p class="download"><a href="http://www.emacswiki.org/emacs/download/whitespace.el">Download</a></p><pre><span class="comment">;;; whitespace.el --- minor mode to visualize TAB, (HARD) SPACE, NEWLINE</span>

<span class="comment">;; Copyright (C) 2000-2011  Free Software Foundation, Inc.</span>

<span class="comment">;; Author: Vinicius Jose Latorre &lt;viniciusjl@ig.com.br&gt;</span>
<span class="comment">;; Maintainer: Vinicius Jose Latorre &lt;viniciusjl@ig.com.br&gt;</span>
<span class="comment">;; Keywords: data, wp</span>
<span class="comment">;; Version: 13.2.2</span>
<span class="comment">;; X-URL: http<span class="builtin">://www</span>.emacswiki.org/cgi-bin/wiki/ViniciusJoseLatorre</span>

<span class="comment">;; This file is part of GNU Emacs.</span>

<span class="comment">;; GNU Emacs is free software: you can redistribute it and/or modify</span>
<span class="comment">;; it under the terms of the GNU General Public License as published by</span>
<span class="comment">;; the Free Software Foundation, either version 3 of the License, or</span>
<span class="comment">;; (at your option) any later version.</span>

<span class="comment">;; GNU Emacs is distributed in the hope that it will be useful,</span>
<span class="comment">;; but WITHOUT ANY WARRANTY; without even the implied warranty of</span>
<span class="comment">;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>
<span class="comment">;; GNU General Public License for more details.</span>

<span class="comment">;; You should have received a copy of the GNU General Public License</span>
<span class="comment">;; along with GNU Emacs.  If not, see &lt;http<span class="builtin">://www</span>.gnu.org/licenses/&gt;.</span>

<span class="comment">;;; Commentary<span class="builtin">:</span></span>

<span class="comment">;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;</span>
<span class="comment">;; Introduction</span>
<span class="comment">;; ------------</span>
<span class="comment">;;</span>
<span class="comment">;; This package is a minor mode to visualize blanks (TAB, (HARD) SPACE</span>
<span class="comment">;; and NEWLINE).</span>
<span class="comment">;;</span>
<span class="comment">;; whitespace uses two ways to visualize blanks: faces and display</span>
<span class="comment">;; table.</span>
<span class="comment">;;</span>
<span class="comment">;; * Faces are used to highlight the background with a color.</span>
<span class="comment">;;   whitespace uses font-lock to highlight blank characters.</span>
<span class="comment">;;</span>
<span class="comment">;; * Display table changes the way a character is displayed, that is,</span>
<span class="comment">;;   it provides a visual mark for characters, for example, at the end</span>
<span class="comment">;;   of line (?\xB6), at SPACEs (?\xB7) and at TABs (?\xBB).</span>
<span class="comment">;;</span>
<span class="comment">;; The `<span class="constant important">whitespace-style</span>' variable selects which way blanks are</span>
<span class="comment">;; visualized.</span>
<span class="comment">;;</span>
<span class="comment">;; Note that when whitespace is turned on, whitespace saves the</span>
<span class="comment">;; font-lock state, that is, if font-lock is on or off.  And</span>
<span class="comment">;; whitespace restores the font-lock state when it is turned off.  So,</span>
<span class="comment">;; if whitespace is turned on and font-lock is off, whitespace also</span>
<span class="comment">;; turns on the font-lock to highlight blanks, but the font-lock will</span>
<span class="comment">;; be turned off when whitespace is turned off.  Thus, turn on</span>
<span class="comment">;; font-lock before whitespace is on, if you want that font-lock</span>
<span class="comment">;; continues on after whitespace is turned off.</span>
<span class="comment">;;</span>
<span class="comment">;; When whitespace is on, it takes care of highlighting some special</span>
<span class="comment">;; characters over the default mechanism of `<span class="constant important">nobreak-char-display</span>'</span>
<span class="comment">;; (which see) and `<span class="constant important">show-trailing-whitespace</span>' (which see).</span>
<span class="comment">;;</span>
<span class="comment">;; The trailing spaces are not highlighted while point is at end of line.</span>
<span class="comment">;; Also the spaces at beginning of buffer are not highlighted while point is at</span>
<span class="comment">;; beginning of buffer; and the spaces at end of buffer are not highlighted</span>
<span class="comment">;; while point is at end of buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; There are two ways of using whitespace: local and global.</span>
<span class="comment">;;</span>
<span class="comment">;; * Local whitespace affects only the current buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; * Global whitespace affects all current and future buffers.  That</span>
<span class="comment">;;   is, if you turn on global whitespace and then create a new</span>
<span class="comment">;;   buffer, the new buffer will also have whitespace on.  The</span>
<span class="comment">;;   `<span class="constant important">whitespace-global-modes</span>' variable controls which major-mode will</span>
<span class="comment">;;   be automagically turned on.</span>
<span class="comment">;;</span>
<span class="comment">;; You can mix the local and global usage without any conflict.  But</span>
<span class="comment">;; local whitespace has priority over global whitespace.  Whitespace</span>
<span class="comment">;; mode is active in a buffer if you have enabled it in that buffer or</span>
<span class="comment">;; if you have enabled it globally.</span>
<span class="comment">;;</span>
<span class="comment">;; When global and local whitespace are on<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;; * if local whitespace is turned off, whitespace is turned off for</span>
<span class="comment">;;   the current buffer only.</span>
<span class="comment">;;</span>
<span class="comment">;; * if global whitespace is turned off, whitespace continues on only</span>
<span class="comment">;;   in the buffers in which local whitespace is on.</span>
<span class="comment">;;</span>
<span class="comment">;; To use whitespace, insert in your ~/.emacs<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;    (<span class="keyword">require</span> '<span class="constant">whitespace</span>)</span>
<span class="comment">;;</span>
<span class="comment">;; Or autoload at least one of the commands`<span class="constant important">whitespace-mode</span>',</span>
<span class="comment">;; `<span class="constant important">whitespace-toggle-options</span>', `<span class="constant important">global-whitespace-mode</span>' or</span>
<span class="comment">;; `<span class="constant important">global-whitespace-toggle-options</span>'.  For example<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;    (autoload 'whitespace-mode           <span class="string">"whitespace"</span></span>
<span class="comment">;;      <span class="string">"Toggle whitespace visualization."</span>        t)</span>
<span class="comment">;;    (autoload 'whitespace-toggle-options <span class="string">"whitespace"</span></span>
<span class="comment">;;      <span class="string">"Toggle local `<span class="constant important">whitespace-mode</span>' options."</span> t)</span>
<span class="comment">;;</span>
<span class="comment">;; whitespace was inspired by<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;    whitespace.el            Rajesh Vaidheeswarran &lt;rv@gnu.org&gt;</span>
<span class="comment">;;	Warn about and clean bogus whitespaces in the file</span>
<span class="comment">;;	(inspired the idea to warn and clean some blanks)</span>
<span class="comment">;;	This was the original `whitespace.el' which was replaced by</span>
<span class="comment">;;	`blank-mode.el'.  And later `blank-mode.el' was renamed to</span>
<span class="comment">;;	`whitespace.el'.</span>
<span class="comment">;;</span>
<span class="comment">;;    show-whitespace-mode.el  Aurelien Tisne &lt;aurelien.tisne@free.fr&gt;</span>
<span class="comment">;;       Simple mode to highlight whitespaces</span>
<span class="comment">;;       (inspired the idea to use font-lock)</span>
<span class="comment">;;</span>
<span class="comment">;;    whitespace-mode.el       Lawrence Mitchell &lt;wence@gmx.li&gt;</span>
<span class="comment">;;       Major mode for editing Whitespace</span>
<span class="comment">;;       (inspired the idea to use display table)</span>
<span class="comment">;;</span>
<span class="comment">;;    visws.el                 Miles Bader &lt;miles@gnu.org&gt;</span>
<span class="comment">;;       Make whitespace visible</span>
<span class="comment">;;       (handle display table, his code was modified, but the main</span>
<span class="comment">;;       idea was kept)</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;; Using whitespace</span>
<span class="comment">;; ----------------</span>
<span class="comment">;;</span>
<span class="comment">;; There is no problem if you mix local and global minor mode usage.</span>
<span class="comment">;;</span>
<span class="comment">;; * LOCAL whitespace<span class="builtin">:</span></span>
<span class="comment">;;    + To toggle whitespace options locally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         M-x whitespace-toggle-options RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To activate whitespace locally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         C-u 1 M-x whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To deactivate whitespace locally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         C-u 0 M-x whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To toggle whitespace locally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         M-x whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;; * GLOBAL whitespace<span class="builtin">:</span></span>
<span class="comment">;;    + To toggle whitespace options globally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         M-x global-whitespace-toggle-options RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To activate whitespace globally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         C-u 1 M-x global-whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To deactivate whitespace globally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         C-u 0 M-x global-whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;;    + To toggle whitespace globally, type<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;;         M-x global-whitespace-mode RET</span>
<span class="comment">;;</span>
<span class="comment">;; There are also the following useful commands<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-newline-mode</span>'</span>
<span class="comment">;;    Toggle NEWLINE minor mode visualization (<span class="string">"nl"</span> on modeline).</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">global-whitespace-newline-mode</span>'</span>
<span class="comment">;;    Toggle NEWLINE global minor mode visualization (<span class="string">"NL"</span> on modeline).</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-report</span>'</span>
<span class="comment">;;    Report some blank problems in buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-report-region</span>'</span>
<span class="comment">;;    Report some blank problems in a region.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-cleanup</span>'</span>
<span class="comment">;;    Cleanup some blank problems in all buffer or at region.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-cleanup-region</span>'</span>
<span class="comment">;;    Cleanup some blank problems at region.</span>
<span class="comment">;;</span>
<span class="comment">;; The problems, which are cleaned up, are<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;; 1. empty lines at beginning of buffer.</span>
<span class="comment">;; 2. empty lines at end of buffer.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">empty</span>', remove all</span>
<span class="comment">;;    empty lines at beginning and/or end of buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; 3. 8 or more SPACEs at beginning of line.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation</span>'<span class="builtin">:</span></span>
<span class="comment">;;    replace 8 or more SPACEs at beginning of line by TABs, if</span>
<span class="comment">;;    `<span class="constant important">indent-tabs-mode</span>' is non-nil; otherwise, replace TABs by</span>
<span class="comment">;;    SPACEs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::tab</span></span>',</span>
<span class="comment">;;    replace 8 or more SPACEs at beginning of line by TABs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::space</span></span>',</span>
<span class="comment">;;    replace TABs by SPACEs.</span>
<span class="comment">;;</span>
<span class="comment">;; 4. SPACEs before TAB.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-before-tab</span>'<span class="builtin">:</span></span>
<span class="comment">;;    replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil;</span>
<span class="comment">;;    otherwise, replace TABs by SPACEs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value</span>
<span class="comment">;;    `<span class="constant important">space-before-tab<span class="builtin">::tab</span></span>', replace SPACEs by TABs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value</span>
<span class="comment">;;    `<span class="constant important">space-before-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.</span>
<span class="comment">;;</span>
<span class="comment">;; 5. SPACEs or TABs at end of line.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">trailing</span>', remove all</span>
<span class="comment">;;    SPACEs or TABs at end of line.</span>
<span class="comment">;;</span>
<span class="comment">;; 6. 8 or more SPACEs after TAB.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-after-tab</span>'<span class="builtin">:</span></span>
<span class="comment">;;    replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil;</span>
<span class="comment">;;    otherwise, replace TABs by SPACEs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-after-tab<span class="builtin">::tab</span></span>',</span>
<span class="comment">;;    replace SPACEs by TABs.</span>
<span class="comment">;;    If `<span class="constant important">whitespace-style</span>' includes the value</span>
<span class="comment">;;    `<span class="constant important">space-after-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;; Hooks</span>
<span class="comment">;; -----</span>
<span class="comment">;;</span>
<span class="comment">;; whitespace has the following hook variables<span class="builtin">:</span></span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-mode-hook</span>'</span>
<span class="comment">;;    It is evaluated always when whitespace is turned on locally.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">global-whitespace-mode-hook</span>'</span>
<span class="comment">;;    It is evaluated always when whitespace is turned on globally.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-load-hook</span>'</span>
<span class="comment">;;    It is evaluated after whitespace package is loaded.</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;; Options</span>
<span class="comment">;; -------</span>
<span class="comment">;;</span>
<span class="comment">;; Below it's shown a brief description of whitespace options, please,</span>
<span class="comment">;; see the options declaration in the code for a long documentation.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-style</span>'		Specify which kind of blank is</span>
<span class="comment">;;				visualized.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space</span>'		Face used to visualize SPACE.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-hspace</span>'		Face used to visualize HARD SPACE.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-tab</span>'		Face used to visualize TAB.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-newline</span>'		Face used to visualize NEWLINE char</span>
<span class="comment">;;				mapping.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-trailing</span>'	Face used to visualize trailing</span>
<span class="comment">;;				blanks.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-line</span>'		Face used to visualize <span class="string">"long"</span> lines.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space-before-tab</span>'	Face used to visualize SPACEs</span>
<span class="comment">;;					before TAB.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-indentation</span>'	Face used to visualize 8 or more</span>
<span class="comment">;;				SPACEs at beginning of line.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-empty</span>'		Face used to visualize empty lines at</span>
<span class="comment">;;				beginning and/or end of buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space-after-tab</span>'	Face used to visualize 8 or more</span>
<span class="comment">;;				SPACEs after TAB.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space-regexp</span>'	Specify SPACE characters regexp.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-hspace-regexp</span>'	Specify HARD SPACE characters regexp.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-tab-regexp</span>'	Specify TAB characters regexp.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-trailing-regexp</span>'	Specify trailing characters regexp.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space-before-tab-regexp</span>'	Specify SPACEs before TAB</span>
<span class="comment">;;					regexp.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-indentation-regexp</span>'	Specify regexp for 8 or more</span>
<span class="comment">;;					SPACEs at beginning of line.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-empty-at-bob-regexp</span>'	Specify regexp for empty lines</span>
<span class="comment">;;					at beginning of buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-empty-at-eob-regexp</span>'	Specify regexp for empty lines</span>
<span class="comment">;;					at end of buffer.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-space-after-tab-regexp</span>'	Specify regexp for 8 or more</span>
<span class="comment">;;					SPACEs after TAB.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-line-column</span>'	Specify column beyond which the line</span>
<span class="comment">;;				is highlighted.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-display-mappings</span>'	Specify an alist of mappings</span>
<span class="comment">;;					for displaying characters.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-global-modes</span>'	Modes for which global</span>
<span class="comment">;;				`<span class="constant important">whitespace-mode</span>' is automagically</span>
<span class="comment">;;				turned on.</span>
<span class="comment">;;</span>
<span class="comment">;; `<span class="constant important">whitespace-action</span>'		Specify which action is taken when a</span>
<span class="comment">;;				buffer is visited or written.</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;; Acknowledgements</span>
<span class="comment">;; ----------------</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to felix (EmacsWiki) for keeping highlight when switching between</span>
<span class="comment">;; major modes on a file.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to David Reitter &lt;david.reitter@gmail.com&gt; for suggesting a</span>
<span class="comment">;; `<span class="constant important">whitespace-newline</span>' initialization with low contrast relative to</span>
<span class="comment">;; the background color.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Stephen Deasey &lt;sdeasey@gmail.com&gt; for the</span>
<span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' usage suggestion.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Eric Cooper &lt;ecc@cmu.edu&gt; for the suggestion to have hook</span>
<span class="comment">;; actions when buffer is written as the original whitespace package</span>
<span class="comment">;; had.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to nschum (EmacsWiki) for the idea about highlight <span class="string">"long"</span></span>
<span class="comment">;; lines tail.  See EightyColumnRule (EmacsWiki).</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Juri Linkov &lt;juri@jurta.org&gt; for suggesting<span class="builtin">:</span></span>
<span class="comment">;;    * `<span class="constant important">define-minor-mode</span>'.</span>
<span class="comment">;;    * `<span class="constant important">global-whitespace-*</span>' name for global commands.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Robert J. Chassell &lt;bob@gnu.org&gt; for doc fix and testing.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Drew Adams &lt;drew.adams@oracle.com&gt; for toggle commands</span>
<span class="comment">;; suggestion.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Antti Kaihola &lt;antti.kaihola@linux-aktivaattori.org&gt; for</span>
<span class="comment">;; helping to fix `<span class="constant important">find-file-hooks</span>' reference.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Andreas Roehler &lt;andreas.roehler@easy-emacs.de&gt; for</span>
<span class="comment">;; indicating defface byte-compilation warnings.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to TimOCallaghan (EmacsWiki) for the idea about highlight</span>
<span class="comment">;; <span class="string">"long"</span> lines.  See EightyColumnRule (EmacsWiki).</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Yanghui Bian &lt;yanghuibian@gmail.com&gt; for indicating a new</span>
<span class="comment">;; NEWLINE character mapping.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Pete Forman &lt;pete.forman@westgeo.com&gt; for indicating</span>
<span class="comment">;; whitespace-mode.el on XEmacs.</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to Miles Bader &lt;miles@gnu.org&gt; for handling display table via</span>
<span class="comment">;; visws.el (his code was modified, but the main idea was kept).</span>
<span class="comment">;;</span>
<span class="comment">;; Thanks to<span class="builtin">:</span></span>
<span class="comment">;;    Rajesh Vaidheeswarran &lt;rv@gnu.org&gt;	(original) whitespace.el</span>
<span class="comment">;;    Aurelien Tisne &lt;aurelien.tisne@free.fr&gt;	show-whitespace-mode.el</span>
<span class="comment">;;    Lawrence Mitchell &lt;wence@gmx.li&gt;		whitespace-mode.el</span>
<span class="comment">;;    Miles Bader &lt;miles@gnu.org&gt;		visws.el</span>
<span class="comment">;; And to all people who contributed with them.</span>
<span class="comment">;;</span>
<span class="comment">;;</span>
<span class="comment">;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>

<span class="comment">;;; code<span class="builtin">:</span></span>


(<span class="keyword elisp">eval-and-compile</span>
  (<span class="keyword cl">unless</span> (fboundp 'with-current-buffer)
    <span class="comment">;; from `subr.el' (Emacs 23)</span>
    (<span class="keyword">defmacro</span> <span class="function">with-current-buffer</span> (buffer-or-name <span class="type">&amp;rest</span> body)
      <span class="string">"Execute the forms in BODY with BUFFER-OR-NAME temporarily current.
BUFFER-OR-NAME must be a buffer or the name of an existing buffer.
The value returned is the value of the last form in BODY.  See
also `<span class="constant important">with-temp-buffer</span>'."</span>
      (<span class="keyword cl">declare</span> (indent 1) (debug t))
      `(<span class="keyword elisp">save-current-buffer</span>
	 (set-buffer ,buffer-or-name)
	 ,@body))))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User Variables<span class="builtin">:</span></span>


<span class="comment">;;; Interface to the command system</span>


(<span class="keyword">defgroup</span> <span class="type">whitespace</span> nil
  <span class="string">"Visualize blanks (TAB, (HARD) SPACE and NEWLINE)."</span>
  <span class="builtin">:link</span> '(emacs-library-link <span class="builtin">:tag</span> <span class="string">"Source Lisp File"</span> <span class="string">"whitespace.el"</span>)
  <span class="builtin">:version</span> <span class="string">"23.1"</span>
  <span class="builtin">:group</span> 'convenience)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-style</span>
  '(face
    tabs spaces trailing lines space-before-tab newline
    indentation empty space-after-tab
    space-mark tab-mark newline-mark)
  <span class="string">"Specify which kind of blank is visualized.

It's a list containing some or all of the following values:

   face			enable all visualization via faces (see below).

   trailing		trailing blanks are visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   tabs			TABs are visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   spaces		SPACEs and HARD SPACEs are visualized via
			faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   lines		lines which have columns beyond
			`<span class="constant important">whitespace-line-column</span>' are highlighted via
			faces.
			Whole line is highlighted.
			It has precedence over `<span class="constant important">lines-tail</span>' (see
			below).
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   lines-tail		lines which have columns beyond
			`<span class="constant important">whitespace-line-column</span>' are highlighted via
			faces.
			But only the part of line which goes
			beyond `<span class="constant important">whitespace-line-column</span>' column.
			It has effect only if `<span class="constant important">lines</span>' (see above)
			is not present in `<span class="constant important">whitespace-style</span>'
			and if `<span class="constant important">face</span>' (see above) is present in
			`<span class="constant important">whitespace-style</span>'.

   newline		NEWLINEs are visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   empty		empty lines at beginning and/or end of buffer
			are visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   indentation<span class="builtin">::tab</span>	8 or more SPACEs at beginning of line are
			visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   indentation<span class="builtin">::space</span>	TABs at beginning of line are visualized via
			faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   indentation		8 or more SPACEs at beginning of line are
			visualized, if `<span class="constant important">indent-tabs-mode</span>' (which see)
			is non-nil<span class="comment">; otherwise, TABs at beginning of</span>
			line are visualized via faces.
			It has effect only if `<span class="constant important">face</span>' (see above)
			is present in `<span class="constant important">whitespace-style</span>'.

   space-after-tab<span class="builtin">::tab</span>		8 or more SPACEs after a TAB are
				visualized via faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-after-tab<span class="builtin">::space</span>	TABs are visualized when 8 or more
				SPACEs occur after a TAB, via faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-after-tab		8 or more SPACEs after a TAB are
				visualized, if `<span class="constant important">indent-tabs-mode</span>'
				(which see) is non-nil<span class="comment">; otherwise,</span>
				the TABs are visualized via faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-before-tab<span class="builtin">::tab</span>	SPACEs before TAB are visualized via
				faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-before-tab<span class="builtin">::space</span>	TABs are visualized when SPACEs occur
				before TAB, via faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-before-tab		SPACEs before TAB are visualized, if
				`<span class="constant important">indent-tabs-mode</span>' (which see) is
				non-nil<span class="comment">; otherwise, the TABs are</span>
				visualized via faces.
				It has effect only if `<span class="constant important">face</span>' (see above)
				is present in `<span class="constant important">whitespace-style</span>'.

   space-mark		SPACEs and HARD SPACEs are visualized via
			display table.

   tab-mark		TABs are visualized via display table.

   newline-mark		NEWLINEs are visualized via display table.

Any other value is ignored.

If nil, don't visualize TABs, (HARD) SPACEs and NEWLINEs via faces and
via display table.

There is an evaluation order for some values, if they are
included in `<span class="constant important">whitespace-style</span>' list.  For example, if
indentation, indentation<span class="builtin">::tab</span> and/or indentation<span class="builtin">::space</span> are
included in `<span class="constant important">whitespace-style</span>' list.  The evaluation order for
these values is:

 * For indentation:
   1. indentation
   2. indentation<span class="builtin">::tab</span>
   3. indentation<span class="builtin">::space</span>

 * For SPACEs after TABs:
   1. space-after-tab
   2. space-after-tab<span class="builtin">::tab</span>
   3. space-after-tab<span class="builtin">::space</span>

 * For SPACEs before TABs:
   1. space-before-tab
   2. space-before-tab<span class="builtin">::tab</span>
   3. space-before-tab<span class="builtin">::space</span>

So, for example, if indentation and indentation<span class="builtin">::space</span> are
included in `<span class="constant important">whitespace-style</span>' list, the indentation value is
evaluated instead of indentation<span class="builtin">::space</span> value.

One reason for not visualize spaces via faces (<span class="keyword elisp">if</span> `<span class="constant important">face</span>' is not
included in `<span class="constant important">whitespace-style</span>') is to use exclusively for
cleanning up a buffer.  See `<span class="constant important">whitespace-cleanup</span>' and
`<span class="constant important">whitespace-cleanup-region</span>' for documentation.

See also `<span class="constant important">whitespace-display-mappings</span>' for documentation."</span>
  <span class="builtin">:type</span> '(repeat <span class="builtin">:tag</span> <span class="string">"Kind of Blank"</span>
		 (choice <span class="builtin">:tag</span> <span class="string">"Kind of Blank Face"</span>
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) Face visualization"</span>
				face)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) Trailing TABs, SPACEs and HARD SPACEs"</span>
				trailing)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) SPACEs and HARD SPACEs"</span>
				spaces)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) TABs"</span> tabs)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) Lines"</span> lines)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) SPACEs before TAB"</span>
				space-before-tab)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) NEWLINEs"</span> newline)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) Indentation SPACEs"</span>
				indentation)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) Empty Lines At BOB And/Or EOB"</span>
				empty)
			 (const <span class="builtin">:tag</span> <span class="string">"(Face) SPACEs after TAB"</span>
				space-after-tab)
			 (const <span class="builtin">:tag</span> <span class="string">"(Mark) SPACEs and HARD SPACEs"</span>
				space-mark)
			 (const <span class="builtin">:tag</span> <span class="string">"(Mark) TABs"</span> tab-mark)
			 (const <span class="builtin">:tag</span> <span class="string">"(Mark) NEWLINEs"</span> newline-mark)))
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space</span> 'whitespace-space
  <span class="string">"Symbol face used to visualize SPACE.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">spaces</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-space</span>
  '((((class color) (background dark))
     (<span class="builtin">:background</span> <span class="string">"grey20"</span>      <span class="builtin">:foreground</span> <span class="string">"darkgray"</span>))
    (((class color) (background light))
     (<span class="builtin">:background</span> <span class="string">"LightYellow"</span> <span class="builtin">:foreground</span> <span class="string">"lightgray"</span>))
    (t (<span class="builtin">:inverse-video</span> t)))
  <span class="string">"Face used to visualize SPACE."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-hspace</span> 'whitespace-hspace
  <span class="string">"Symbol face used to visualize HARD SPACE.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">spaces</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-hspace</span>		<span class="comment">; 'nobreak-space</span>
  '((((class color) (background dark))
     (<span class="builtin">:background</span> <span class="string">"grey24"</span>        <span class="builtin">:foreground</span> <span class="string">"darkgray"</span>))
    (((class color) (background light))
     (<span class="builtin">:background</span> <span class="string">"LemonChiffon3"</span> <span class="builtin">:foreground</span> <span class="string">"lightgray"</span>))
    (t (<span class="builtin">:inverse-video</span> t)))
  <span class="string">"Face used to visualize HARD SPACE."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-tab</span> 'whitespace-tab
  <span class="string">"Symbol face used to visualize TAB.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">tabs</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-tab</span>
  '((((class color) (background dark))
     (<span class="builtin">:background</span> <span class="string">"grey22"</span> <span class="builtin">:foreground</span> <span class="string">"darkgray"</span>))
    (((class color) (background light))
     (<span class="builtin">:background</span> <span class="string">"beige"</span>  <span class="builtin">:foreground</span> <span class="string">"lightgray"</span>))
    (t (<span class="builtin">:inverse-video</span> t)))
  <span class="string">"Face used to visualize TAB."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-newline</span> 'whitespace-newline
  <span class="string">"Symbol face used to visualize NEWLINE char mapping.

See `<span class="constant important">whitespace-display-mappings</span>'.

Used when `<span class="constant important">whitespace-style</span>' includes the values `<span class="constant important">newline-mark</span>'
and `<span class="constant important">newline</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-newline</span>
  '((((class color) (background dark))
     (<span class="builtin">:foreground</span> <span class="string">"darkgray"</span> <span class="builtin">:bold</span> nil))
    (((class color) (background light))
     (<span class="builtin">:foreground</span> <span class="string">"lightgray"</span> <span class="builtin">:bold</span> nil))
    (t (<span class="builtin">:underline</span> t <span class="builtin">:bold</span> nil)))
  <span class="string">"Face used to visualize NEWLINE char mapping.

See `<span class="constant important">whitespace-display-mappings</span>'."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-trailing</span> 'whitespace-trailing
  <span class="string">"Symbol face used to visualize trailing blanks.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">trailing</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-trailing</span>		<span class="comment">; 'trailing-whitespace</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"red1"</span> <span class="builtin">:foreground</span> <span class="string">"yellow"</span> <span class="builtin">:bold</span> t)))
  <span class="string">"Face used to visualize trailing blanks."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-line</span> 'whitespace-line
  <span class="string">"Symbol face used to visualize \"long\" lines.

See `<span class="constant important">whitespace-line-column</span>'.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">line</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-line</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"gray20"</span> <span class="builtin">:foreground</span> <span class="string">"violet"</span>)))
  <span class="string">"Face used to visualize \"long\" lines.

See `<span class="constant important">whitespace-line-column</span>'."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space-before-tab</span> 'whitespace-space-before-tab
  <span class="string">"Symbol face used to visualize SPACEs before TAB.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-before-tab</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-space-before-tab</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"DarkOrange"</span> <span class="builtin">:foreground</span> <span class="string">"firebrick"</span>)))
  <span class="string">"Face used to visualize SPACEs before TAB."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-indentation</span> 'whitespace-indentation
  <span class="string">"Symbol face used to visualize 8 or more SPACEs at beginning of line.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-indentation</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"yellow"</span> <span class="builtin">:foreground</span> <span class="string">"firebrick"</span>)))
  <span class="string">"Face used to visualize 8 or more SPACEs at beginning of line."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-empty</span> 'whitespace-empty
  <span class="string">"Symbol face used to visualize empty lines at beginning and/or end of buffer.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">empty</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-empty</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"yellow"</span> <span class="builtin">:foreground</span> <span class="string">"firebrick"</span>)))
  <span class="string">"Face used to visualize empty lines at beginning and/or end of buffer."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space-after-tab</span> 'whitespace-space-after-tab
  <span class="string">"Symbol face used to visualize 8 or more SPACEs after TAB.

Used when `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-after-tab</span>'."</span>
  <span class="builtin">:type</span> 'face
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defface</span> <span class="variable">whitespace-space-after-tab</span>
  '((((class mono)) (<span class="builtin">:inverse-video</span> t <span class="builtin">:bold</span> t <span class="builtin">:underline</span> t))
    (t (<span class="builtin">:background</span> <span class="string">"yellow"</span> <span class="builtin">:foreground</span> <span class="string">"firebrick"</span>)))
  <span class="string">"Face used to visualize 8 or more SPACEs after TAB."</span>
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-hspace-regexp</span>
  <span class="string">"\\(\\(\xA0\\|\x8A0\\|\x920\\|\xE20\\|\xF20\\)+\\)"</span>
  <span class="string">"Specify HARD SPACE characters regexp.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \"\\xA0\"   \"\\x8A0\"   \"\\x920\"   \"\\xE20\"   \"\\xF20\"

that should be considered HARD SPACE.

Here are some examples:

   \"\\\\(^\\xA0+\\\\)\"		\
visualize only leading HARD SPACEs.
   \"\\\\(\\xA0+$\\\\)\"		\
visualize only trailing HARD SPACEs.
   \"\\\\(^\\xA0+\\\\|\\xA0+$\\\\)\"	\
visualize leading and/or trailing HARD SPACEs.
   \"\\t\\\\(\\xA0+\\\\)\\t\"		\
visualize only HARD SPACEs between TABs.

NOTE: Enclose always by \\\\( and \\\\) the elements to highlight.
      Use exactly one pair of enclosing \\\\( and \\\\).

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">spaces</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"HARD SPACE Chars"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space-regexp</span> <span class="string">"\\( +\\)"</span>
  <span class="string">"Specify SPACE characters regexp.

If you're using `<span class="constant important">mule</span>' package, there may be other characters
besides \" \" that should be considered SPACE.

Here are some examples:

   \"\\\\(^ +\\\\)\"		visualize only leading SPACEs.
   \"\\\\( +$\\\\)\"		visualize only trailing SPACEs.
   \"\\\\(^ +\\\\| +$\\\\)\"	\
visualize leading and/or trailing SPACEs.
   \"\\t\\\\( +\\\\)\\t\"	visualize only SPACEs between TABs.

NOTE: Enclose always by \\\\( and \\\\) the elements to highlight.
      Use exactly one pair of enclosing \\\\( and \\\\).

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">spaces</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"SPACE Chars"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-tab-regexp</span> <span class="string">"\\(\t+\\)"</span>
  <span class="string">"Specify TAB characters regexp.

If you're using `<span class="constant important">mule</span>' package, there may be other characters
besides \"\\t\" that should be considered TAB.

Here are some examples:

   \"\\\\(^\\t+\\\\)\"		visualize only leading TABs.
   \"\\\\(\\t+$\\\\)\"		visualize only trailing TABs.
   \"\\\\(^\\t+\\\\|\\t+$\\\\)\"	\
visualize leading and/or trailing TABs.
   \" \\\\(\\t+\\\\) \"	visualize only TABs between SPACEs.

NOTE: Enclose always by \\\\( and \\\\) the elements to highlight.
      Use exactly one pair of enclosing \\\\( and \\\\).

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">tabs</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"TAB Chars"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-trailing-regexp</span>
  <span class="string">"\\([\t \u00A0]+\\)$"</span>
  <span class="string">"Specify trailing characters regexp.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\u00A0\"

that should be considered blank.

NOTE: Enclose always by \"\\\\(\" and \"\\\\)$\" the elements to highlight.
      Use exactly one pair of enclosing elements above.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">trailing</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"Trailing Chars"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space-before-tab-regexp</span> <span class="string">"\\( +\\)\\(\t+\\)"</span>
  <span class="string">"Specify SPACEs before TAB regexp.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\xA0\"  \"\\x8A0\"  \"\\x920\"  \"\\xE20\"  \
\"\\xF20\"

that should be considered blank.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">space-before-tab</span>',
`<span class="constant important">space-before-tab<span class="builtin">::tab</span></span>' or  `<span class="constant important">space-before-tab<span class="builtin">::space</span></span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"SPACEs Before TAB"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-indentation-regexp</span>
  '(<span class="string">"^\t*\\(\\( \\{%d\\}\\)+\\)[<span class="negation">^</span>\n\t]"</span>
    . <span class="string">"^ *\\(\t+\\)[<span class="negation">^</span>\n]"</span>)
  <span class="string">"Specify regexp for 8 or more SPACEs at beginning of line.

It is a cons where the cons car is used for SPACEs visualization
and the cons cdr is used for TABs visualization.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\xA0\"  \"\\x8A0\"  \"\\x920\"  \"\\xE20\"  \
\"\\xF20\"

that should be considered blank.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">indentation</span>',
`<span class="constant important">indentation<span class="builtin">::tab</span></span>' or  `<span class="constant important">indentation<span class="builtin">::space</span></span>'."</span>
  <span class="builtin">:type</span> '(cons (regexp <span class="builtin">:tag</span> <span class="string">"Indentation SPACEs"</span>)
	       (regexp <span class="builtin">:tag</span> <span class="string">"Indentation TABs"</span>))
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-empty-at-bob-regexp</span> <span class="string">"^\\(\\([ \t]*\n\\)+\\)"</span>
  <span class="string">"Specify regexp for empty lines at beginning of buffer.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\xA0\"  \"\\x8A0\"  \"\\x920\"  \"\\xE20\"  \
\"\\xF20\"

that should be considered blank.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">empty</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"Empty Lines At Beginning Of Buffer"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-empty-at-eob-regexp</span> <span class="string">"^\\([ \t\n]+\\)"</span>
  <span class="string">"Specify regexp for empty lines at end of buffer.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\xA0\"  \"\\x8A0\"  \"\\x920\"  \"\\xE20\"  \
\"\\xF20\"

that should be considered blank.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">empty</span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"Empty Lines At End Of Buffer"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-space-after-tab-regexp</span>
  '(<span class="string">"\t+\\(\\( \\{%d\\}\\)+\\)"</span>
    . <span class="string">"\\(\t+\\) +"</span>)
  <span class="string">"Specify regexp for 8 or more SPACEs after TAB.

It is a cons where the cons car is used for SPACEs visualization
and the cons cdr is used for TABs visualization.

If you're using `<span class="constant important">mule</span>' package, there may be other characters besides:

   \" \"  \"\\t\"  \"\\xA0\"  \"\\x8A0\"  \"\\x920\"  \"\\xE20\"  \
\"\\xF20\"

that should be considered blank.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">space-after-tab</span>',
`<span class="constant important">space-after-tab<span class="builtin">::tab</span></span>' or `<span class="constant important">space-after-tab<span class="builtin">::space</span></span>'."</span>
  <span class="builtin">:type</span> '(regexp <span class="builtin">:tag</span> <span class="string">"SPACEs After TAB"</span>)
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-line-column</span> 80
  <span class="string">"Specify column beyond which the line is highlighted.

It must be an integer or nil.  If nil, the `<span class="constant important">fill-column</span>' variable value is
used.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">lines</span>' or `<span class="constant important">lines-tail</span>'."</span>
  <span class="builtin">:type</span> '(choice <span class="builtin">:tag</span> <span class="string">"Line Length Limit"</span>
		 (integer <span class="builtin">:tag</span> <span class="string">"Line Length"</span>)
		 (const <span class="builtin">:tag</span> <span class="string">"Use fill-column"</span> nil))
  <span class="builtin">:group</span> 'whitespace)


<span class="comment">;; Hacked from `<span class="constant important">visible-whitespace-mappings</span>' in visws.el</span>
(<span class="keyword">defcustom</span> <span class="variable">whitespace-display-mappings</span>
  (<span class="keyword elisp">if</span> (&gt;= emacs-major-version 23)
      <span class="comment">;; Emacs 23 and higher<span class="builtin">:</span></span>
      '(
	(space-mark   ?\     [?\u00B7]     [?.]) <span class="comment">; space - centered dot</span>
	(space-mark   ?\xA0  [?\u00A4]     [?_]) <span class="comment">; hard space - currency</span>
	(space-mark   ?\x8A0 [?\x8A4]      [?_]) <span class="comment">; hard space - currency</span>
	(space-mark   ?\x920 [?\x924]      [?_]) <span class="comment">; hard space - currency</span>
	(space-mark   ?\xE20 [?\xE24]      [?_]) <span class="comment">; hard space - currency</span>
	(space-mark   ?\xF20 [?\xF24]      [?_]) <span class="comment">; hard space - currency</span>
	<span class="comment">;; NEWLINE is displayed using the face `<span class="constant important">whitespace-newline</span>'</span>
	(newline-mark ?\n    [?$ ?\n])	<span class="comment">; eol - dollar sign</span>
	<span class="comment">;; (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n])	; eol - downwards arrow</span>
	<span class="comment">;; (newline-mark ?\n    [?\u00B6 ?\n] [?$ ?\n])	; eol - pilcrow</span>
	<span class="comment">;; (newline-mark ?\n    [?\x8AF ?\n]  [?$ ?\n])	; eol - overscore</span>
	<span class="comment">;; (newline-mark ?\n    [?\x8AC ?\n]  [?$ ?\n])	; eol - negation</span>
	<span class="comment">;; (newline-mark ?\n    [?\x8B0 ?\n]  [?$ ?\n])	; eol - grade</span>
	<span class="comment">;;</span>
	<span class="comment">;; WARNING: the mapping below has a problem.</span>
	<span class="comment">;; When a TAB occupies exactly one column, it will display the</span>
	<span class="comment">;; character ?\xBB at that column followed by a TAB which goes to</span>
	<span class="comment">;; the next TAB column.</span>
	<span class="comment">;; If this is a problem for you, please, comment the line below.</span>
	(tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t]) <span class="comment">; tab - left quote mark</span>
	)
    <span class="comment">;; Emacs 21 and 22<span class="builtin">:</span></span>
    <span class="comment">;; Due to limitations of glyph representation, the char code can not</span>
    <span class="comment">;; be above ?\x1FFFF.  Probably, this will be fixed after Emacs</span>
    <span class="comment">;; unicode merging.</span>
    '(
      (space-mark   ?\     [?\xB7]       [?.]) <span class="comment">; space - centered dot</span>
      (space-mark   ?\xA0  [?\xA4]       [?_]) <span class="comment">; hard space - currency</span>
      (space-mark   ?\x8A0 [?\x8A4]      [?_]) <span class="comment">; hard space - currency</span>
      (space-mark   ?\x920 [?\x924]      [?_]) <span class="comment">; hard space - currency</span>
      (space-mark   ?\xE20 [?\xE24]      [?_]) <span class="comment">; hard space - currency</span>
      (space-mark   ?\xF20 [?\xF24]      [?_]) <span class="comment">; hard space - currency</span>
      <span class="comment">;; NEWLINE is displayed using the face `<span class="constant important">whitespace-newline</span>'</span>
      (newline-mark ?\n    [?$ ?\n])	<span class="comment">; eol - dollar sign</span>
      <span class="comment">;; (newline-mark ?\n    [?\u21B5 ?\n] [?$ ?\n])	; eol - downwards arrow</span>
      <span class="comment">;; (newline-mark ?\n    [?\xB6 ?\n]   [?$ ?\n])	; eol - pilcrow</span>
      <span class="comment">;; (newline-mark ?\n    [?\x8AF ?\n]  [?$ ?\n])	; eol - overscore</span>
      <span class="comment">;; (newline-mark ?\n    [?\x8AC ?\n]  [?$ ?\n])	; eol - negation</span>
      <span class="comment">;; (newline-mark ?\n    [?\x8B0 ?\n]  [?$ ?\n])	; eol - grade</span>
      <span class="comment">;;</span>
      <span class="comment">;; WARNING: the mapping below has a problem.</span>
      <span class="comment">;; When a TAB occupies exactly one column, it will display the</span>
      <span class="comment">;; character ?\xBB at that column followed by a TAB which goes to</span>
      <span class="comment">;; the next TAB column.</span>
      <span class="comment">;; If this is a problem for you, please, comment the line below.</span>
      (tab-mark     ?\t    [?\xBB ?\t]   [?\\ ?\t]) <span class="comment">; tab - left quote mark</span>
      ))
  <span class="string">"Specify an alist of mappings for displaying characters.

Each element has the following form:

   (KIND CHAR VECTOR...)

Where:

KIND	is the kind of character.
	It can be one of the following symbols:

	tab-mark	for TAB character

	space-mark	for SPACE or HARD SPACE character

	newline-mark	for NEWLINE character

CHAR	is the character to be mapped.

VECTOR	is a vector of characters to be displayed in place of CHAR.
	The first display vector that can be displayed is used<span class="comment">;</span>
	if no display vector for a mapping can be displayed, then
	that character is displayed unmodified.

The NEWLINE character is displayed using the face given by
`<span class="constant important">whitespace-newline</span>' variable.

Used when `<span class="constant important">whitespace-style</span>' includes `<span class="constant important">tab-mark</span>', `<span class="constant important">space-mark</span>' or
`<span class="constant important">newline-mark</span>'."</span>
  <span class="builtin">:type</span> '(repeat
	  (list <span class="builtin">:tag</span> <span class="string">"Character Mapping"</span>
		(choice <span class="builtin">:tag</span> <span class="string">"Char Kind"</span>
			(const <span class="builtin">:tag</span> <span class="string">"Tab"</span> tab-mark)
			(const <span class="builtin">:tag</span> <span class="string">"Space"</span> space-mark)
			(const <span class="builtin">:tag</span> <span class="string">"Newline"</span> newline-mark))
		(character <span class="builtin">:tag</span> <span class="string">"Char"</span>)
		(repeat <span class="builtin">:inline</span> t <span class="builtin">:tag</span> <span class="string">"Vector List"</span>
			(vector <span class="builtin">:tag</span> <span class="string">""</span>
				(repeat <span class="builtin">:inline</span> t
					<span class="builtin">:tag</span> <span class="string">"Vector Characters"</span>
					(character <span class="builtin">:tag</span> <span class="string">"Char"</span>))))))
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-global-modes</span> t
  <span class="string">"Modes for which global `<span class="constant important">whitespace-mode</span>' is automagically turned on.

Global `<span class="constant important">whitespace-mode</span>' is controlled by the command
`<span class="constant important">global-whitespace-mode</span>'.

If nil, means no modes have `<span class="constant important">whitespace-mode</span>' automatically
turned on.

If t, all modes that support `<span class="constant important">whitespace-mode</span>' have it
automatically turned on.

Else it should be a list of `<span class="constant important">major-mode</span>' symbol names for which
`<span class="constant important">whitespace-mode</span>' should be automatically turned on.  The sense
of the list is negated if it begins with `<span class="constant important">not</span>'.  For example:

   (c-mode c++-mode)

means that `<span class="constant important">whitespace-mode</span>' is turned on for buffers in C and
C++ modes only."</span>
  <span class="builtin">:type</span> '(choice <span class="builtin">:tag</span> <span class="string">"Global Modes"</span>
		 (const <span class="builtin">:tag</span> <span class="string">"None"</span> nil)
		 (const <span class="builtin">:tag</span> <span class="string">"All"</span> t)
		 (set <span class="builtin">:menu-tag</span> <span class="string">"Mode Specific"</span> <span class="builtin">:tag</span> <span class="string">"Modes"</span>
		      <span class="builtin">:value</span> (not)
		      (const <span class="builtin">:tag</span> <span class="string">"Except"</span> not)
		      (repeat <span class="builtin">:inline</span> t
			      (symbol <span class="builtin">:tag</span> <span class="string">"Mode"</span>))))
  <span class="builtin">:group</span> 'whitespace)


(<span class="keyword">defcustom</span> <span class="variable">whitespace-action</span> nil
  <span class="string">"Specify which action is taken when a buffer is visited or written.

It's a list containing some or all of the following values:

   nil			no action is taken.

   cleanup		cleanup any bogus whitespace always when local
			whitespace is turned on.
			See `<span class="constant important">whitespace-cleanup</span>' and
			`<span class="constant important">whitespace-cleanup-region</span>'.

   report-on-bogus	report if there is any bogus whitespace always
			when local whitespace is turned on.

   auto-cleanup		cleanup any bogus whitespace when buffer is
			written.
			See `<span class="constant important">whitespace-cleanup</span>' and
			`<span class="constant important">whitespace-cleanup-region</span>'.

   abort-on-bogus	abort if there is any bogus whitespace and the
			buffer is written.

   warn-if-read-only	give a warning if `<span class="constant important">cleanup</span>' or `<span class="constant important">auto-cleanup</span>'
			is included in `<span class="constant important">whitespace-action</span>' and the
			buffer is read-only.

Any other value is treated as nil."</span>
  <span class="builtin">:type</span> '(choice <span class="builtin">:tag</span> <span class="string">"Actions"</span>
		 (const <span class="builtin">:tag</span> <span class="string">"None"</span> nil)
		 (repeat <span class="builtin">:tag</span> <span class="string">"Action List"</span>
		  (choice <span class="builtin">:tag</span> <span class="string">"Action"</span>
			  (const <span class="builtin">:tag</span> <span class="string">"Cleanup When On"</span> cleanup)
			  (const <span class="builtin">:tag</span> <span class="string">"Report On Bogus"</span> report-on-bogus)
			  (const <span class="builtin">:tag</span> <span class="string">"Auto Cleanup"</span> auto-cleanup)
			  (const <span class="builtin">:tag</span> <span class="string">"Abort On Bogus"</span> abort-on-bogus)
			  (const <span class="builtin">:tag</span> <span class="string">"Warn If Read-Only"</span> warn-if-read-only))))
  <span class="builtin">:group</span> 'whitespace)

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User commands - Local mode</span>


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">define-minor-mode</span> <span class="function">whitespace-mode</span>
  <span class="string">"Toggle whitespace visualization (Whitespace mode).
With a prefix argument ARG, enable Whitespace mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

See also `<span class="constant important">whitespace-style</span>', `<span class="constant important">whitespace-newline</span>' and
`<span class="constant important">whitespace-display-mappings</span>'."</span>
  <span class="builtin">:lighter</span>    <span class="string">" ws"</span>
  <span class="builtin">:init-value</span> nil
  <span class="builtin">:global</span>     nil
  <span class="builtin">:group</span>      'whitespace
  (<span class="keyword elisp">cond</span>
   (noninteractive			<span class="comment">; running a batch job</span>
    (setq whitespace-mode nil))
   (whitespace-mode			<span class="comment">; whitespace-mode on</span>
    (whitespace-turn-on)
    (whitespace-action-when-on))
   (t					<span class="comment">; whitespace-mode off</span>
    (whitespace-turn-off))))


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">define-minor-mode</span> <span class="function">whitespace-newline-mode</span>
  <span class="string">"Toggle newline visualization (Whitespace Newline mode).
With a prefix argument ARG, enable Whitespace Newline mode if ARG
is positive, and disable it otherwise.  If called from Lisp,
enable the mode if ARG is omitted or nil.

Use `<span class="constant important">whitespace-newline-mode</span>' only for NEWLINE visualization
exclusively.  For other visualizations, including NEWLINE
visualization together with (HARD) SPACEs and/or TABs, please,
use `<span class="constant important">whitespace-mode</span>'.

See also `<span class="constant important">whitespace-newline</span>' and `<span class="constant important">whitespace-display-mappings</span>'."</span>
  <span class="builtin">:lighter</span>    <span class="string">" nl"</span>
  <span class="builtin">:init-value</span> nil
  <span class="builtin">:global</span>     nil
  <span class="builtin">:group</span>      'whitespace
  (<span class="keyword elisp">let</span> ((whitespace-style '(face newline-mark newline)))
    (whitespace-mode (<span class="keyword elisp">if</span> whitespace-newline-mode
			 1 -1)))
  <span class="comment">;; sync states (running a batch job)</span>
  (setq whitespace-newline-mode whitespace-mode))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User commands - Global mode</span>


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">define-minor-mode</span> <span class="function">global-whitespace-mode</span>
  <span class="string">"Toggle whitespace visualization globally (Global Whitespace mode).
With a prefix argument ARG, enable Global Whitespace mode if ARG
is positive, and disable it otherwise.  If called from Lisp,
enable it if ARG is omitted or nil.

See also `<span class="constant important">whitespace-style</span>', `<span class="constant important">whitespace-newline</span>' and
`<span class="constant important">whitespace-display-mappings</span>'."</span>
  <span class="builtin">:lighter</span>    <span class="string">" WS"</span>
  <span class="builtin">:init-value</span> nil
  <span class="builtin">:global</span>     t
  <span class="builtin">:group</span>      'whitespace
  (<span class="keyword elisp">cond</span>
   (noninteractive			<span class="comment">; running a batch job</span>
    (setq global-whitespace-mode nil))
   (global-whitespace-mode		<span class="comment">; global-whitespace-mode on</span>
    (<span class="keyword elisp">save-current-buffer</span>
      (add-hook (<span class="keyword elisp">if</span> (boundp 'find-file-hook)
		    'find-file-hook
		  'find-file-hooks)
		'whitespace-turn-on-if-enabled)
      (add-hook 'after-change-major-mode-hook 'whitespace-turn-on-if-enabled)
      (<span class="keyword cl">dolist</span> (buffer (buffer-list))	<span class="comment">; adjust all local mode</span>
	(set-buffer buffer)
	(<span class="keyword cl">unless</span> whitespace-mode
	  (whitespace-turn-on-if-enabled)))))
   (t					<span class="comment">; global-whitespace-mode off</span>
    (<span class="keyword elisp">save-current-buffer</span>
      (remove-hook (<span class="keyword elisp">if</span> (boundp 'find-file-hook)
		       'find-file-hook
		     'find-file-hooks)
		   'whitespace-turn-on-if-enabled)
      (remove-hook 'after-change-major-mode-hook 'whitespace-turn-on-if-enabled)
      (<span class="keyword cl">dolist</span> (buffer (buffer-list))	<span class="comment">; adjust all local mode</span>
	(set-buffer buffer)
	(<span class="keyword cl">unless</span> whitespace-mode
	  (whitespace-turn-off)))))))


(<span class="keyword">defun</span> <span class="function">whitespace-turn-on-if-enabled</span> ()
  (<span class="keyword cl">when</span> (<span class="keyword elisp">cond</span>
	 ((eq whitespace-global-modes t))
	 ((listp whitespace-global-modes)
	  (<span class="keyword elisp">if</span> (eq (car-safe whitespace-global-modes) 'not)
	      (not (memq major-mode (cdr whitespace-global-modes)))
	    (memq major-mode whitespace-global-modes)))
	 (t nil))
    (<span class="keyword elisp">let</span> (inhibit-quit)
      <span class="comment">;; Don't turn on whitespace mode if...</span>
      (or
       <span class="comment">;; ...we don't have a display (we're running a batch job)</span>
       noninteractive
       <span class="comment">;; ...or if the buffer is invisible (name starts with a space)</span>
       (eq (aref (buffer-name) 0) ?\ )
       <span class="comment">;; ...or if the buffer is temporary (name starts with *)</span>
       (and (eq (aref (buffer-name) 0) ?*)
	    <span class="comment">;; except the scratch buffer.</span>
	    (not (string= (buffer-name) <span class="string">"*scratch*"</span>)))
       <span class="comment">;; Otherwise, turn on whitespace mode.</span>
       (whitespace-turn-on)))))


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">define-minor-mode</span> <span class="function">global-whitespace-newline-mode</span>
  <span class="string">"Toggle global newline visualization (Global Whitespace Newline mode).
With a prefix argument ARG, enable Global Whitespace Newline mode
if ARG is positive, and disable it otherwise.  If called from
Lisp, enable it if ARG is omitted or nil.

Use `<span class="constant important">global-whitespace-newline-mode</span>' only for NEWLINE
visualization exclusively.  For other visualizations, including
NEWLINE visualization together with (HARD) SPACEs and/or TABs,
please use `<span class="constant important">global-whitespace-mode</span>'.

See also `<span class="constant important">whitespace-newline</span>' and `<span class="constant important">whitespace-display-mappings</span>'."</span>
  <span class="builtin">:lighter</span>    <span class="string">" NL"</span>
  <span class="builtin">:init-value</span> nil
  <span class="builtin">:global</span>     t
  <span class="builtin">:group</span>      'whitespace
  (<span class="keyword elisp">let</span> ((whitespace-style '(newline-mark newline)))
    (global-whitespace-mode (<span class="keyword elisp">if</span> global-whitespace-newline-mode
                                1 -1))
    <span class="comment">;; sync states (running a batch job)</span>
    (setq global-whitespace-newline-mode global-whitespace-mode)))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User commands - Toggle</span>


(<span class="keyword">defconst</span> <span class="variable">whitespace-style-value-list</span>
  '(face
    tabs
    spaces
    trailing
    lines
    lines-tail
    newline
    empty
    indentation
    indentation<span class="builtin">::tab</span>
    indentation<span class="builtin">::space</span>
    space-after-tab
    space-after-tab<span class="builtin">::tab</span>
    space-after-tab<span class="builtin">::space</span>
    space-before-tab
    space-before-tab<span class="builtin">::tab</span>
    space-before-tab<span class="builtin">::space</span>
    help-newline       <span class="comment">; value used by `<span class="constant important">whitespace-insert-option-mark</span>'</span>
    tab-mark
    space-mark
    newline-mark
    )
  <span class="string">"List of valid `<span class="constant important">whitespace-style</span>' values."</span>)


(<span class="keyword">defconst</span> <span class="variable">whitespace-toggle-option-alist</span>
  '((?f    . face)
    (?t    . tabs)
    (?s    . spaces)
    (?r    . trailing)
    (?l    . lines)
    (?L    . lines-tail)
    (?n    . newline)
    (?e    . empty)
    (?\C-i . indentation)
    (?I    . indentation<span class="builtin">::tab</span>)
    (?i    . indentation<span class="builtin">::space</span>)
    (?\C-a . space-after-tab)
    (?A    . space-after-tab<span class="builtin">::tab</span>)
    (?a    . space-after-tab<span class="builtin">::space</span>)
    (?\C-b . space-before-tab)
    (?B    . space-before-tab<span class="builtin">::tab</span>)
    (?b    . space-before-tab<span class="builtin">::space</span>)
    (?T    . tab-mark)
    (?S    . space-mark)
    (?N    . newline-mark)
    (?x    . whitespace-style)
    )
  <span class="string">"Alist of toggle options.

Each element has the form:

   (CHAR . SYMBOL)

Where:

CHAR	is a char which the user will have to type.

SYMBOL	is a valid symbol associated with CHAR.
	See `<span class="constant important">whitespace-style-value-list</span>'."</span>)


(<span class="keyword">defvar</span> <span class="variable">whitespace-active-style</span> nil
  <span class="string">"Used to save locally `<span class="constant important">whitespace-style</span>' value."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-indent-tabs-mode</span> indent-tabs-mode
  <span class="string">"Used to save locally `<span class="constant important">indent-tabs-mode</span>' value."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-tab-width</span> tab-width
  <span class="string">"Used to save locally `<span class="constant important">tab-width</span>' value."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-point</span> (point)
  <span class="string">"Used to save locally current point value.
Used by `<span class="constant important">whitespace-trailing-regexp</span>' function (which see)."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-font-lock-refontify</span> nil
  <span class="string">"Used to save locally the font-lock refontify state.
Used by `<span class="constant important">whitespace-post-command-hook</span>' function (which see)."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-bob-marker</span> nil
  <span class="string">"Used to save locally the bob marker value.
Used by `<span class="constant important">whitespace-post-command-hook</span>' function (which see)."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-eob-marker</span> nil
  <span class="string">"Used to save locally the eob marker value.
Used by `<span class="constant important">whitespace-post-command-hook</span>' function (which see)."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-buffer-changed</span> nil
  <span class="string">"Used to indicate locally if buffer changed.
Used by `<span class="constant important">whitespace-post-command-hook</span>' and `<span class="constant important">whitespace-buffer-changed</span>'
functions (which see)."</span>)


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">whitespace-toggle-options</span> (arg)
  <span class="string">"Toggle local `<span class="constant important">whitespace-mode</span>' options.

If local whitespace-mode is off, toggle the option given by ARG
and turn on local whitespace-mode.

If local whitespace-mode is on, toggle the option given by ARG
and restart local whitespace-mode.

Interactively, it reads one of the following chars:

  CHAR	MEANING
  (VIA FACES)
   f	toggle face visualization
   t	toggle TAB visualization
   s	toggle SPACE and HARD SPACE visualization
   r	toggle trailing blanks visualization
   l	toggle \"long lines\" visualization
   L	toggle \"long lines\" tail visualization
   n	toggle NEWLINE visualization
   e	toggle empty line at bob and/or eob visualization
   C-i	toggle indentation SPACEs visualization (via `<span class="constant important">indent-tabs-mode</span>')
   I	toggle indentation SPACEs visualization
   i	toggle indentation TABs visualization
   C-a	toggle SPACEs after TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   A	toggle SPACEs after TAB: SPACEs visualization
   a	toggle SPACEs after TAB: TABs visualization
   C-b	toggle SPACEs before TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   B	toggle SPACEs before TAB: SPACEs visualization
   b	toggle SPACEs before TAB: TABs visualization

  (VIA DISPLAY TABLE)
   T	toggle TAB visualization
   S	toggle SPACEs before TAB visualization
   N	toggle NEWLINE visualization

   x	restore `<span class="constant important">whitespace-style</span>' value
   ?	display brief help

Non-interactively, ARG should be a symbol or a list of symbols.
The valid symbols are:

   face			toggle face visualization
   tabs			toggle TAB visualization
   spaces		toggle SPACE and HARD SPACE visualization
   trailing		toggle trailing blanks visualization
   lines		toggle \"long lines\" visualization
   lines-tail		toggle \"long lines\" tail visualization
   newline		toggle NEWLINE visualization
   empty		toggle empty line at bob and/or eob visualization
   indentation		toggle indentation SPACEs visualization
   indentation<span class="builtin">::tab</span>	toggle indentation SPACEs visualization
   indentation<span class="builtin">::space</span>	toggle indentation TABs visualization
   space-after-tab		toggle SPACEs after TAB visualization
   space-after-tab<span class="builtin">::tab</span>		toggle SPACEs after TAB: SPACEs visualization
   space-after-tab<span class="builtin">::space</span>	toggle SPACEs after TAB: TABs visualization
   space-before-tab		toggle SPACEs before TAB visualization
   space-before-tab<span class="builtin">::tab</span>	toggle SPACEs before TAB: SPACEs visualization
   space-before-tab<span class="builtin">::space</span>	toggle SPACEs before TAB: TABs visualization

   tab-mark		toggle TAB visualization
   space-mark		toggle SPACEs before TAB visualization
   newline-mark		toggle NEWLINE visualization

   whitespace-style	restore `<span class="constant important">whitespace-style</span>' value

See `<span class="constant important">whitespace-style</span>' and `<span class="constant important">indent-tabs-mode</span>' for documentation."</span>
  (interactive (whitespace-interactive-char t))
  (<span class="keyword elisp">let</span> ((whitespace-style
	 (whitespace-toggle-list t arg whitespace-active-style)))
    (whitespace-mode 0)
    (whitespace-mode 1)))


(<span class="keyword">defvar</span> <span class="variable">whitespace-toggle-style</span> nil
  <span class="string">"Used to toggle the global `<span class="constant important">whitespace-style</span>' value."</span>)


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">global-whitespace-toggle-options</span> (arg)
  <span class="string">"Toggle global `<span class="constant important">whitespace-mode</span>' options.

If global whitespace-mode is off, toggle the option given by ARG
and turn on global whitespace-mode.

If global whitespace-mode is on, toggle the option given by ARG
and restart global whitespace-mode.

Interactively, it accepts one of the following chars:

  CHAR	MEANING
  (VIA FACES)
   f	toggle face visualization
   t	toggle TAB visualization
   s	toggle SPACE and HARD SPACE visualization
   r	toggle trailing blanks visualization
   l	toggle \"long lines\" visualization
   L	toggle \"long lines\" tail visualization
   n	toggle NEWLINE visualization
   e	toggle empty line at bob and/or eob visualization
   C-i	toggle indentation SPACEs visualization (via `<span class="constant important">indent-tabs-mode</span>')
   I	toggle indentation SPACEs visualization
   i	toggle indentation TABs visualization
   C-a	toggle SPACEs after TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   A	toggle SPACEs after TAB: SPACEs visualization
   a	toggle SPACEs after TAB: TABs visualization
   C-b	toggle SPACEs before TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   B	toggle SPACEs before TAB: SPACEs visualization
   b	toggle SPACEs before TAB: TABs visualization

  (VIA DISPLAY TABLE)
   T	toggle TAB visualization
   S	toggle SPACEs before TAB visualization
   N	toggle NEWLINE visualization

   x	restore `<span class="constant important">whitespace-style</span>' value
   ?	display brief help

Non-interactively, ARG should be a symbol or a list of symbols.
The valid symbols are:

   face			toggle face visualization
   tabs			toggle TAB visualization
   spaces		toggle SPACE and HARD SPACE visualization
   trailing		toggle trailing blanks visualization
   lines		toggle \"long lines\" visualization
   lines-tail		toggle \"long lines\" tail visualization
   newline		toggle NEWLINE visualization
   empty		toggle empty line at bob and/or eob visualization
   indentation		toggle indentation SPACEs visualization
   indentation<span class="builtin">::tab</span>	toggle indentation SPACEs visualization
   indentation<span class="builtin">::space</span>	toggle indentation TABs visualization
   space-after-tab		toggle SPACEs after TAB visualization
   space-after-tab<span class="builtin">::tab</span>		toggle SPACEs after TAB: SPACEs visualization
   space-after-tab<span class="builtin">::space</span>	toggle SPACEs after TAB: TABs visualization
   space-before-tab		toggle SPACEs before TAB visualization
   space-before-tab<span class="builtin">::tab</span>	toggle SPACEs before TAB: SPACEs visualization
   space-before-tab<span class="builtin">::space</span>	toggle SPACEs before TAB: TABs visualization

   tab-mark		toggle TAB visualization
   space-mark		toggle SPACEs before TAB visualization
   newline-mark		toggle NEWLINE visualization

   whitespace-style	restore `<span class="constant important">whitespace-style</span>' value

See `<span class="constant important">whitespace-style</span>' and `<span class="constant important">indent-tabs-mode</span>' for documentation."</span>
  (interactive (whitespace-interactive-char nil))
  (<span class="keyword elisp">let</span> ((whitespace-style
	 (whitespace-toggle-list nil arg whitespace-toggle-style)))
    (setq whitespace-toggle-style whitespace-style)
    (global-whitespace-mode 0)
    (global-whitespace-mode 1)))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User commands - Cleanup</span>


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">whitespace-cleanup</span> ()
  <span class="string">"Cleanup some blank problems in all buffer or at region.

It usually applies to the whole buffer, but in transient mark
mode when the mark is active, it applies to the region.  It also
applies to the region when it is not in transient mark mode, the
mark is active and \\[<span class="constant important">universal-argument</span>] was pressed just before
calling `<span class="constant important">whitespace-cleanup</span>' interactively.

See also `<span class="constant important">whitespace-cleanup-region</span>'.

The problems cleaned up are:

1. empty lines at beginning of buffer.
2. empty lines at end of buffer.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">empty</span>', remove all
   empty lines at beginning and/or end of buffer.

3. 8 or more SPACEs at beginning of line.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation</span>':
   replace 8 or more SPACEs at beginning of line by TABs, if
   `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">; otherwise, replace TABs by</span>
   SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::tab</span></span>',
   replace 8 or more SPACEs at beginning of line by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::space</span></span>',
   replace TABs by SPACEs.

4. SPACEs before TAB.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-before-tab</span>':
   replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">;</span>
   otherwise, replace TABs by SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-before-tab<span class="builtin">::tab</span></span>', replace SPACEs by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-before-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.

5. SPACEs or TABs at end of line.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">trailing</span>', remove
   all SPACEs or TABs at end of line.

6. 8 or more SPACEs after TAB.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-after-tab</span>':
   replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">;</span>
   otherwise, replace TABs by SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-after-tab<span class="builtin">::tab</span></span>', replace SPACEs by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-after-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.

See `<span class="constant important">whitespace-style</span>', `<span class="constant important">indent-tabs-mode</span>' and `<span class="constant important">tab-width</span>' for
documentation."</span>
  (interactive <span class="string">"@"</span>)
  (<span class="keyword elisp">cond</span>
   <span class="comment">;; read-only buffer</span>
   (buffer-read-only
    (whitespace-warn-read-only <span class="string">"cleanup"</span>))
   <span class="comment">;; region active</span>
   ((and (or transient-mark-mode
	     current-prefix-arg)
	 mark-active)
    <span class="comment">;; PROBLEMs 1 and 2 are not handled in region</span>
    <span class="comment">;; PROBLEM 3: 8 or more SPACEs at bol</span>
    <span class="comment">;; PROBLEM 4: SPACEs before TAB</span>
    <span class="comment">;; PROBLEM 5: SPACEs or TABs at eol</span>
    <span class="comment">;; PROBLEM 6: 8 or more SPACEs after TAB</span>
    (whitespace-cleanup-region (region-beginning) (region-end)))
   <span class="comment">;; whole buffer</span>
   (t
    (<span class="keyword elisp">save-excursion</span>
      (<span class="keyword elisp">save-match-data</span>
	<span class="comment">;; PROBLEM 1: empty lines at bob</span>
	<span class="comment">;; PROBLEM 2: empty lines at eob</span>
	<span class="comment">;; ACTION: remove all empty lines at bob and/or eob</span>
	(<span class="keyword cl">when</span> (memq 'empty whitespace-style)
	  (<span class="keyword elisp">let</span> (overwrite-mode)		<span class="comment">; enforce no overwrite</span>
	    (goto-char (point-min))
	    (<span class="keyword cl">when</span> (re-search-forward
		   (concat <span class="string">"\\`"</span> whitespace-empty-at-bob-regexp) nil t)
	      (delete-region (match-beginning 1) (match-end 1)))
	    (<span class="keyword cl">when</span> (re-search-forward
		   (concat whitespace-empty-at-eob-regexp <span class="string">"\\'"</span>) nil t)
	      (delete-region (match-beginning 1) (match-end 1)))))))
    <span class="comment">;; PROBLEM 3: 8 or more SPACEs at bol</span>
    <span class="comment">;; PROBLEM 4: SPACEs before TAB</span>
    <span class="comment">;; PROBLEM 5: SPACEs or TABs at eol</span>
    <span class="comment">;; PROBLEM 6: 8 or more SPACEs after TAB</span>
    (whitespace-cleanup-region (point-min) (point-max)))))


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">whitespace-cleanup-region</span> (start end)
  <span class="string">"Cleanup some blank problems at region.

The problems cleaned up are:

1. 8 or more SPACEs at beginning of line.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation</span>':
   replace 8 or more SPACEs at beginning of line by TABs, if
   `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">; otherwise, replace TABs by</span>
   SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::tab</span></span>',
   replace 8 or more SPACEs at beginning of line by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">indentation<span class="builtin">::space</span></span>',
   replace TABs by SPACEs.

2. SPACEs before TAB.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-before-tab</span>':
   replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">;</span>
   otherwise, replace TABs by SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-before-tab<span class="builtin">::tab</span></span>', replace SPACEs by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-before-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.

3. SPACEs or TABs at end of line.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">trailing</span>', remove
   all SPACEs or TABs at end of line.

4. 8 or more SPACEs after TAB.
   If `<span class="constant important">whitespace-style</span>' includes the value `<span class="constant important">space-after-tab</span>':
   replace SPACEs by TABs, if `<span class="constant important">indent-tabs-mode</span>' is non-nil<span class="comment">;</span>
   otherwise, replace TABs by SPACEs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-after-tab<span class="builtin">::tab</span></span>', replace SPACEs by TABs.
   If `<span class="constant important">whitespace-style</span>' includes the value
   `<span class="constant important">space-after-tab<span class="builtin">::space</span></span>', replace TABs by SPACEs.

See `<span class="constant important">whitespace-style</span>', `<span class="constant important">indent-tabs-mode</span>' and `<span class="constant important">tab-width</span>' for
documentation."</span>
  (interactive <span class="string">"@r"</span>)
  (<span class="keyword elisp">if</span> buffer-read-only
      <span class="comment">;; read-only buffer</span>
      (whitespace-warn-read-only <span class="string">"cleanup region"</span>)
    <span class="comment">;; non-read-only buffer</span>
    (<span class="keyword elisp">let</span> ((rstart           (min start end))
	  (rend             (copy-marker (max start end)))
	  (indent-tabs-mode whitespace-indent-tabs-mode)
	  (tab-width        whitespace-tab-width)
	  overwrite-mode		<span class="comment">; enforce no overwrite</span>
	  tmp)
      (<span class="keyword elisp">save-excursion</span>
	(<span class="keyword elisp">save-match-data</span>
	  <span class="comment">;; PROBLEM 1: 8 or more SPACEs at bol</span>
	  (<span class="keyword elisp">cond</span>
	   <span class="comment">;; ACTION: replace 8 or more SPACEs at bol by TABs, if</span>
	   <span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' is non-nil; otherwise, replace TABs</span>
	   <span class="comment">;; by SPACEs.</span>
	   ((memq 'indentation whitespace-style)
	    (<span class="keyword elisp">let</span> ((regexp (whitespace-indentation-regexp)))
	      (goto-char rstart)
	      (<span class="keyword elisp">while</span> (re-search-forward regexp rend t)
		(setq tmp (current-indentation))
		(goto-char (match-beginning 0))
		(delete-horizontal-space)
		(<span class="keyword cl">unless</span> (eolp)
		  (indent-to tmp)))))
	   <span class="comment">;; ACTION: replace 8 or more SPACEs at bol by TABs.</span>
	   ((memq 'indentation<span class="builtin">::tab</span> whitespace-style)
	    (whitespace-replace-action
	     'tabify rstart rend
	     (whitespace-indentation-regexp 'tab) 0))
	   <span class="comment">;; ACTION: replace TABs by SPACEs.</span>
	   ((memq 'indentation<span class="builtin">::space</span> whitespace-style)
	    (whitespace-replace-action
	     'untabify rstart rend
	     (whitespace-indentation-regexp 'space) 0)))
	  <span class="comment">;; PROBLEM 3: SPACEs or TABs at eol</span>
	  <span class="comment">;; ACTION: remove all SPACEs or TABs at eol</span>
	  (<span class="keyword cl">when</span> (memq 'trailing whitespace-style)
	    (whitespace-replace-action
	     'delete-region rstart rend
	     whitespace-trailing-regexp 1))
	  <span class="comment">;; PROBLEM 4: 8 or more SPACEs after TAB</span>
	  (<span class="keyword elisp">cond</span>
	   <span class="comment">;; ACTION: replace 8 or more SPACEs by TABs, if</span>
	   <span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' is non-nil; otherwise, replace TABs</span>
	   <span class="comment">;; by SPACEs.</span>
	   ((memq 'space-after-tab whitespace-style)
	    (whitespace-replace-action
	     (<span class="keyword elisp">if</span> whitespace-indent-tabs-mode 'tabify 'untabify)
	     rstart rend (whitespace-space-after-tab-regexp) 1))
	   <span class="comment">;; ACTION: replace 8 or more SPACEs by TABs.</span>
	   ((memq 'space-after-tab<span class="builtin">::tab</span> whitespace-style)
	    (whitespace-replace-action
	     'tabify rstart rend
	     (whitespace-space-after-tab-regexp 'tab) 1))
	   <span class="comment">;; ACTION: replace TABs by SPACEs.</span>
	   ((memq 'space-after-tab<span class="builtin">::space</span> whitespace-style)
	    (whitespace-replace-action
	     'untabify rstart rend
	     (whitespace-space-after-tab-regexp 'space) 1)))
	  <span class="comment">;; PROBLEM 2: SPACEs before TAB</span>
	  (<span class="keyword elisp">cond</span>
	   <span class="comment">;; ACTION: replace SPACEs before TAB by TABs, if</span>
	   <span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' is non-nil; otherwise, replace TABs</span>
	   <span class="comment">;; by SPACEs.</span>
	   ((memq 'space-before-tab whitespace-style)
	    (whitespace-replace-action
	     (<span class="keyword elisp">if</span> whitespace-indent-tabs-mode 'tabify 'untabify)
	     rstart rend whitespace-space-before-tab-regexp
	     (<span class="keyword elisp">if</span> whitespace-indent-tabs-mode 0 2)))
	   <span class="comment">;; ACTION: replace SPACEs before TAB by TABs.</span>
	   ((memq 'space-before-tab<span class="builtin">::tab</span> whitespace-style)
	    (whitespace-replace-action
	     'tabify rstart rend
	     whitespace-space-before-tab-regexp 0))
	   <span class="comment">;; ACTION: replace TABs by SPACEs.</span>
	   ((memq 'space-before-tab<span class="builtin">::space</span> whitespace-style)
	    (whitespace-replace-action
	     'untabify rstart rend
	     whitespace-space-before-tab-regexp 2)))))
      (set-marker rend nil))))		<span class="comment">; point marker to nowhere</span>


(<span class="keyword">defun</span> <span class="function">whitespace-replace-action</span> (action rstart rend regexp index)
  <span class="string">"Do ACTION in the string matched by REGEXP between RSTART and REND.

INDEX is the level group matched by REGEXP and used by ACTION.

See also `<span class="constant important">tab-width</span>'."</span>
  (goto-char rstart)
  (<span class="keyword elisp">while</span> (re-search-forward regexp rend t)
    (goto-char (match-end index))
    (funcall action (match-beginning index) (match-end index))))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; User command - report</span>


(<span class="keyword">defun</span> <span class="function">whitespace-regexp</span> (regexp <span class="type">&amp;optional</span> kind)
  <span class="string">"Return REGEXP depending on `<span class="constant important">whitespace-indent-tabs-mode</span>'."</span>
  (<span class="keyword elisp">cond</span>
   ((or (eq kind 'tab)
	whitespace-indent-tabs-mode)
    (format (car regexp) whitespace-tab-width))
   ((or (eq kind 'space)
	(not whitespace-indent-tabs-mode))
    (cdr regexp))))


(<span class="keyword">defun</span> <span class="function">whitespace-indentation-regexp</span> (<span class="type">&amp;optional</span> kind)
  <span class="string">"Return the indentation regexp depending on `<span class="constant important">whitespace-indent-tabs-mode</span>'."</span>
  (whitespace-regexp whitespace-indentation-regexp kind))


(<span class="keyword">defun</span> <span class="function">whitespace-space-after-tab-regexp</span> (<span class="type">&amp;optional</span> kind)
  <span class="string">"Return the space-after-tab regexp depending on `<span class="constant important">whitespace-indent-tabs-mode</span>'."</span>
  (whitespace-regexp whitespace-space-after-tab-regexp kind))


(<span class="keyword">defconst</span> <span class="variable">whitespace-report-list</span>
  (list
   (cons 'empty                   whitespace-empty-at-bob-regexp)
   (cons 'empty                   whitespace-empty-at-eob-regexp)
   (cons 'trailing                whitespace-trailing-regexp)
   (cons 'indentation             nil)
   (cons 'indentation<span class="builtin">::tab</span>        nil)
   (cons 'indentation<span class="builtin">::space</span>      nil)
   (cons 'space-before-tab        whitespace-space-before-tab-regexp)
   (cons 'space-before-tab<span class="builtin">::tab</span>   whitespace-space-before-tab-regexp)
   (cons 'space-before-tab<span class="builtin">::space</span> whitespace-space-before-tab-regexp)
   (cons 'space-after-tab         nil)
   (cons 'space-after-tab<span class="builtin">::tab</span>    nil)
   (cons 'space-after-tab<span class="builtin">::space</span>  nil)
   )
   <span class="string">"List of whitespace bogus symbol and corresponding regexp."</span>)


(<span class="keyword">defconst</span> <span class="variable">whitespace-report-text</span>
  '( <span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' has non-nil value</span>
    <span class="string">"\
 Whitespace Report

 Current Setting                       Whitespace Problem

 empty                    []     []  empty lines at beginning of buffer
 empty                    []     []  empty lines at end of buffer
 trailing                 []     []  SPACEs or TABs at end of line
 indentation              []     []  8 or more SPACEs at beginning of line
 indentation<span class="builtin">::tab</span>         []     []  8 or more SPACEs at beginning of line
 indentation<span class="builtin">::space</span>       []     []  TABs at beginning of line
 space-before-tab         []     []  SPACEs before TAB
 space-before-tab<span class="builtin">::tab</span>    []     []  SPACEs before TAB: SPACEs
 space-before-tab<span class="builtin">::space</span>  []     []  SPACEs before TAB: TABs
 space-after-tab          []     []  8 or more SPACEs after TAB
 space-after-tab<span class="builtin">::tab</span>     []     []  8 or more SPACEs after TAB: SPACEs
 space-after-tab<span class="builtin">::space</span>   []     []  8 or more SPACEs after TAB: TABs

 indent-tabs-mode =
 tab-width        = \n\n"</span>
    . <span class="comment">;; `<span class="constant important">indent-tabs-mode</span>' has nil value</span>
    <span class="string">"\
 Whitespace Report

 Current Setting                       Whitespace Problem

 empty                    []     []  empty lines at beginning of buffer
 empty                    []     []  empty lines at end of buffer
 trailing                 []     []  SPACEs or TABs at end of line
 indentation              []     []  TABs at beginning of line
 indentation<span class="builtin">::tab</span>         []     []  8 or more SPACEs at beginning of line
 indentation<span class="builtin">::space</span>       []     []  TABs at beginning of line
 space-before-tab         []     []  SPACEs before TAB
 space-before-tab<span class="builtin">::tab</span>    []     []  SPACEs before TAB: SPACEs
 space-before-tab<span class="builtin">::space</span>  []     []  SPACEs before TAB: TABs
 space-after-tab          []     []  8 or more SPACEs after TAB
 space-after-tab<span class="builtin">::tab</span>     []     []  8 or more SPACEs after TAB: SPACEs
 space-after-tab<span class="builtin">::space</span>   []     []  8 or more SPACEs after TAB: TABs

 indent-tabs-mode =
 tab-width        = \n\n"</span>)
  <span class="string">"Text for whitespace bogus report.

It is a cons of strings, where the car part is used when
`<span class="constant important">indent-tabs-mode</span>' is non-nil, and the cdr part is used when
`<span class="constant important">indent-tabs-mode</span>' is nil."</span>)


(<span class="keyword">defconst</span> <span class="variable">whitespace-report-buffer-name</span> <span class="string">"*Whitespace Report*"</span>
  <span class="string">"The buffer name for whitespace bogus report."</span>)


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">whitespace-report</span> (<span class="type">&amp;optional</span> force report-if-bogus)
  <span class="string">"Report some whitespace problems in buffer.

Return nil if there is no whitespace problem<span class="comment">; otherwise, return</span>
non-nil.

If FORCE is non-nil or \\[<span class="constant important">universal-argument</span>] was pressed just
before calling `<span class="constant important">whitespace-report</span>' interactively, it forces
`<span class="constant important">whitespace-style</span>' to have:

   empty
   trailing
   indentation
   space-before-tab
   space-after-tab

If REPORT-IF-BOGUS is non-nil, it reports only when there are any
whitespace problems in buffer.

Report if some of the following whitespace problems exist:

* If `<span class="constant important">indent-tabs-mode</span>' is non-nil:
   empty		1. empty lines at beginning of buffer.
   empty		2. empty lines at end of buffer.
   trailing		3. SPACEs or TABs at end of line.
   indentation		4. 8 or more SPACEs at beginning of line.
   space-before-tab	5. SPACEs before TAB.
   space-after-tab	6. 8 or more SPACEs after TAB.

* If `<span class="constant important">indent-tabs-mode</span>' is nil:
   empty		1. empty lines at beginning of buffer.
   empty		2. empty lines at end of buffer.
   trailing		3. SPACEs or TABs at end of line.
   indentation		4. TABS at beginning of line.
   space-before-tab	5. SPACEs before TAB.
   space-after-tab	6. 8 or more SPACEs after TAB.

See `<span class="constant important">whitespace-style</span>' for documentation.
See also `<span class="constant important">whitespace-cleanup</span>' and `<span class="constant important">whitespace-cleanup-region</span>' for
cleaning up these problems."</span>
  (interactive (list current-prefix-arg))
  (whitespace-report-region (point-min) (point-max)
			    force report-if-bogus))


<span class="comment">;;;###<span class="warning">autoload</span></span>
(<span class="keyword">defun</span> <span class="function">whitespace-report-region</span> (start end <span class="type">&amp;optional</span> force report-if-bogus)
  <span class="string">"Report some whitespace problems in a region.

Return nil if there is no whitespace problem<span class="comment">; otherwise, return</span>
non-nil.

If FORCE is non-nil or \\[<span class="constant important">universal-argument</span>] was pressed just
before calling `<span class="constant important">whitespace-report-region</span>' interactively, it
forces `<span class="constant important">whitespace-style</span>' to have:

   empty
   indentation
   space-before-tab
   trailing
   space-after-tab

If REPORT-IF-BOGUS is non-nil, it reports only when there are any
whitespace problems in buffer.

Report if some of the following whitespace problems exist:

* If `<span class="constant important">indent-tabs-mode</span>' is non-nil:
   empty		1. empty lines at beginning of buffer.
   empty		2. empty lines at end of buffer.
   trailing		3. SPACEs or TABs at end of line.
   indentation		4. 8 or more SPACEs at beginning of line.
   space-before-tab	5. SPACEs before TAB.
   space-after-tab	6. 8 or more SPACEs after TAB.

* If `<span class="constant important">indent-tabs-mode</span>' is nil:
   empty		1. empty lines at beginning of buffer.
   empty		2. empty lines at end of buffer.
   trailing		3. SPACEs or TABs at end of line.
   indentation		4. TABS at beginning of line.
   space-before-tab	5. SPACEs before TAB.
   space-after-tab	6. 8 or more SPACEs after TAB.

See `<span class="constant important">whitespace-style</span>' for documentation.
See also `<span class="constant important">whitespace-cleanup</span>' and `<span class="constant important">whitespace-cleanup-region</span>' for
cleaning up these problems."</span>
  (interactive <span class="string">"r"</span>)
  (setq force (or current-prefix-arg force))
  (<span class="keyword elisp">save-excursion</span>
    (<span class="keyword elisp">save-match-data</span>
      (<span class="keyword elisp">let</span>* ((has-bogus nil)
	     (rstart    (min start end))
	     (rend      (max start end))
	     (bogus-list
	      (mapcar
	       #'(<span class="keyword elisp">lambda</span> (option)
		   (<span class="keyword cl">when</span> force
		     (add-to-list 'whitespace-style (car option)))
		   (goto-char rstart)
		   (<span class="keyword elisp">let</span> ((regexp
			  (<span class="keyword elisp">cond</span>
			   ((eq (car option) 'indentation)
			    (whitespace-indentation-regexp))
			   ((eq (car option) 'indentation<span class="builtin">::tab</span>)
			    (whitespace-indentation-regexp 'tab))
			   ((eq (car option) 'indentation<span class="builtin">::space</span>)
			    (whitespace-indentation-regexp 'space))
			   ((eq (car option) 'space-after-tab)
			    (whitespace-space-after-tab-regexp))
			   ((eq (car option) 'space-after-tab<span class="builtin">::tab</span>)
			    (whitespace-space-after-tab-regexp 'tab))
			   ((eq (car option) 'space-after-tab<span class="builtin">::space</span>)
			    (whitespace-space-after-tab-regexp 'space))
			   (t
			    (cdr option)))))
		     (and (re-search-forward regexp rend t)
			  (setq has-bogus t))))
	       whitespace-report-list)))
	(<span class="keyword cl">when</span> (<span class="keyword elisp">if</span> report-if-bogus has-bogus t)
	  (whitespace-kill-buffer whitespace-report-buffer-name)
	  <span class="comment">;; `<span class="constant important">whitespace-indent-tabs-mode</span>' is local to current buffer</span>
	  <span class="comment">;; `<span class="constant important">whitespace-tab-width</span>' is local to current buffer</span>
	  (<span class="keyword elisp">let</span> ((ws-indent-tabs-mode whitespace-indent-tabs-mode)
		(ws-tab-width whitespace-tab-width))
	    (<span class="keyword elisp">with-current-buffer</span> (get-buffer-create
				  whitespace-report-buffer-name)
	      (erase-buffer)
	      (insert (<span class="keyword elisp">if</span> ws-indent-tabs-mode
			  (car whitespace-report-text)
			(cdr whitespace-report-text)))
	      (goto-char (point-min))
	      (forward-line 3)
	      (<span class="keyword cl">dolist</span> (option whitespace-report-list)
		(forward-line 1)
		(whitespace-mark-x
		 27 (memq (car option) whitespace-style))
		(whitespace-mark-x 7 (car bogus-list))
		(setq bogus-list (cdr bogus-list)))
	      (forward-line 1)
	      (whitespace-insert-value ws-indent-tabs-mode)
	      (whitespace-insert-value ws-tab-width)
	      (<span class="keyword cl">when</span> has-bogus
		(goto-char (point-max))
		(insert <span class="string">" Type `M-x whitespace-cleanup'"</span>
			<span class="string">" to cleanup the buffer.\n\n"</span>
			<span class="string">" Type `M-x whitespace-cleanup-region'"</span>
			<span class="string">" to cleanup a region.\n\n"</span>))
	      (whitespace-display-window (current-buffer)))))
	has-bogus))))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; Internal functions</span>


(<span class="keyword">defvar</span> <span class="variable">whitespace-font-lock-mode</span> nil
  <span class="string">"Used to remember whether a buffer had font lock mode on or not."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-font-lock</span> nil
  <span class="string">"Used to remember whether a buffer initially had font lock on or not."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-font-lock-keywords</span> nil
  <span class="string">"Used to save locally `<span class="constant important">font-lock-keywords</span>' value."</span>)


(<span class="keyword">defconst</span> <span class="variable">whitespace-help-text</span>
  <span class="string">"\
 Whitespace Toggle Options                  | scroll up  :  SPC   or &gt; |
                                            | scroll down:  M-SPC or &lt; |
 FACES                                      \\__________________________/
 []  f   - toggle face visualization
 []  t   - toggle TAB visualization
 []  s   - toggle SPACE and HARD SPACE visualization
 []  r   - toggle trailing blanks visualization
 []  l   - toggle \"long lines\" visualization
 []  L   - toggle \"long lines\" tail visualization
 []  n   - toggle NEWLINE visualization
 []  e   - toggle empty line at bob and/or eob visualization
 []  C-i - toggle indentation SPACEs visualization (via `<span class="constant important">indent-tabs-mode</span>')
 []  I   - toggle indentation SPACEs visualization
 []  i   - toggle indentation TABs visualization
 []  C-a - toggle SPACEs after TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
 []  A   - toggle SPACEs after TAB: SPACEs visualization
 []  a   - toggle SPACEs after TAB: TABs visualization
 []  C-b - toggle SPACEs before TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
 []  B   - toggle SPACEs before TAB: SPACEs visualization
 []  b   - toggle SPACEs before TAB: TABs visualization

 DISPLAY TABLE
 []  T - toggle TAB visualization
 []  S - toggle SPACE and HARD SPACE visualization
 []  N - toggle NEWLINE visualization

      x - restore `<span class="constant important">whitespace-style</span>' value

      ? - display this text\n\n"</span>
  <span class="string">"Text for whitespace toggle options."</span>)


(<span class="keyword">defconst</span> <span class="variable">whitespace-help-buffer-name</span> <span class="string">"*Whitespace Toggle Options*"</span>
  <span class="string">"The buffer name for whitespace toggle options."</span>)


(<span class="keyword">defun</span> <span class="function">whitespace-insert-value</span> (value)
  <span class="string">"Insert VALUE at column 20 of next line."</span>
  (forward-line 1)
  (move-to-column 20 t)
  (insert (format <span class="string">"%s"</span> value)))


(<span class="keyword">defun</span> <span class="function">whitespace-mark-x</span> (nchars condition)
  <span class="string">"Insert the mark ('X' or ' ') after NCHARS depending on CONDITION."</span>
  (forward-char nchars)
  (insert (<span class="keyword elisp">if</span> condition <span class="string">"X"</span> <span class="string">" "</span>)))


(<span class="keyword">defun</span> <span class="function">whitespace-insert-option-mark</span> (<span class="keyword cl">the</span>-list the-value)
  <span class="string">"Insert the option mark ('X' or ' ') in toggle options buffer."</span>
  (goto-char (point-min))
  (forward-line 2)
  (<span class="keyword cl">dolist</span> (sym  the-list)
    (<span class="keyword elisp">if</span> (eq sym 'help-newline)
	(forward-line 2)
      (forward-line 1)
      (whitespace-mark-x 2 (memq sym the-value)))))


(<span class="keyword">defun</span> <span class="function">whitespace-help-on</span> (style)
  <span class="string">"Display the whitespace toggle options."</span>
  (<span class="keyword cl">unless</span> (get-buffer whitespace-help-buffer-name)
    (delete-other-windows)
    (<span class="keyword elisp">let</span> ((buffer (get-buffer-create whitespace-help-buffer-name)))
      (<span class="keyword elisp">with-current-buffer</span> buffer
	(erase-buffer)
	(insert whitespace-help-text)
	(whitespace-insert-option-mark
	 whitespace-style-value-list style)
	(whitespace-display-window buffer)))))


(<span class="keyword">defun</span> <span class="function">whitespace-display-window</span> (buffer)
  <span class="string">"Display BUFFER in a new window."</span>
  (goto-char (point-min))
  (set-buffer-modified-p nil)
  (<span class="keyword cl">when</span> (&lt; (window-height) (* 2 window-min-height))
    (kill-buffer buffer)
    (<span class="warning">error</span> <span class="string">"Window height is too small<span class="comment">; \</span>
can't split window to display whitespace toggle options"</span>))
  (<span class="keyword elisp">let</span> ((win (split-window)))
    (set-window-buffer win buffer)
    (shrink-window-if-larger-than-buffer win)))


(<span class="keyword">defun</span> <span class="function">whitespace-kill-buffer</span> (buffer-name)
  <span class="string">"Kill buffer BUFFER-NAME and windows related with it."</span>
  (<span class="keyword elisp">let</span> ((buffer (get-buffer buffer-name)))
    (<span class="keyword cl">when</span> buffer
      (delete-windows-on buffer)
      (kill-buffer buffer))))


(<span class="keyword">defun</span> <span class="function">whitespace-help-off</span> ()
  <span class="string">"Remove the buffer and window of the whitespace toggle options."</span>
  (whitespace-kill-buffer whitespace-help-buffer-name))


(<span class="keyword">defun</span> <span class="function">whitespace-help-scroll</span> (<span class="type">&amp;optional</span> up)
  <span class="string">"Scroll help window, if it exists.

If UP is non-nil, scroll up<span class="comment">; otherwise, scroll down."</span></span>
  (<span class="keyword elisp">condition-case</span> nil
      (<span class="keyword elisp">let</span> ((buffer (get-buffer whitespace-help-buffer-name)))
	(<span class="keyword elisp">if</span> buffer
	    (<span class="keyword elisp">with-selected-window</span> (get-buffer-window buffer)
	      (<span class="keyword elisp">if</span> up
		  (scroll-up 3)
		(scroll-down 3)))
	  (ding)))
    <span class="comment">;; handler</span>
    ((<span class="warning">error</span>)
     <span class="comment">;; just ignore error</span>
     )))


(<span class="keyword">defun</span> <span class="function">whitespace-interactive-char</span> (local-p)
  <span class="string">"Interactive function to read a char and return a symbol.

If LOCAL-P is non-nil, it uses a local context<span class="comment">; otherwise, it</span>
uses a global context.

It accepts one of the following chars:

  CHAR	MEANING
  (VIA FACES)
   f	toggle face visualization
   t	toggle TAB visualization
   s	toggle SPACE and HARD SPACE visualization
   r	toggle trailing blanks visualization
   l	toggle \"long lines\" visualization
   L	toggle \"long lines\" tail visualization
   n	toggle NEWLINE visualization
   e	toggle empty line at bob and/or eob visualization
   C-i	toggle indentation SPACEs visualization (via `<span class="constant important">indent-tabs-mode</span>')
   I	toggle indentation SPACEs visualization
   i	toggle indentation TABs visualization
   C-a	toggle SPACEs after TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   A	toggle SPACEs after TAB: SPACEs visualization
   a	toggle SPACEs after TAB: TABs visualization
   C-b	toggle SPACEs before TAB visualization (via `<span class="constant important">indent-tabs-mode</span>')
   B	toggle SPACEs before TAB: SPACEs visualization
   b	toggle SPACEs before TAB: TABs visualization

  (VIA DISPLAY TABLE)
   T	toggle TAB visualization
   S	toggle SPACE and HARD SPACE visualization
   N	toggle NEWLINE visualization

   x	restore `<span class="constant important">whitespace-style</span>' value
   ?	display brief help

See also `<span class="constant important">whitespace-toggle-option-alist</span>'."</span>
  (<span class="keyword elisp">let</span>* ((is-off (not (<span class="keyword elisp">if</span> local-p
			  whitespace-mode
			global-whitespace-mode)))
	 (style  (<span class="keyword elisp">cond</span> (is-off  whitespace-style) <span class="comment">; use default value</span>
		       (local-p whitespace-active-style)
		       (t       whitespace-toggle-style)))
	 (prompt
	  (format <span class="string">"Whitespace Toggle %s (type ? for further options)-"</span>
		  (<span class="keyword elisp">if</span> local-p <span class="string">"Local"</span> <span class="string">"Global"</span>)))
	 ch sym)
    <span class="comment">;; read a valid option and get the corresponding symbol</span>
    (<span class="keyword elisp">save-window-excursion</span>
      (<span class="keyword elisp">condition-case</span> data
	  (<span class="keyword elisp">progn</span>
	    (<span class="keyword elisp">while</span>
		<span class="comment">;; while condition</span>
		(<span class="keyword elisp">progn</span>
		  (setq ch (read-char prompt))
		  (not
		   (setq sym
			 (cdr
			  (assq ch whitespace-toggle-option-alist)))))
	      <span class="comment">;; while body</span>
	      (<span class="keyword elisp">cond</span>
	       ((eq ch ?\?)   (whitespace-help-on style))
	       ((eq ch ?\ )   (whitespace-help-scroll t))
	       ((eq ch ?\M- ) (whitespace-help-scroll))
	       ((eq ch ?&gt;)    (whitespace-help-scroll t))
	       ((eq ch ?&lt;)    (whitespace-help-scroll))
	       (t             (ding))))
	    (whitespace-help-off)
	    (message <span class="string">" "</span>))		<span class="comment">; clean echo area</span>
	<span class="comment">;; handler</span>
	((quit error)
	 (whitespace-help-off)
	 (<span class="warning">error</span> (<span class="warning">error</span>-message-string data)))))
    (list sym)))			<span class="comment">; return the appropriate symbol</span>


(<span class="keyword">defun</span> <span class="function">whitespace-toggle-list</span> (local-p arg the-list)
  <span class="string">"Toggle options in THE-LIST based on list ARG.

If LOCAL-P is non-nil, it uses a local context<span class="comment">; otherwise, it</span>
uses a global context.

ARG is a list of options to be toggled.

THE-LIST is a list of options.  This list will be toggled and the
resultant list will be returned."</span>
  (<span class="keyword cl">unless</span> (<span class="keyword elisp">if</span> local-p whitespace-mode global-whitespace-mode)
    (setq the-list whitespace-style))
  (setq the-list (copy-sequence the-list)) <span class="comment">; keep original list</span>
  (<span class="keyword cl">dolist</span> (sym (<span class="keyword elisp">if</span> (listp arg) arg (list arg)))
    (<span class="keyword elisp">cond</span>
     <span class="comment">;; ignore help value</span>
     ((eq sym 'help-newline))
     <span class="comment">;; restore default values</span>
     ((eq sym 'whitespace-style)
      (setq the-list whitespace-style))
     <span class="comment">;; toggle valid values</span>
     ((memq sym whitespace-style-value-list)
      (setq the-list (<span class="keyword elisp">if</span> (memq sym the-list)
			 (delq sym the-list)
		       (cons sym the-list))))))
  the-list)


(<span class="keyword">defvar</span> <span class="variable">whitespace-display-table</span> nil
  <span class="string">"Used to save a local display table."</span>)

(<span class="keyword">defvar</span> <span class="variable">whitespace-display-table-was-local</span> nil
  <span class="string">"Used to remember whether a buffer initially had a local display table."</span>)


(<span class="keyword">defun</span> <span class="function">whitespace-turn-on</span> ()
  <span class="string">"Turn on whitespace visualization."</span>
  <span class="comment">;; prepare local hooks</span>
  (add-hook 'write-file-functions 'whitespace-write-file-hook nil t)
  <span class="comment">;; create whitespace local buffer environment</span>
  (set (make-local-variable 'whitespace-font-lock-mode) nil)
  (set (make-local-variable 'whitespace-font-lock) nil)
  (set (make-local-variable 'whitespace-font-lock-keywords) nil)
  (set (make-local-variable 'whitespace-display-table) nil)
  (set (make-local-variable 'whitespace-display-table-was-local) nil)
  (set (make-local-variable 'whitespace-active-style)
       (<span class="keyword elisp">if</span> (listp whitespace-style)
	   whitespace-style
	 (list whitespace-style)))
  (set (make-local-variable 'whitespace-indent-tabs-mode)
       indent-tabs-mode)
  (set (make-local-variable 'whitespace-tab-width)
       tab-width)
  <span class="comment">;; turn on whitespace</span>
  (<span class="keyword cl">when</span> whitespace-active-style
    (whitespace-color-on)
    (whitespace-display-char-on)))


(<span class="keyword">defun</span> <span class="function">whitespace-turn-off</span> ()
  <span class="string">"Turn off whitespace visualization."</span>
  (remove-hook 'write-file-functions 'whitespace-write-file-hook t)
  (<span class="keyword cl">when</span> whitespace-active-style
    (whitespace-color-off)
    (whitespace-display-char-off)))


(<span class="keyword">defun</span> <span class="function">whitespace-style-face-p</span> ()
  <span class="string">"Return t if there is some visualization via face."</span>
  (and (memq 'face whitespace-active-style)
       (or (memq 'tabs                    whitespace-active-style)
	   (memq 'spaces                  whitespace-active-style)
	   (memq 'trailing                whitespace-active-style)
	   (memq 'lines                   whitespace-active-style)
	   (memq 'lines-tail              whitespace-active-style)
	   (memq 'newline                 whitespace-active-style)
	   (memq 'empty                   whitespace-active-style)
	   (memq 'indentation             whitespace-active-style)
	   (memq 'indentation<span class="builtin">::tab</span>        whitespace-active-style)
	   (memq 'indentation<span class="builtin">::space</span>      whitespace-active-style)
	   (memq 'space-after-tab         whitespace-active-style)
	   (memq 'space-after-tab<span class="builtin">::tab</span>    whitespace-active-style)
	   (memq 'space-after-tab<span class="builtin">::space</span>  whitespace-active-style)
	   (memq 'space-before-tab        whitespace-active-style)
	   (memq 'space-before-tab<span class="builtin">::tab</span>   whitespace-active-style)
	   (memq 'space-before-tab<span class="builtin">::space</span> whitespace-active-style))))


(<span class="keyword">defun</span> <span class="function">whitespace-color-on</span> ()
  <span class="string">"Turn on color visualization."</span>
  (<span class="keyword cl">when</span> (whitespace-style-face-p)
    (<span class="keyword cl">unless</span> whitespace-font-lock
      (setq whitespace-font-lock t
	    whitespace-font-lock-keywords
	    (copy-sequence font-lock-keywords)))
    <span class="comment">;; save current point and refontify when necessary</span>
    (set (make-local-variable 'whitespace-point)
	 (point))
    (set (make-local-variable 'whitespace-font-lock-refontify)
	 0)
    (set (make-local-variable 'whitespace-bob-marker)
	 (point-min-marker))
    (set (make-local-variable 'whitespace-eob-marker)
	 (point-max-marker))
    (set (make-local-variable 'whitespace-buffer-changed)
	 nil)
    (add-hook 'post-command-hook #'whitespace-post-command-hook nil t)
    (add-hook 'before-change-functions #'whitespace-buffer-changed nil t)
    <span class="comment">;; turn off font lock</span>
    (set (make-local-variable 'whitespace-font-lock-mode)
	 font-lock-mode)
    (font-lock-mode 0)
    <span class="comment">;; add whitespace-mode color into font lock</span>
    (<span class="keyword cl">when</span> (memq 'spaces whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs</span>
	(list whitespace-space-regexp  1 whitespace-space  t)
	<span class="comment">;; Show HARD SPACEs</span>
	(list whitespace-hspace-regexp 1 whitespace-hspace t))
       t))
    (<span class="keyword cl">when</span> (memq 'tabs whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show TABs</span>
	(list whitespace-tab-regexp 1 whitespace-tab t))
       t))
    (<span class="keyword cl">when</span> (memq 'trailing whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show trailing blanks</span>
	(list #'whitespace-trailing-regexp 1 whitespace-trailing t))
       t))
    (<span class="keyword cl">when</span> (or (memq 'lines      whitespace-active-style)
	      (memq 'lines-tail whitespace-active-style))
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show <span class="string">"long"</span> lines</span>
	(list
	 (<span class="keyword elisp">let</span> ((line-column (or whitespace-line-column fill-column)))
	   (format
	    <span class="string">"^\\([<span class="negation">^</span>\t\n]\\{%s\\}\\|[<span class="negation">^</span>\t\n]\\{0,%s\\}\t\\)\\{%d\\}%s\\(.+\\)$"</span>
	    whitespace-tab-width
	    (1- whitespace-tab-width)
	    (/ line-column whitespace-tab-width)
	    (<span class="keyword elisp">let</span> ((rem (% line-column whitespace-tab-width)))
	      (<span class="keyword elisp">if</span> (zerop rem)
		  <span class="string">""</span>
		(format <span class="string">".\\{%d\\}"</span> rem)))))
	 (<span class="keyword elisp">if</span> (memq 'lines whitespace-active-style)
	     0				<span class="comment">; whole line</span>
	   2)				<span class="comment">; line tail</span>
	 whitespace-line t))
       t))
    (<span class="keyword elisp">cond</span>
     ((memq 'space-before-tab whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs before TAB (indent-tabs-mode)</span>
	(list whitespace-space-before-tab-regexp
	      (<span class="keyword elisp">if</span> whitespace-indent-tabs-mode 1 2)
	      whitespace-space-before-tab t))
       t))
     ((memq 'space-before-tab<span class="builtin">::tab</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs before TAB (SPACEs)</span>
	(list whitespace-space-before-tab-regexp
	      1 whitespace-space-before-tab t))
       t))
     ((memq 'space-before-tab<span class="builtin">::space</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs before TAB (TABs)</span>
	(list whitespace-space-before-tab-regexp
	      2 whitespace-space-before-tab t))
       t)))
    (<span class="keyword elisp">cond</span>
     ((memq 'indentation whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show indentation SPACEs (indent-tabs-mode)</span>
	(list (whitespace-indentation-regexp)
	      1 whitespace-indentation t))
       t))
     ((memq 'indentation<span class="builtin">::tab</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show indentation SPACEs (SPACEs)</span>
	(list (whitespace-indentation-regexp 'tab)
	      1 whitespace-indentation t))
       t))
     ((memq 'indentation<span class="builtin">::space</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show indentation SPACEs (TABs)</span>
	(list (whitespace-indentation-regexp 'space)
	      1 whitespace-indentation t))
       t)))
    (<span class="keyword cl">when</span> (memq 'empty whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show empty lines at beginning of buffer</span>
	(list #'whitespace-empty-at-bob-regexp
	      1 whitespace-empty t))
       t)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show empty lines at end of buffer</span>
	(list #'whitespace-empty-at-eob-regexp
	      1 whitespace-empty t))
       t))
    (<span class="keyword elisp">cond</span>
     ((memq 'space-after-tab whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs after TAB (indent-tabs-mode)</span>
	(list (whitespace-space-after-tab-regexp)
	      1 whitespace-space-after-tab t))
       t))
     ((memq 'space-after-tab<span class="builtin">::tab</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs after TAB (SPACEs)</span>
	(list (whitespace-space-after-tab-regexp 'tab)
	      1 whitespace-space-after-tab t))
       t))
     ((memq 'space-after-tab<span class="builtin">::space</span> whitespace-active-style)
      (font-lock-add-keywords
       nil
       (list
	<span class="comment">;; Show SPACEs after TAB (TABs)</span>
	(list (whitespace-space-after-tab-regexp 'space)
	      1 whitespace-space-after-tab t))
       t)))
    <span class="comment">;; now turn on font lock and highlight blanks</span>
    (font-lock-mode 1)))


(<span class="keyword">defun</span> <span class="function">whitespace-color-off</span> ()
  <span class="string">"Turn off color visualization."</span>
  <span class="comment">;; turn off font lock</span>
  (<span class="keyword cl">when</span> (whitespace-style-face-p)
    (font-lock-mode 0)
    (remove-hook 'post-command-hook #'whitespace-post-command-hook t)
    (remove-hook 'before-change-functions #'whitespace-buffer-changed t)
    (<span class="keyword cl">when</span> whitespace-font-lock
      (setq whitespace-font-lock nil
	    font-lock-keywords   whitespace-font-lock-keywords))
    <span class="comment">;; restore original font lock state</span>
    (font-lock-mode whitespace-font-lock-mode)))


(<span class="keyword">defun</span> <span class="function">whitespace-trailing-regexp</span> (limit)
  <span class="string">"Match trailing spaces which do not contain the point at end of line."</span>
  (<span class="keyword elisp">let</span> ((status t))
    (<span class="keyword elisp">while</span> (<span class="keyword elisp">if</span> (re-search-forward whitespace-trailing-regexp limit t)
	       (= whitespace-point (match-end 1)) <span class="comment">;; loop if point at eol</span>
	     (setq status nil)))		  <span class="comment">;; end of buffer</span>
    status))


(<span class="keyword">defun</span> <span class="function">whitespace-empty-at-bob-regexp</span> (limit)
  <span class="string">"Match spaces at beginning of buffer which do not contain the point at \
beginning of buffer."</span>
  (<span class="keyword elisp">let</span> ((b (point))
	r)
    (<span class="keyword elisp">cond</span>
     <span class="comment">;; at bob</span>
     ((= b 1)
      (setq r (and (/= whitespace-point 1)
		   (looking-at whitespace-empty-at-bob-regexp)))
      (set-marker whitespace-bob-marker (<span class="keyword elisp">if</span> r (match-end 1) b)))
     <span class="comment">;; inside bob empty region</span>
     ((&lt;= limit whitespace-bob-marker)
      (setq r (looking-at whitespace-empty-at-bob-regexp))
      (<span class="keyword elisp">if</span> r
	  (<span class="keyword cl">when</span> (&lt; (match-end 1) limit)
	    (set-marker whitespace-bob-marker (match-end 1)))
	(set-marker whitespace-bob-marker b)))
     <span class="comment">;; intersection with end of bob empty region</span>
     ((&lt;= b whitespace-bob-marker)
      (setq r (looking-at whitespace-empty-at-bob-regexp))
      (set-marker whitespace-bob-marker (<span class="keyword elisp">if</span> r (match-end 1) b)))
     <span class="comment">;; it is not inside bob empty region</span>
     (t
      (setq r nil)))
    <span class="comment">;; move to end of matching</span>
    (and r (goto-char (match-end 1)))
    r))


(<span class="keyword">defsubst</span> <span class="function">whitespace-looking-back</span> (regexp limit)
  (<span class="keyword elisp">save-excursion</span>
    (<span class="keyword cl">when</span> (/= 0 (skip-chars-backward <span class="string">" \t\n"</span> limit))
      (<span class="keyword cl">unless</span> (bolp)
	(forward-line 1))
      (looking-at regexp))))


(<span class="keyword">defun</span> <span class="function">whitespace-empty-at-eob-regexp</span> (limit)
  <span class="string">"Match spaces at end of buffer which do not contain the point at end of \
buffer."</span>
  (<span class="keyword elisp">let</span> ((b (point))
	(e (1+ (buffer-size)))
	r)
    (<span class="keyword elisp">cond</span>
     <span class="comment">;; at eob</span>
     ((= limit e)
      (<span class="keyword cl">when</span> (/= whitespace-point e)
	(goto-char limit)
	(setq r (whitespace-looking-back whitespace-empty-at-eob-regexp b)))
      (<span class="keyword elisp">if</span> r
	  (set-marker whitespace-eob-marker (match-beginning 1))
	(set-marker whitespace-eob-marker limit)
	(goto-char b)))			<span class="comment">; return back to initial position</span>
     <span class="comment">;; inside eob empty region</span>
     ((&gt;= b whitespace-eob-marker)
      (goto-char limit)
      (setq r (whitespace-looking-back whitespace-empty-at-eob-regexp b))
      (<span class="keyword elisp">if</span> r
	  (<span class="keyword cl">when</span> (&gt; (match-beginning 1) b)
	    (set-marker whitespace-eob-marker (match-beginning 1)))
	(set-marker whitespace-eob-marker limit)
	(goto-char b)))			<span class="comment">; return back to initial position</span>
     <span class="comment">;; intersection with beginning of eob empty region</span>
     ((&gt;= limit whitespace-eob-marker)
      (goto-char limit)
      (setq r (whitespace-looking-back whitespace-empty-at-eob-regexp b))
      (<span class="keyword elisp">if</span> r
	  (set-marker whitespace-eob-marker (match-beginning 1))
	(set-marker whitespace-eob-marker limit)
	(goto-char b)))			<span class="comment">; return back to initial position</span>
     <span class="comment">;; it is not inside eob empty region</span>
     (t
      (setq r nil)))
    r))


(<span class="keyword">defun</span> <span class="function">whitespace-buffer-changed</span> (_beg _end)
  <span class="string">"Set `<span class="constant important">whitespace-buffer-changed</span>' variable to t."</span>
  (setq whitespace-buffer-changed t))


(<span class="keyword">defun</span> <span class="function">whitespace-post-command-hook</span> ()
  <span class="string">"Save current point into `<span class="constant important">whitespace-point</span>' variable.
Also refontify when necessary."</span>
  (setq whitespace-point (point))	<span class="comment">; current point position</span>
  (<span class="keyword elisp">let</span> ((refontify
	 (or
	  <span class="comment">;; it is at end of line ...</span>
	  (and (eolp)
	       <span class="comment">;; ... with trailing SPACE or TAB</span>
	       (or (= (preceding-char) ?\ )
		   (= (preceding-char) ?\t)))
	  <span class="comment">;; it is at beginning of buffer (bob)</span>
	  (= whitespace-point 1)
	  <span class="comment">;; the buffer was modified and ...</span>
	  (and whitespace-buffer-changed
	       (or
		<span class="comment">;; ... or inside bob whitespace region</span>
		(&lt;= whitespace-point whitespace-bob-marker)
		<span class="comment">;; ... or at bob whitespace region border</span>
		(and (= whitespace-point (1+ whitespace-bob-marker))
		     (= (preceding-char) ?\n))))
	  <span class="comment">;; it is at end of buffer (eob)</span>
	  (= whitespace-point (1+ (buffer-size)))
	  <span class="comment">;; the buffer was modified and ...</span>
	  (and whitespace-buffer-changed
	       (or
		<span class="comment">;; ... or inside eob whitespace region</span>
	        (&gt;= whitespace-point whitespace-eob-marker)
		<span class="comment">;; ... or at eob whitespace region border</span>
		(and (= whitespace-point (1- whitespace-eob-marker))
		     (= (following-char) ?\n)))))))
    (<span class="keyword cl">when</span> (or refontify (&gt; whitespace-font-lock-refontify 0))
      (setq whitespace-buffer-changed nil)
      <span class="comment">;; adjust refontify counter</span>
      (setq whitespace-font-lock-refontify
	    (<span class="keyword elisp">if</span> refontify
		1
	      (1- whitespace-font-lock-refontify)))
      <span class="comment">;; refontify</span>
      (jit-lock-refontify))))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; Hacked from visws.el (Miles Bader &lt;miles@gnu.org&gt;)</span>


(<span class="keyword">defun</span> <span class="function">whitespace-style-mark-p</span> ()
  <span class="string">"Return t if there is some visualization via display table."</span>
  (or (memq 'tab-mark     whitespace-active-style)
      (memq 'space-mark   whitespace-active-style)
      (memq 'newline-mark whitespace-active-style)))


(<span class="keyword">defalias</span> '<span class="function">whitespace-characterp</span>
  (<span class="keyword elisp">if</span> (fboundp 'characterp)
      'characterp
    'char-valid-p))


(<span class="keyword">defsubst</span> <span class="function">whitespace-char-valid-p</span> (char)
  <span class="comment">;; This check should be improved!!!</span>
  (or (&lt; char 256)
      (whitespace-characterp char)))


(<span class="keyword">defun</span> <span class="function">whitespace-display-vector-p</span> (vec)
  <span class="string">"Return true if every character in vector VEC can be displayed."</span>
  (<span class="keyword elisp">let</span> ((i (length vec)))
    (<span class="keyword cl">when</span> (&gt; i 0)
      (<span class="keyword elisp">while</span> (and (&gt;= (setq i (1- i)) 0)
		  (whitespace-char-valid-p (aref vec i))))
      (&lt; i 0))))


(<span class="keyword">defun</span> <span class="function">whitespace-display-char-on</span> ()
  <span class="string">"Turn on character display mapping."</span>
  (<span class="keyword cl">when</span> (and whitespace-display-mappings
	     (whitespace-style-mark-p))
    (<span class="keyword elisp">let</span> (vecs vec)
      <span class="comment">;; Remember whether a buffer has a local display table.</span>
      (<span class="keyword cl">unless</span> whitespace-display-table-was-local
	(setq whitespace-display-table-was-local t
	      whitespace-display-table
	      (copy-sequence buffer-display-table))
	<span class="comment">;; asure `<span class="constant important">buffer-display-table</span>' is unique</span>
	<span class="comment">;; when two or more windows are visible.</span>
	(setq buffer-display-table
	      (copy-sequence buffer-display-table)))
      (<span class="keyword cl">unless</span> buffer-display-table
	(setq buffer-display-table (make-display-table)))
      (<span class="keyword cl">dolist</span> (entry whitespace-display-mappings)
	<span class="comment">;; check if it is to display this mark</span>
	(<span class="keyword cl">when</span> (memq (car entry) whitespace-style)
	  <span class="comment">;; Get a displayable mapping.</span>
	  (setq vecs (cddr entry))
	  (<span class="keyword elisp">while</span> (and vecs
		      (not (whitespace-display-vector-p (car vecs))))
	    (setq vecs (cdr vecs)))
	  <span class="comment">;; Display a valid mapping.</span>
	  (<span class="keyword cl">when</span> vecs
	    (setq vec (copy-sequence (car vecs)))
	    <span class="comment">;; NEWLINE char</span>
	    (<span class="keyword cl">when</span> (and (eq (cadr entry) ?\n)
		       (memq 'newline whitespace-active-style))
	      <span class="comment">;; Only insert face bits on NEWLINE char mapping to avoid</span>
	      <span class="comment">;; obstruction of other faces like TABs and (HARD) SPACEs</span>
	      <span class="comment">;; faces, font-lock faces, etc.</span>
	      (<span class="keyword cl">dotimes</span> (i (length vec))
		<span class="comment">;; Only for Emacs 21 and 22<span class="builtin">:</span></span>
		<span class="comment">;; Due to limitations of glyph representation, the char</span>
		<span class="comment">;; code can not be above ?\x1FFFF.  This is already</span>
		<span class="comment">;; fixed in Emacs 23.</span>
		(or (eq (aref vec i) ?\n)
		    (and (&lt; emacs-major-version 23)
			 (&gt; (aref vec i) #x1FFFF))
		    (aset vec i
			  (make-glyph-code (aref vec i)
					   whitespace-newline)))))
	    <span class="comment">;; Display mapping</span>
	    (aset buffer-display-table (cadr entry) vec)))))))


(<span class="keyword">defun</span> <span class="function">whitespace-display-char-off</span> ()
  <span class="string">"Turn off character display mapping."</span>
  (and whitespace-display-mappings
       (whitespace-style-mark-p)
       whitespace-display-table-was-local
       (setq whitespace-display-table-was-local nil
	     buffer-display-table whitespace-display-table)))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>
<span class="comment">;;;; Hook</span>


(<span class="keyword">defun</span> <span class="function">whitespace-action-when-on</span> ()
  <span class="string">"Action to be taken always when local whitespace is turned on."</span>
  (<span class="keyword elisp">cond</span> ((memq 'cleanup whitespace-action)
	 (whitespace-cleanup))
	((memq 'report-on-bogus whitespace-action)
	 (whitespace-report nil t))))


(<span class="keyword">defun</span> <span class="function">whitespace-write-file-hook</span> ()
  <span class="string">"Action to be taken when buffer is written.
It should be added buffer-locally to `<span class="constant important">write-file-functions</span>'."</span>
  (<span class="keyword elisp">cond</span> ((memq 'auto-cleanup whitespace-action)
	 (whitespace-cleanup))
	((memq 'abort-on-bogus whitespace-action)
	 (<span class="keyword cl">when</span> (whitespace-report nil t)
	   (<span class="warning">error</span> <span class="string">"Abort write due to whitespace problems in %s"</span>
		  (buffer-name)))))
  nil)					<span class="comment">; continue hook processing</span>


(<span class="keyword">defun</span> <span class="function">whitespace-warn-read-only</span> (msg)
  <span class="string">"Warn if buffer is read-only."</span>
  (<span class="keyword cl">when</span> (memq 'warn-if-read-only whitespace-action)
    (message <span class="string">"Can't %s: %s is read-only"</span> msg (buffer-name))))

 
<span class="comment">;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;</span>


(<span class="keyword">defun</span> <span class="function">whitespace-unload-function</span> ()
  <span class="string">"Unload the whitespace library."</span>
  (global-whitespace-mode -1)
  <span class="comment">;; be sure all local whitespace mode is turned off</span>
  (<span class="keyword elisp">save-current-buffer</span>
    (<span class="keyword cl">dolist</span> (buf (buffer-list))
      (set-buffer buf)
      (whitespace-mode -1)))
  nil)					<span class="comment">; continue standard unloading</span>


(<span class="keyword">provide</span> '<span class="constant">whitespace</span>)


(run-hooks 'whitespace-load-hook)


<span class="comment">;;; whitespace.el ends here</span></pre></div><div class="wrapper close"></div></div><div class="footer"><hr /><span class="translation bar"><br />  <a href="http://www.emacswiki.org/emacs?action=translate;id=whitespace.el;missing=de_es_fr_it_ja_ko_pt_ru_se_uk_zh" class="translation new" rel="nofollow">Add Translation</a></span><div class="edit bar"><a accesskey="c" href="http://www.emacswiki.org/emacs/Comments_on_whitespace.el" class="comment local">Talk</a> <a href="http://www.emacswiki.org/emacs?action=edit;id=whitespace.el" accesskey="e" rel="nofollow" title="Click to edit this page" class="edit">Edit this page</a> <a rel="nofollow" class="history" href="http://www.emacswiki.org/emacs?action=history;id=whitespace.el">View other revisions</a> <a href="http://www.emacswiki.org/emacs?action=admin;id=whitespace.el" rel="nofollow" class="admin">Administration</a></div><div class="time">Last edited 2013-05-16 14:05 UTC by <a class="author" title="97-223-254-62.static.virginmedia.com" href="http://www.emacswiki.org/emacs/JeremyMoore">JeremyMoore</a> <a href="http://www.emacswiki.org/emacs?action=browse;diff=2;id=whitespace.el" rel="nofollow" class="diff">(diff)</a></div><div style="float:right; margin-left:1ex;">
<!-- Creative Commons License -->
<a class="licence" href="http://creativecommons.org/licenses/GPL/2.0/"><img alt="CC-GNU GPL" style="border:none" src="/pics/cc-GPL-a.png" /></a>
<!-- /Creative Commons License -->
</div>

<!--
<rdf:RDF xmlns="http://web.resource.org/cc/"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
<Work rdf:about="">
   <license rdf:resource="http://creativecommons.org/licenses/GPL/2.0/" />
  <dc:type rdf:resource="http://purl.org/dc/dcmitype/Software" />
</Work>

<License rdf:about="http://creativecommons.org/licenses/GPL/2.0/">
   <permits rdf:resource="http://web.resource.org/cc/Reproduction" />
   <permits rdf:resource="http://web.resource.org/cc/Distribution" />
   <requires rdf:resource="http://web.resource.org/cc/Notice" />
   <permits rdf:resource="http://web.resource.org/cc/DerivativeWorks" />
   <requires rdf:resource="http://web.resource.org/cc/ShareAlike" />
   <requires rdf:resource="http://web.resource.org/cc/SourceCode" />
</License>
</rdf:RDF>
-->

<p class="legal">
This work is licensed to you under version 2 of the
<a href="http://www.gnu.org/">GNU</a> <a href="/GPL">General Public License</a>.
Alternatively, you may choose to receive this work under any other
license that grants the right to use, copy, modify, and/or distribute
the work, as long as that license imposes the restriction that
derivative works have to grant the same rights and impose the same
restriction. For example, you may choose to receive this work under
the
<a href="http://www.gnu.org/">GNU</a>
<a href="/FDL">Free Documentation License</a>, the
<a href="http://creativecommons.org/">CreativeCommons</a>
<a href="http://creativecommons.org/licenses/sa/1.0/">ShareAlike</a>
License, the XEmacs manual license, or
<a href="/OLD">similar licenses</a>.
</p>
</div>
</body>
</html>
