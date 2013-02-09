%% rireki.cls
%% $Date: 2002/02/03 09:50:06 $
%%
%% Copyright (C) 2002 MIYAMOTO Yusuke
%% All rights reserved.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rireki}
\ProcessOptions
\LoadClass[twoside,11pt]{jarticle}
%% 用紙サイズ (B5)
\setlength{\paperwidth}{181mm}
\setlength{\paperheight}{257mm}
\@settopoint{\paperwidth}
\@settopoint{\paperheight}

%% 用紙左上を原点とする
\setlength{\voffset}{-1in}
\setlength{\hoffset}{-1in}

%% 傍注を削除
\setlength{\marginparsep}{0pt}
\setlength{\marginparwidth}{0pt}
\setlength{\marginparpush}{0pt}

%% 左マージン
\setlength{\oddsidemargin}{20mm}
\setlength{\evensidemargin}{10.5mm}
\@settopoint{\oddsidemargin}
\@settopoint{\evensidemargin}

%% 上マージン
\setlength{\headheight}{\z@}
\setlength{\headsep}{\z@}
\setlength{\topsep}{\z@}
\setlength{\topmargin}{16mm}
\@settopoint{\topmargin}

%% 脚注領域を削除
\setlength{\footnotesep}{\z@}
\setlength{\footskip}{\z@}

%% テキスト領域
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\oddsidemargin}
\addtolength{\textwidth}{-\evensidemargin}
\@settopoint{\textwidth}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2\topmargin}
\@settopoint{\textheight}

