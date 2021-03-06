%%
%% Copyright (C) 2019 by Matias Barrientos G.
%%
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either
%% version 1.3 of this license or (at your option) any later
%% version. The latest version of this license is in:
%%
%% http://www.latex-project.org/lppl.txt
%%
%% and version 1.3 or later is part of all distributions of
%% LaTeX version 2005/12/01 or later.
%%

\NeedsTeXFormat{LaTeX2e}[2005/11/02]
\ProvidesClass{inf-pucv-format}[2019/09/02 Formato Escuela Informatica PUCV]

%% Macros para agregar en la listas de siglas, glosario y simbolos,
%% así no quedan con la hyperref
\let\origcontentsline\contentsline
\let\origaddtocontents\addtocontents

% ========== Parámetros clase  =================
\RequirePackage{xkeyval} % Paquete para parametros key=value
\RequirePackage{ifthen} % Paquete para hacer ifthenelse

\newif\ifthesis
\newif\iftwoside

\DeclareOptionX{thesis}[true]{\ifthenelse{\equal{#1}{true}}{\thesistrue}{\thesisfalse}}
\DeclareOptionX{twoside}[true]{\ifthenelse{\equal{#1}{true}}{\twosidetrue}{\twosidefalse}}
\ProcessOptionsX

% ========== Tipo de papel y tamaño  =================
\PassOptionsToPackage{top=2.5cm, bottom=2.5cm}{geometry} % Se pre-carga el paquete para los margenes.

\iftwoside
    \PassOptionsToPackage{top=2.5cm, bottom=2.5cm, inner=2.5cm, outer=3cm}{geometry}
    \PassOptionsToClass{twoside}{article}
\else
    \PassOptionsToPackage{top=2.5cm, bottom=2.5cm, left=3cm, right=2.5cm}{geometry}
\fi

\LoadClass[letterpaper, 12pt]{article} % Se carga la clase con el formato de articulo

% ========== Paquetes =================
\RequirePackage[paper=letterpaper]{geometry} % Margenes
\RequirePackage[english, activeacute, spanish, es-tabla, es-lcroman, es-nosectiondot]{babel} % Idiomas
\RequirePackage[labelsep=space, tableposition=top]{caption} % Separacion de captions figuras
\RequirePackage[utf8]{inputenc} % Formato UTF8 del texto
\RequirePackage[T1]{fontenc} % Fuente para que acepte acentos y etc.
\RequirePackage{graphicx} % Para poder incluir imagenes
\RequirePackage{fancyhdr} % No me acuerdo el porque de este paquete xd.
\RequirePackage[hidelinks]{hyperref} % Marcar referencia link TOC
\RequirePackage{amsmath} % Para poder escribir ecuaciones
\RequirePackage{enumerate} % Para hacer enumeraciones
\RequirePackage{float} % Para posicionar las imagenes
\RequirePackage{tocloft} % Para poder manejar la toc
\RequirePackage{multirow} % tablas
\RequirePackage{indentfirst} % sangría
\RequirePackage{titlesec} % Para la redefinicion de las secciones
\RequirePackage[nottoc]{tocbibind} % Poder agregar la seccion a las figuras
\RequirePackage{minted} % Para agregar codigo

% ========== Configuraciones  =================
\titlelabel{\thetitle\; } % Separacion de las secciones entre el numero y el titulo

\setlength{\parindent}{1cm} % sangría
\setlength{\parskip}{1em} % espaciado entre párrafos

% Se hace esto, por un error de paginacion del documento
\fancypagestyle{plain}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \rfoot{\thepage}
}

\pagestyle{plain}

% Tabla de contenidos acepta hasta 4 niveles de profundidad
\setcounter{tocdepth}{4}
\setcounter{secnumdepth}{4}

\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}} % Para poner puntitos a la toc en las secciones

% Espacio entre las subsec, subsubsec y para en la toc
\setlength{\cftbeforesubsecskip}{3.5pt}
\setlength{\cftbeforesubsubsecskip}{3.5pt}
\setlength{\cftbeforeparaskip}{3.5pt}

% Espacio incial de la subsubsec y para en la toc
\setlength{\cftsubsubsecindent}{26pt}
\setlength{\cftparaindent}{36pt}

% Espacio inicial en la lof y lot
\setlength{\cftfignumwidth}{18pt}
\setlength{\cfttabnumwidth}{18pt}

% Para que las figura y tablas tengan el numero de la seccion
\numberwithin{figure}{section}
\numberwithin{table}{section}

% Se redefine la seccion para que cuando se ponga una cree una nueva pagina
\let\stdsection\section
\renewcommand\section{\newpage\stdsection}

% ========== Fecha (MES)  =================
\newcommand{\MONTH}{%
  \ifcase\month% 0
    \or Enero,% 1
    \or Febrero,% 2
    \or Marzo,% 3
    \or Abril,% 4
    \or Mayo,% 5
    \or Junio,% 6
    \or Julio,% 7
    \or Agosto,% 8
    \or Septiembre,% 9
    \or Octubre,% 10
    \or Noviembre,% 11
    \or Diciembre,% 12
  \fi}
\newcommand{\YEAR}{\number\year}

% ========== Autor =================
\newcommand{\authorspace}{\\[0.5em]}

% ========== Resumen/Abstract =================
\def\abstractfile#1{\gdef\@abstractfile{#1}}

\newcommand{\makeabstract}[1][Resumen]{
    \ifdefined\@abstractfile
        \phantomsection
        \addcontentsline{toc}{section}{#1}
        \input{\@abstractfile}
        \newpage
    \fi
}

% ========== Dedicatoria =================
\def\dedicatoriafile#1{\gdef\@dedicatoriafile{#1}}

\newcommand{\makededicatoria}[1][Resumen]{
    \ifdefined\@dedicatoriafile
        \thispagestyle{empty}
        \input{\@dedicatoriafile}
        \newpage
    \fi
}

% ========== Referencias =================
\newcommand{\makereferencia}[1]{
    \renewcommand\refname{Referencias}
    \phantomsection
    \bibliographystyle{unsrt}
    \bibliography{#1}
}


% ========== Macros =================
\def\informe#1{\gdef\@informe{#1}}
\def\@informe{\@latex@warning@no@line{\noexpand\informe}}

\def\profesorguia#1{\gdef\@profesorguia{#1}}
\def\@profesorguia{\@latex@warning@no@line{\noexpand\profesorguia}}

\def\profesorco#1{\gdef\@profesorco{#1}}
\def\@profesorco{\@latex@warning@no@line{\noexpand\profesorco}}

\def\carrera#1{\gdef\@carrera{#1}}
\def\@carrera{\@latex@warning@no@line{\noexpand\carrera}}

\profesorguia{Nombre y 2 Apellidos}
\profesorco{Nombre y 2 Apellidos}
\carrera{Ingeniería Civil en Informática}

% ========== Portada Tesis =================
\newcommand{\makeportadatesis}{
    \begin{center}
        \thispagestyle{empty}
        \large
        Pontificia Universidad Católica de Valparaíso\\
        Facultad de Ingeniería\\
        Escuela de Ingeniería Informática
        \vspace{5cm}

        \Large{\textbf{\@title}}
        \vspace{3cm}

        \normalsize
        \bfseries
        \begin{tabular}{l}
            \@author
        \end{tabular}

        \vspace*{\fill}
    \end{center}

    \begin{center}
        \normalsize
        Profesor Guía: \textbf{\@profesorguia}\\
        \vspace{1.5em}
        Profesor Co-referente: \textbf{\@profesorco}

        \vspace*{\fill}

        \normalsize
        Carrera: \textbf{\@carrera}

        \vspace*{\fill}
    \end{center}


    \begin{center}
        \@date
        \newpage
    \end{center}
}

% ========== Portada =================
\newcommand{\makeportada}{ %
    \begin{center}
        \thispagestyle{empty}
        \large
        PONTIFICIA UNIVERSIDAD CATÓLICA DE VALPARAÍSO\\
        FACULTAD DE INGENIERÍA\\
        ESCUELA DE INGENIERÍA INFORMÁTICA
        \vspace{5cm}

        \Large{\textbf{\@title}}
        \vspace{3cm}

        \normalsize
        \bfseries
        \begin{tabular}{l}
            \@author
        \end{tabular}

        \vspace{3cm}
    \end{center}

    \begin{flushright}
        \begin{tabular}{l}
            \@informe
        \end{tabular}
    \end{flushright}

    \vspace*{\fill}

    \begin{center}
        \@date
    \end{center}

    \newpage

    \ifthesis
        \makeportadatesis
    \fi
}

% ========== Lista Glosario =================
\newcommand{\listglosarioname}{Glosario de Términos}
\newlistof{glosario}{glo}{\listglosarioname}

\newcommand{\glosario}[2]
{%
\refstepcounter{glosario}
\origaddtocontents{glo}{\protect\origcontentsline{glosario}{#1: #2}{}}\par
}

\setlength{\cftglosarionumwidth}{0.1em}
\setlength{\cftbeforeglosarioskip}{1em}
\renewcommand{\cftglotitlefont}{\cfttoctitlefont}
\cftpagenumbersoff{glosario}

% ========== Lista Siglas =================
\newcommand{\listsiglaname}{Lista de Abreviaturas o Siglas}
\newlistof{sigla}{sig}{\listsiglaname}

\newcommand{\sigla}[2]{%
\refstepcounter{sigla}
\origaddtocontents{sig}{\protect\origcontentsline{sigla}{#1: #2}{}}\par
}

\setlength{\cftsiglanumwidth}{0.1em}
\setlength{\cftbeforesiglaskip}{1em}
\renewcommand{\cftsigtitlefont}{\cfttoctitlefont}
\cftpagenumbersoff{sigla}

% ========== Lista Simbolos =================
\newcommand{\listsimbolosname}{Lista de Símbolos}
\newlistof{simbolo}{sim}{\listsimbolosname}

\newcommand{\simbolo}[2]{%
\refstepcounter{simbolo}
\origaddtocontents{sim}{\protect\origcontentsline{simbolo}{#1: #2}{}}\par
}

\setlength{\cftsimbolonumwidth}{0.1em}
\setlength{\cftbeforesimboloskip}{1em}
\renewcommand{\cftsimtitlefont}{\cfttoctitlefont}
\cftpagenumbersoff{simbolo}


% ========== LoF y LoT =================
% Para esconder la LoF o LoT en caso que no haya contenido
% https://tex.stackexchange.com/questions/234398/list-of-figures-and-tables-when-there-are-no-figures-or-tables

\newif\iffigures
\newif\iftables

\let\OLDfigure\figure
\def\figure{\figures@in@document\OLDfigure}
\let\OLDtable\table
\def\table{\tables@in@document\OLDtable}


\def\figures@in@document {%
    \immediate\write\@mainaux{\global\string\figurestrue}%
    \global\let\figures@in@document\empty
}

\def\tables@in@document {%
    \immediate\write\@mainaux{\global\string\tablestrue}%
    \global\let\tables@in@document\empty
}

% ========== Corpus =================
\define@boolkey{corpus}{glosario}{}
\define@boolkey{corpus}{siglas}{}
\define@boolkey{corpus}{simbolos}{}
\setkeys{corpus}{siglas=false, glosario=false, simbolos=false}
\newcommand{\makecorpus}[1][]{%
    \setkeys{corpus}{#1}

    \ifthesis
        \makededicatoria
    \fi

    % Tabla de contenido
    \pagenumbering{roman}
    \begin{center}
        \tableofcontents
    \end{center}
    \newpage

    \makeabstract

    % Glosario
    \ifKV@corpus@glosario
        \phantomsection
        \addcontentsline{toc}{section}{\listglosarioname}
        \listofglosario
        \newpage
    \fi

    % Siglas
    \ifKV@corpus@siglas
        \phantomsection
        \addcontentsline{toc}{section}{\listsiglaname}
        \listofsigla
        \newpage
    \fi

    % Simbolos
    \ifKV@corpus@simbolos
        \phantomsection
        \addcontentsline{toc}{section}{\listsimbolosname}
        \listofsimbolo
        \newpage
    \fi

    % Lista de Figuras
    {%
    \iffigures
        \renewcommand{\listfigurename}{Lista de Figuras}
        \let\oldnumberline\numberline
        \renewcommand{\numberline}{Figura~\oldnumberline}
        \listoffigures
        \newpage
    \fi
    }

    % Lista de Tablas
    {%
    \iftables
        \renewcommand{\listtablename}{Lista de Tablas}
        \let\oldnumberline\numberline
        \renewcommand{\numberline}{Tabla~\oldnumberline}
        \listoftables
        \newpage
    \fi
    }

    \pagenumbering{arabic}
}

% ========== Anexo =================
\newenvironment{anexos}[1][Anexos]{
    % Para dejar sin numero de pagina los anexos
    \cleardoublepage
    \pagenumbering{gobble}

    \appendix
    \phantomsection
    \addcontentsline{toc}{section}{#1}
    \renewcommand{\thesubsection}{\Alph{subsection}:} % Se cambia a letra, ademas con :
}{
    \cleardoublepage
    \pagenumbering{arabic}
    \renewcommand{\thesubsection}{subsection}
}

% Para crear un anexo
\newcommand{\anexo}[1]{
    \subsection{#1}
    \newpage
}
