%
% This file is copyright (C) 2003 Sam Noble. It may be modified so long
% as my name is not removed and the modifier adds his name to the file.
% Redistribution permitted.
%
% 27 Jan 2004	Sam Noble	Removed tocbibind dependency.
% 04 Dec 2001 	Sam Noble	Class file
% 03 Sep 1995	David Perkinson	Title Page
% Acknowledgements Page, David Perkinson & Sam Noble
% May 2005 Patrick Carlisle Table of contents chapter definition
% 2004-2005 Ben Salzberg (BTS) a variety of tweaks here and in the template
% 2025 Sam Gauck rewrite and drastically simplify template
%
% Oddities:
%
%   We *ASSUME* that any time \cleardoublepage is called
%  we actually want a blank back side with NO page number/heading
%
%   Minor bug -- seems to be a more general LaTeX thing:
%  If you use \frontmatter \mainmatter without any chapters inbetween
%  be prepared to have the page numbering messed up. Not a big deal,
%  but I'm not sure how to fix it.
%
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reedthesis}[2025/03/14 The Reed College Thesis Class]

\LoadClassWithOptions{book}

\RequirePackage[
    margin=1in,
    bindingoffset=0.5in
]{geometry}

\RequirePackage[
    hidelinks
]{hyperref}

\RequirePackage{biblatex}

\addbibresource{bibliography.bib}

\RequirePackage{fancyhdr}
% TODO: lets make style options enabled by default l&r
% This adds the ToC dots between section titles and their respective (bolded) page numbers.
\DeclareOption{tocsectiondots}{
  \renewcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\normalfont
      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\bfseries \hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
}
% Until necessary, we process options in order of declaration.
\ProcessOptions\relax
% Stolen from latex.ltx and modified
% to set pagestyle to empty on the
% inserted (left-hand) page
\newcommand{\RTcleardoublepage}{
	\clearpage\if@twoside \ifodd\c@page\else
	\thispagestyle{empty}\hbox{}\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}

% All usages of \cleardoublepage should honor
% the behavior described above.
\let\RToldcleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{\RTcleardoublepage}

% Stolen from book.cls and modified
% to set pagestyle to empty instead of plain
% on the first page of each chapter
\let\RToldchapter\chapter
\renewcommand{\chapter}{\if@openright\cleardoublepage\else\clearpage\fi
                    \thispagestyle{empty}%
                    \global\@topnum\z@
                    \@afterindentfalse
                    \secdef\@chapter\@schapter}

% % adjust margins for binding  (changed 2007-04-24 tgp)
% \setlength{\oddsidemargin}{.5in}
% \setlength{\evensidemargin}{0in}
% \setlength{\textwidth}{6.0in}
% \setlength{\textheight}{9.0in}
% \setlength\topmargin{0in}
% \addtolength\topmargin{-\headheight}
% \addtolength\topmargin{-\headsep}

\def\division#1{\gdef \@division{#1}}
\def\@division{\@latex@warning@no@line{No \noexpand\division given}}
\def\department#1{\gdef \@department{#1}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\def\thedivisionof#1{\gdef \@thedivisionof{#1}}
\def\@thedivisionof{The Division of}
\def\approvedforthe#1{\gdef \@approvedforthe{#1}}
\def\@approvedforthe{Division}
\def\advisor#1{\gdef \@advisor{#1}}
\def\@advisor{\@latex@warning@no@line{No \noexpand\advisor given}}
\def\altadvisor#1{\gdef \@altadvisor{#1} \@altadvisortrue}
\global\let\@altadvisor\@empty
\newif\if@altadvisor
\@altadvisorfalse

\renewcommand{\contentsname}{Table of Contents}
% \renewcommand{\bibname}{References}

\ifx\@pdfoutput\@undefined
  \newcommand{\RTpercent}{\@percentchar\space}
  \AtBeginDvi{\special{!\RTpercent Reed College LaTeX Thesis Class 2001/12/04 SN}} 
  \AtBeginDvi{\special{rawpostscript \RTpercent Reed College LaTeX Thesis Class 2001/12/04 SN}} 
\else
  \AtEndDocument{\pdfinfo{/Creator	(Reed College LaTeX Thesis Class 2001/12/04 SN)}} 
\fi

% I hacked the title page to all be the same font size 
% as requested by the library, BTS 2005

\renewcommand{\maketitle}{%
  {\pagestyle{empty}
  \fontsize{12}{14}\selectfont
  \begin{titlepage}
  \newpage
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks

  \baselineskip = 1.4\baselineskip
  \setbox0=\hbox{of the Requirements for the Degree}

  \begin{center}
    \setcounter{page}{1}
    \null\vfil
    {\fontsize{12}{14}\selectfont \@title}
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \vfil
    A Thesis \\
    Presented to \\
    \@thedivisionof \ \@division \\
    Reed College
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \vfil
    In Partial Fulfillment \\
    of the Requirements for the Degree \\
    Bachelor of Arts
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \bigskip
    \centerline{}
    \bigskip
    {\fontsize{12}{14}\selectfont \lineskip .75em
    \begin{tabular}[t]{c}%
      \@author
    \end{tabular}\par}
    \vskip 1.5em
    {\fontsize{12}{14}\selectfont \@date \par}
  \end{center}\par
  \end{titlepage}

%% Approved for the division page
  \cleardoublepage
  {\fontsize{12}{14}
  \setbox0=\hbox{Approved for the \@approvedforthe}
  \thispagestyle{empty}
  \null\vfil		% just below center of page
  \par\vskip 6cm	% below center, not center
  \centerline{\copy0}	% approved
  \centerline{(\@department)} %major
  \vskip 1cm		%space to sign
  \centerline{\makebox[\wd0][c]{\hrulefill}
	\if@altadvisor \makebox[.5in]{} \makebox[\wd0][c]{\hrulefill} \fi}
  \centerline{\makebox[\wd0][c]{\@advisor}
	\if@altadvisor \makebox[.5in]{} \makebox[\wd0][c]{\@altadvisor} \fi}
  \par\vfil\null}
  \cleardoublepage
  }
}