%% picture 描画コマンド
%% 座標の移動
\newcommand{\@x}{0}
\newcommand{\@y}{0}
\newcounter{pic@x}
\newcounter{pic@y}
\def\MoveTo(#1,#2){\gdef\@x{#1}\gdef\@y{#2}}
\def\RMoveTo(#1,#2){ %
  \@tempcnta=\number\@x
  \advance\@tempcnta by #1
  \xdef\@x{\the\@tempcnta}
  \@tempcnta=\number\@y
  \advance\@tempcnta by #2
  \xdef\@y{\the\@tempcnta}
}

%% 左上を原点とする座標系における相対参照で \put
\def\Put(#1,#2){%
  \setcounter{pic@x}{\@x}
  \setcounter{pic@y}{\pic@height}
  \addtocounter{pic@x}{#1}
  \addtocounter{pic@y}{-\@y}
  \addtocounter{pic@y}{-#2}
  \put(\thepic@x, \thepic@y)%
}

\def\MultiPut(#1,#2)(#3,#4){
  \setcounter{pic@x}{\@x}
  \setcounter{pic@y}{\pic@height}
  \addtocounter{pic@x}{#1}
  \addtocounter{pic@y}{-\@y}
  \addtocounter{pic@y}{-#2}
  \multiput(\thepic@x,\thepic@y)(#3,-#4)%
}

%% 履歴書を作成するコマンド．\end{document} で実行される．
\newcommand{\@makerireki}{%
\setlength\unitlength{1mm}
\@tempcnta=\number\textwidth
\divide\@tempcnta by \number\unitlength
\edef\pic@width{\the\@tempcnta}
\@tempcnta=\number\textheight
\divide\@tempcnta by \number\unitlength
\edef\pic@height{\the\@tempcnta}

%% picture 環境
\noindent
\begin{picture}(\pic@width,\pic@height)

%% タイトル，写真位置
\MoveTo(0,0)
\Put(0,0){\Large\bfseries\kanjiskip=5mm\historyname}
\Put(100,2){\makebox(0,5)[rc]{\scriptsize\@date 現在}}
\Put(105,31){\dashbox{0.5}(28,38)[c]{\scriptsize %
  \shortstack[c]{写真を貼る位置\\縦 36 〜 40 mm\\横 24 〜 30 mm}}}
\@tempcnta=\number\paperheight
\divide\@tempcnta by 2
\advance\@tempcnta by -\number\topmargin
\divide\@tempcnta by \unitlength
\Put(-16,\the\@tempcnta){$\triangleleft$}

%% 氏名，現住所などのプロファイル
\MoveTo(0,0)
\thicklines
\Put(0,2){\line(1,0){100}}
\Put(0,2){\line(0,-1){76}}
\Put(0,78){\line(1,0){151}}
\Put(100,2){\line(0,-1){32}}
\Put(100,34){\line(1,0){51}}
\Put(151,34){\line(0,-1){44}}

\thinlines
\Put(0,7){\dashbox{.5}(100,5)[l]{\scriptsize\hspace{1mm}\kananame}}
\Put(0,24){\line(1,0){100}}
\Put(1,8){\makebox(0,0)[tl]{\scriptsize\namename}}
\Put(1,24){\makebox(42,16)[r]{\LARGE\kanjiskip=3mm\@surname\hspace{12pt}}}
\Put(1,7){\makebox(42,5)[r]{\scriptsize\kana@surname\hspace{12pt}}}
\Put(42,24){\makebox(42,16)[l]{\LARGE\kanjiskip=3mm\hspace{12pt}\@forename}}
\Put(42,7){\makebox(42,5)[l]{\scriptsize\hspace{12pt}\kana@forename}}
\Put(87,2){\line(0,-1){22}}
\Put(88,24){\makebox(12,16)[tl]{\tiny 印}}
\Put(88,7){\makebox(12,5)[c]{\scriptsize\sexname\hskip 1ex\@sex}}

\Put(0,34){\makebox(100,10)[l]{\scriptsize\hspace{1ex}\birthdayname}}
\Put(0,34){\makebox(100,10)[r]{\@birthday\hskip 2em
    (満\hbox to 2em{\hfil\@age\hfil}歳)\hspace{1em}}}
\Put(0,34){\line(1,0){100}}

\Put(0,39){\dashbox{.5}(151,5)[l]{\hspace{1mm}\scriptsize\kananame}}
\Put(20,38){\makebox(0,0)[lb]{\scriptsize\kana@address}}
\Put(1,40){\makebox(0,0)[tl]{\scriptsize\addressname}}
\Put(12,40){\makebox(0,0)[lt]{\small 〒 \@postalcode}}
\Put(20,48){\makebox(148,5)[lb]{\@address}}
\Put(0,50){\line(1,0){151}}
\Put(1,51){\makebox(0,0)[tl]{\scriptsize\contactname}}
\Put(5,56){\makebox(151,6)[l]{\small\@phone\@email}}
\Put(0,56){\line(1,0){151}}
\Put(0,61){\dashbox{.5}(151,5)[l]{\hspace{1mm}\scriptsize\kananame}}
\Put(20,61){\makebox(0,5)[l]{\scriptsize\kana@anotheraddress}}
\Put(1,62){\makebox(0,0)[tl]{\scriptsize\anotheraddressname}}
\Put(12,62){\makebox(0,0)[lt]{\small 〒 \@anotherpostalcode}}
\Put(20,70){\makebox(151,8)[lb]{\@anotheraddress}}
\Put(0,72){\line(1,0){151}}
\Put(1,78){\makebox(0,5)[tl]{\scriptsize\contactname}}
\Put(5,78){\makebox(151,6)[l]{\small\@anotherphone}}

%% 学歴・職歴
\MoveTo(0,79)
\thicklines
\Put(0,0){\line(1,0){151}}
\Put(151,0){\line(0,-1){145}}
\Put(0,0){\line(0,-1){145}}
\Put(0,145){\line(1,0){151}}

\thinlines
\Put(0,145){\dashbox{.5}(17,145){}}
\Put(26,0){\line(0,-1){145}}
\Put(0,5){\line(1,0){151}}
\Put(0,5){\makebox(17,5)[c]{\scriptsize 年}}
\Put(17,5){\makebox(9,5)[c]{\scriptsize 月}}
\Put(26,5){\makebox(125,5)[c]{\scriptsize\backgroundname}}

\MultiPut(0,5)(0,7){20}{\line(1,0){151}}
\@starttoc{lob} % list of background
\@starttoc{loc} % list of career

\MoveTo(0,0)
\@firstpagehook
\end{picture}
\clearpage

%% 右ページ
\begin{picture}(\pic@width, \pic@height)

\MoveTo(0,0)
\thicklines
\Put(0,0){\line(1,0){151}}
\Put(0,0){\line(0,-1){224}}
\Put(151,0){\line(0,-1){224}}
\Put(0,224){\line(1,0){151}}

\Put(0,75){\line(1,0){151}}
\Put(0,164){\line(1,0){151}}
\Put(0,194){\line(1,0){151}}
\Put(0,203){\line(1,0){151}}

%% 免許・資格
\MoveTo(0,0)
\thinlines
\Put(0,75){\dashbox{.5}(17,75){}}
\Put(26,0){\line(0,-1){75}}
\Put(0,5){\makebox(17,5)[c]{\scriptsize 年}}
\Put(17,5){\makebox(9,5)[c]{\scriptsize 月}}
\Put(26,5){\makebox(125,5)[c]{\scriptsize\licensename}}
\Put(0,5){\line(1,0){151}}

\MultiPut(0,5)(0,7){10}{\line(1,0){151}}
\@starttoc{lol} % list of licenses

%% 得意科目
\Put(75,75){\line(0,-1){56}}
\Put(1,103){\makebox(75,27)[lt]{\scriptsize\subjectname}}
\Put(1,103){\makebox(75,24){\@subject}}
%% 自己分析
\Put(76,103){\makebox(75,27)[lt]{\scriptsize\selfintroname}}
\Put(76,103){\makebox(75,24){\@selfintro}}
\Put(0,103){\line(1,0){151}}
%% 趣味
\Put(1,131){\makebox(75,27)[lt]{\scriptsize\hobbyname}}
\Put(1,131){\makebox(75,24){\@hobby}}
%% 特技
\Put(76,131){\makebox(75,27)[lt]{\scriptsize\profname}}
\Put(76,131){\makebox(75,24){\@prof}}
\Put(0,131){\line(1,0){151}}
%% 動機
\Put(1,162){\makebox(150,30)[lt]{\scriptsize\motivename}}
\Put(1,162){\makebox(150,26){\@motive}}
%% 本人希望
\Put(1,192){\makebox(150,27)[tl]{\scriptsize\wishname}}
\Put(1,192){\makebox(150,24){\@wish}}
%% 通勤時間
\Put(1,203){\makebox(47,8)[lt]{\scriptsize\commutename}}
\Put(1,203){\makebox(45,8)[r]{\@commute}}
\Put(48,194){\line(0,-1){9}}
%% 扶養家族
\Put(49,203){\makebox(34,8)[lt]{\scriptsize\dependentsname}}
\Put(49,203){\makebox(30,8)[r]{\@dependents}}
\Put(84,194){\line(0,-1){9}}
%% 配偶者
\Put(85,203){\makebox(33,8)[lt]{\scriptsize\matename}}
\Put(85,203){\makebox(29,8)[r]{\@mate}}
\Put(116,194){\line(0,-1){9}}
%% 配偶者の扶養義務
\Put(117,203){\makebox(34,8)[lt]{\scriptsize\matedependencename}}
\Put(117,203){\makebox(30,8)[r]{\@matedependence}}
%% 保護者
\Put(0,212){\dashbox{.5}(151,9){}}
\Put(1,212){\makebox(124,8)[lt]{\scriptsize\guardianname}}
\Put(1,212){\makebox(124,5)[l]{\scriptsize\kananame}}
\Put(35,212){\line(0,-1){12}}
\Put(1,224){\makebox(34,11)[lt]{\scriptsize\namename}}
\Put(16,212){\makebox(0,5)[l]{\scriptsize\kana@guardian}}
\Put(1,224){\makebox(34,12)[c]{\@guardian}}
\Put(36,224){\makebox(89,11)[lt]{\small 〒 \@guardianpostalcode}}
\Put(48,212){\makebox(77,5)[l]{\scriptsize\kana@guardianaddress}}
\Put(36,224){\makebox(89,8)[c]{\@guardianaddress}}
\Put(150,224){\makebox(0,11)[rt]{\scriptsize\@guardianphone}}

\MoveTo(0,0)
\@secondpagehook
\end{picture}
}

%% フックマクロ定義コマンド
\let\@firstpagehook\@empty
\let\@secondpagehook\@empty
\newcommand{\AtFirstPage}{\g@addto@macro\@firstpagehook}
\newcommand{\AtSecondPage}{\g@addto@macro\@secondpagehook}

%%再生紙
\newcommand{\RecycledPaper}{%
  \AtSecondPage{\Put(150,225){\makebox(0,0)[rt]{\scriptsize 
    この用紙には再生紙を利用しています。}}}
}


%% 履歴書 作成日
\renewcommand{\@date}{\today}
\renewcommand{\date}[1]{\edef\@date{#1}}

%% 姓
\newcommand\@surname\@empty
\newcommand\kana@surname\@empty
\newcommand{\SurName}{\@testopt\surn@me{}}
\def\surn@me[#1]#2{%
  \def\@surname{#2}
  \def\kana@surname{#1}
}

%% 名
\newcommand\@forename\@empty
\newcommand\kana@forename\@empty
\newcommand{\ForeName}{\@testopt{\foren@me}{}}
\def\foren@me[#1]#2{%
  \def\@forename{#2}
  \def\kana@forename{#1}
}

%% 現住所
\newcommand\@address\@empty
\newcommand\kana@address\@empty
\newcommand{\Address}{\@testopt{\@ddress}{}}
\def\@ddress[#1]#2{%
  \def\@address{#2}
  \def\kana@address{#1}
}

%% 郵便番号
\newcommand\@postalcode\@empty
\newcommand{\PostalCode}[1]{\def\@postalcode{\texttt{#1}}}

%% 電話番号
\newcommand\@phone\@empty
\newcommand{\Phone}[1]{\def\@phone{\hskip 24pt 電話: \texttt{#1}}}

%% 電子メール
\newcommand\@email\@empty
\newcommand{\Email}[1]{\def\@email{\hskip 24pt メール: \texttt{#1}}}

%% 連絡先住所
\newcommand\@anotheraddress\@empty
\newcommand\kana@anotheraddress\@empty
\newcommand{\AnotherAddress}{\@testopt{\@nother@ddress}{}}
\def\@nother@ddress[#1]#2{%
  \def\@anotheraddress{#2}
  \def\kana@anotheraddress{#1}
}

%% 連絡先郵便番号
\newcommand\@anotherpostalcode\@empty
\newcommand{\AnotherPostalCode}[1]{\def\@anotherpostalcode{\texttt{#1}}}

%% 連絡先電話番号
\newcommand\@anotherphone\@empty
\newcommand{\AnotherPhone}[1]{%
  \def\@anotherphone{\hskip 24pt 電話: \texttt{#1}}}

%% 生年月日
\newcommand{\Nengou}{\protect\@nengou}
\newcommand{\@nengou}[1]{%
  \@tempcnta=#1
  \ifnum\@tempcnta<1989
    \advance\@tempcnta by -1925
    昭和
  \else
    \advance\@tempcnta by -1988
    平成
  \fi
  \ifnum\@tempcnta=1 元 \else \the\@tempcnta \fi
}
\let\年号=\Nengou\relax
\newcounter{birth@year}
\newcounter{birth@month}
\newcounter{birth@day}
\newcounter{@ge}
\newcommand{\@birthday}\@empty
\newcommand{\Birthday}[3]{
  \setcounter{birth@year}{#1}
  \setcounter{birth@month}{#2}
  \setcounter{birth@day}{#3}
  \setcounter{@ge}{\year}
  \addtocounter{@ge}{-\thebirth@year}
  \ifnum\month=\thebirth@month
    \ifnum\day<\thebirth@day
      \addtocounter{@ge}{-1}
    \fi
  \else\ifnum\month<\thebirth@month
    \addtocounter{@ge}{-1}
  \fi\fi
  \def\@birthday{\年号\thebirth@year 年 \thebirth@month 月 \thebirth@day 日生}
}

%% 年齢
\newcommand{\@age}{\expandafter\the@ge}
\newcommand{\Age}[1]{\def\@age{#1}}

%% 性別
\newcommand{\@sex}{??}
\newcommand{\Sex}[1]{\def\@sex{#1}}

%% 得意科目
\newcommand{\@subject}\@empty
\newcommand{\Subject}[1]{\long\def\@subject{\parbox{72mm}{#1}}}

%% 自己分析
\newcommand{\@selfintro}\@empty
\newcommand{\SelfIntro}[1]{\long\def\@selfintro{\parbox{72mm}{#1}}}

%% 趣味
\newcommand{\@hobby}\@empty
\newcommand{\Hobby}[1]{\long\def\@hobby{\parbox{72mm}{#1}}}

%% 特技
\newcommand{\@prof}\@empty
\newcommand{\Prof}[1]{\long\def\@prof{\parbox{72mm}{#1}}}

%% 志望動機
\newcommand{\@motive}\@empty
\newcommand{\Motive}[1]{\long\def\@motive{\parbox{145mm}{#1}}}

%% 本人希望
\newcommand{\@wish}\@empty
\newcommand{\Wish}[1]{\long\def\@wish{\parbox{145mm}{#1}}}

%% 通勤時間
\newcommand{\@commute}\@empty
\newcommand{\Commute}[1]{\def\@commute{#1}}

%% 扶養家族
\newcommand{\@dependents}\@empty
\newcommand{\Dependents}[1]{\def\@dependents{#1}}

%% 配偶者
\newcommand{\@mate}\@empty
\newcommand{\Mate}[1]{\def\@mate{#1}}

%% 配偶者の扶養義務
\newcommand{\@matedependence}\@empty
\newcommand{\MateDependence}[1]{\def\@matedependence{#1}}

%% 保護者
\newcommand\@guardian\@empty
\newcommand\kana@guardian\@empty
\newcommand{\Guardian}{\@testopt{\gu@rdi@n}{}}
\def\gu@rdi@n[#1]#2{%
  \def\@guardian{#2}
  \def\kana@guardian{#1}
}

%% 保護者郵便番号
\newcommand{\@guardianpostalcode}\@empty
\newcommand{\GuardianPostalCode}[1]{\def\@guardianpostalcode{\texttt{#1}}}

%% 保護者住所
\newcommand\@guardianaddress\@empty
\newcommand\kana@guardianaddress\@empty
\newcommand{\GuardianAddress}{\@testopt{\gu@rdi@n@ddress}{}}
\def\gu@rdi@n@ddress[#1]#2{%
  \def\@guardianaddress{#2}
  \def\kana@guardianaddress{#1}
}

%% 保護者電話番号
\newcommand{\@guardianphone}\@empty
\newcommand{\GuardianPhone}[1]{%
  \def\@guardianphone{（電話: \texttt{#1}）}}

%% リスト出力用コマンド
%% #1: y 座標
%% #2: 年
%% #3: 月
%% #4: 内容
\newcommand{\PutListEntry}[4]{
  \Put(0,#1){\makebox(17,7)[c]{#2}}
  \Put(17,#1){\makebox(9,7)[c]{#3}}
  \Put(28,#1){\makebox(121,7)[l]{#4}}
}

%% 学歴リスト追加
\newcounter{@b}\setcounter{@b}{5}
\newcommand{\Background}[3]{%
  \addtocounter{@b}{7}
  \addtocontents{lob}{\protect\PutListEntry{\the@b}{#1}{#2}{#3}}
}
\newif{\if@bglastnewline}
\@bglastnewlinefalse
\newcommand{\BackgroundLastNewLine}{\@bglastnewlinetrue}

%% 職歴リスト追加
\newcounter{@c}\setcounter{@c}{0}
\newif\if@career
\@careertrue
\newcommand{\Career}[3]{%
  \@careerfalse
  \addtocounter{@c}{7}
  \addtocontents{loc}{\protect\PutListEntry{\the@c}{#1}{#2}{#3}}
}

%% 資格・免許リスト追加
\newcounter{@l}\setcounter{@l}{5}
\newcommand{\License}[3]{%
  \addtocounter{@l}{7}
  \addtocontents{lol}{\protect\PutListEntry{\the@l}{#1}{#2}{#3}}
}

%% コマンドの別名
\let\再生紙=\RecycledPaper\relax
\let\日付=\date\relax
\let\姓=\SurName\relax
\let\名=\ForeName\relax
\let\性別=\Sex\relax
\let\年令=\Age\relax
\let\年齢=\Age\relax
\let\生年月日=\Birthday\relax
\let\誕生日=\Birthday\relax
\let\郵便番号\PostalCode\relax
\let\現住所=\Address\relax
\let\電話番号=\Phone\relax
\def\メール{\Email}
\def\電子メール{\Email}
\let\連絡先郵便番号\AnotherPostalCode\relax
\let\連絡先住所=\AnotherAddress\relax
\let\連絡先電話番号=\AnotherPhone\relax
\let\学歴=\Background\relax
\let\職歴=\Career\relax
\let\資格=\License\relax
\let\免許=\License\relax
\let\Licence=\License\relax
\let\得意科目=\Subject\relax
\let\自己分析=\SelfIntro\relax
\let\趣味=\Hobby\relax
\let\特技=\Prof\relax
\let\動機=\Motive\relax
\let\志望動機=\Motive\relax
\let\希望=\Wish\relax
\let\本人希望=\Wish\relax
\let\通勤時間=\Commute\relax
\let\扶養家族=\Dependents\relax
\let\配偶者=\Mate\relax
\let\配偶者扶養義務=\MateDependence\relax
\let\保護者=\Guardian\relax
\let\保護者郵便番号\GuardianPostalCode\relax
\let\保護者住所=\GuardianAddress\relax
\let\保護者電話番号=\GuardianPhone\relax
\let\学歴リストの最後で改行=\BackgroundLastNewLine

%% 項目名
\newcommand{\historyname}{履歴書}
\newcommand{\namename}{氏~~名}
\newcommand{\kananame}{ふりがな}
\newcommand{\addressname}{現~住~所}
\newcommand{\anotheraddressname}{連~絡~先}
\newcommand{\contactname}{電話など}
\newcommand{\birthdayname}{生年月日}
\newcommand{\sexname}{性別}
\newcommand{\backgroundname}{学歴・職歴}
\newcommand{\licensename}{免許・資格}
\newcommand{\subjectname}{得意な科目・分野}
\newcommand{\selfintroname}{自己分析（性格・特徴・PR など）}
\newcommand{\hobbyname}{趣味・スポーツ・サークルなど}
\newcommand{\profname}{特技など}
\newcommand{\motivename}{志望の動機}
\newcommand{\wishname}{本人希望記入欄（特に給料・職種・勤務時間・勤務地・
  その他についての希望などがあれば記入）}
\newcommand{\guardianname}{保護者 (本人が未成年の場合のみ記入)}
\newcommand{\commutename}{通勤時間}
\newcommand{\dependentsname}{扶養家族数}
\newcommand{\matename}{配偶者}
\newcommand{\matedependencename}{配偶者の扶養義務}

%% フックマクロの登録
\AtBeginDocument{\pagestyle{empty}}
\AtBeginDocument{\Background{}{}{\textbf{\hfil 学歴}}}
\AtBeginDocument{\Career{}{}{\textbf{\hfil 職歴}}\@careertrue}

\AtEndDocument{\if@bglastnewline\Background{}{}{}\fi}
\AtEndDocument{\addtocontents{lob}{\protect\RMoveTo(0,\the@b)}}
\AtEndDocument{\if@career\Career{}{}{なし}\fi}
\AtEndDocument{\Career{}{}{\hfill 以上\hspace{2em}}}
\AtEndDocument{\addtocontents{loc}{\protect\RMoveTo(0,-\the@b)}}
\AtEndDocument{\@makerireki}

\endinput
