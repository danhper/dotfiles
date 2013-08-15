\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{xearticle}
\LoadClassWithOptions{article}
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
\RequirePackage{listings}
\RequirePackage{courier}
\RequirePackage{caption}
\RequirePackage[log-declarations=false]{xparse}
\RequirePackage[quiet]{fontspec}
\RequirePackage[unicode=true]{hyperref}
\hypersetup{%
  colorlinks=false,
  urlbordercolor=blue,
  pdfborderstyle={/S/U/W 1}% border style will be underline of width 1pt
}

% Layout settings
\RequirePackage[scale=0.8]{geometry}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
%\setstretch{1.3}
\parindent=1em

\makeatletter
\def\maketitle{\begin{titlepage}%
    \let\footnotesize\small
    \let\footnoterule\relax
    \parindent \z@
    \reset@font
    \null\vfil
    \hrule height 1pt
    \vskip 10\p@
    \begin{center}
      \huge 
      \@title \par
    \end{center}
    \vskip 30\p@
    \begin{minipage}{0.48\textwidth}
      \begin{flushleft}
        \normalsize \@date\par
        \normalsize \@deadline
      \end{flushleft}
    \end{minipage}
    \begin{minipage}{0.5\textwidth}
      \begin{flushright}
        \large \@author\par
        \large \@studnb
      \end{flushright}
    \end{minipage}
    \vskip 5\p@
    \hrule height 1pt
    \vskip 60\p@
    \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
}
\def\deadline#1{\def\@deadline{Deadline: #1}}
\def\studnb#1{\def\@studnb{Student Nb: #1}}
\makeatother
%
\definecolor{lightgray}{RGB}{235,235,235}

\setmonofont{FreeMono}
\newfontfamily{\myttfamily}[Scale=MatchLowercase]{FreeMono}
\newfontfamily{\myrmfamily}[Scale=MatchLowercase]{DejaVu Serif}
\lstset{%
  language=C,
  basicstyle=\ttfamily,
  numbers=none,               
  numberstyle=\tiny,
  numbersep=5pt,             
  tabsize=2,
  extendedchars=true,
  breaklines=true,        
  frame=single,
  frameround=tttt,
  keywordstyle=[1]\color{RoyalPurple}\myttfamily\bfseries,
  keywordstyle=[2]\color{Fuchsia}\myttfamily,   
  keywordstyle=[3]\color{RoyalBlue}\myttfamily, 
  keywordstyle=[4]\myttfamily\mdseries,
  stringstyle=\color{Bittersweet}\myrmfamily,
  commentstyle=\color{Brown}\myrmfamily,
  showspaces=false,
  showtabs=false, 
  xleftmargin=17pt,
  framexleftmargin=17pt,
  framexrightmargin=5pt,
  framexbottommargin=4pt,
  backgroundcolor=\color{lightgray},
  showstringspaces=false,
  captionpos=b,
}
%
