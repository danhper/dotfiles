\ProvidesClass{xejarticle}
\LoadClassWithOptions{xearticle}
\RequirePackage{xltxtra}
% Fonts
\setmainfont[RawFeature=-palt,BoldFont=TakaoPGothic]{TakaoPMincho}
\setsansfont[RawFeature=-palt]{TakaoPGothic}
\setmonofont[RawFeature=-palt]{TakaoPGothic}
% Japanese lineskip
\XeTeXlinebreaklocale "ja"
\XeTeXlinebreakskip=0pt plus 1pt minus 0.1pt
\XeTeXlinebreakpenalty=0

% 半角分戻る
\def\<{\@ifstar{\zx@hwback\nobreak}{\zx@hwback\relax}}
\def\zx@hwback#1{\leavevmode#1\hskip-.5em\relax}

% Title settings
\def\prepartname{第\fi}
\def\postpartname{部}
\def\presectionname{}%  第
\def\postsectionname{}% 節
\def\contentsname{目次}
\def\listfigurename{図目次}
\def\listtablename{表目次}
\def\refname{参考文献}
\def\bibname{参考文献}
\def\indexname{索引}
\def\figurename{図}
\def\tablename{表}
\def\appendixname{付録}
\def\abstractname{概要}
\def\lstlistingname{ソース}

\newif\if西暦 \西暦true
\def\西暦{\西暦true}
\def\和暦{\西暦false}
\newcount\heisei \heisei\year \advance\heisei-1988\relax
\def\today{%
    \if西暦
      \number\year 年
      \number\month 月
      \number\day 日
    \else
      平成\number\heisei 年
      \number\month 月
      \number\day 日
    \fi}

\def\author#1{\def\@author{名前: #1}}
\def\date#1{\def\@date{提出日: #1}}
\def\deadline#1{\def\@deadline{締切日: #1}}
\def\studnb#1{\def\@studnb{学籍番号: #1}}

