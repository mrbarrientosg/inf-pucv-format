\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{INFFormat}[2019/09/02 Formato INF PUCV]

%% Tipo de papel y tamaño
\LoadClass[letterpaper, 12pt]{article}

\let\origcontentsline\contentsline
\let\origaddtocontents\addtocontents

%% Paquetes ----------
\RequirePackage[top=2.5cm, right=2.5cm, bottom=2.5cm, left=3.0cm]{geometry} % Margenes
\RequirePackage[spanish, english, es-tabla]{babel} % Idiomas 
\RequirePackage[utf8]{inputenc} % Formato UTF8 del texto
\RequirePackage[labelsep=space]{caption} % Separacion de captions figuras
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
\RequirePackage{authblk} % Para poder tener multi autores
\RequirePackage{titlesec} % Para la redefinicion de las secciones 
\RequirePackage[nottoc]{tocbibind} % Poder agregar la seccion a las figuras
\RequirePackage{minted} % Para agregar codigo
%% ----------

%% Opciones
\newif\ifsiglas
\newif\ifglosario
\newif\iftesis

\DeclareOption{siglas}{\siglastrue} 
\DeclareOption{glosario}{\glosariotrue} 
\DeclareOption{tesis}{\tesistrue} 
\ProcessOptions\relax

%% https://www.tablesgenerator.com/

%% Configuraciones ----------
\setlength{\parindent}{1cm} % sangría 
\setlength{\parskip}{12pt} % espaciado entre párrafos 
\addto\captionsenglish{\renewcommand{\contentsname}{Índice}} % nombre de la tabla de contenidos 
\addto\captionsenglish{\renewcommand{\figurename}{Figura}} % Se cambia el nombre de las figuras en ingles a español
\addto\captionsenglish{\renewcommand{\tablename}{Tabla}} % Se cambia el nombre de las tablas en ingles a español

% Se hace esto, por un error de paginacion del documente
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
%% ----------

%% Fecha ----------
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
%% ----------

%% Libreria authblk ----------
\renewcommand{\Authsep}{\newline}
\renewcommand{\Authand}{\newline}
\renewcommand{\Authands}{\newline}
\renewcommand{\Authfont}{\normalsize\bfseries} % Nombre del autor en bold
\newcommand{\authorspace}{\authorcr\vspace{0.8em}}
%% ----------

%% Opciones ----------
\def\informe#1{\gdef\@informe{#1}}
\def\@informe{\@latex@warning@no@line{\noexpand\informe}}

\def\abstractfile#1{\gdef\@abstractfile{#1}}
\def\@abstractfile{\@latex@warning@no@line{\noexpand\abstractfile}}

\def\profesorguia#1{\gdef\@profesorguia{#1}}
\def\@profesorguia{\@latex@warning@no@line{\noexpand\profesorguia}}

\def\profesorco#1{\gdef\@profesorco{#1}}
\def\@profesorco{\@latex@warning@no@line{\noexpand\profesorco}}

\def\carrera#1{\gdef\@carrera{#1}}
\def\@carrera{\@latex@warning@no@line{\noexpand\carrera}}

\profesorguia{Nombre y 2 Apellidos}
\profesorco{Nombre y 2 Apellidos}
\carrera{Ingeniería Civil en Informática}
%% ----------

%% Portada ----------
\newcommand{\maketesistitle}{
    \begin{center} 
        \thispagestyle{empty} 
        Pontificia Universidad Católica de Valparaíso\\
        Facultad de Ingeniería\\
        Escuela de Ingeniería Informática
        \vspace{5cm} 
     
        \LARGE{\textbf{\@title}}
        \vspace{3cm} 
    
        {
        \@author
        }

        \vspace*{\fill}
        
        {
        \normalsize
        Profesor Guía: \textbf{\@profesorguia}\\
        \vspace{1.5em}
        Profesor Co-referente: \textbf{\@profesorco}
        }
        
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

\renewcommand{\maketitle}{ %
    \begin{center} 
        \thispagestyle{empty} 
        PONTIFICIA UNIVERSIDAD CATÓLICA DE VALPARAÍSO\\ 
        FACULTAD DE INGENIERÍA\\ 
        ESCUELA DE INGENIERÍA INFORMÁTICA 
        \vspace{5cm} 
     
        \LARGE{\textbf{\@title}}
        \vspace{3cm} 

        \@author

        \vspace*{\fill} 
    \end{center} 
    
    \begin{flushright} 
        \begin{tabular}{l}
            \@informe
        \end{tabular}
    \end{flushright} 
    
    \vspace{3cm} 

    \begin{center} 
        \@date
        \newpage 
    \end{center} 
    
    \iftesis
        \maketesistitle
    \fi
}
%% ----------

%% Glosario ----------
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
%% ----------

%% Lista de siglas ----------
\newcommand{\listsiglaname}{Lista de Abreviaturas o Siglas}
\newlistof{sigla}{sig}{\listsiglaname}

\newcommand{\sigla}[2]{%
\refstepcounter{sigla}
\origaddtocontents{sig}{\protect\origcontentsline{sigla}{#1: #2}{}}\par
}

\setlength{\cftglosarionumwidth}{0.1em}
\setlength{\cftbeforesiglaskip}{1em}
\renewcommand{\cftsigtitlefont}{\cfttoctitlefont}
\cftpagenumbersoff{sigla}
%% ----------



%% LoF y LoT ----------
% Para esconder la LoF o LoT en caso que no haya contenido
% https://tex.stackexchange.com/questions/234398/list-of-figures-and-tables-when-there-are-no-figures-or-tables
\restylefloat{figure}
\restylefloat{table}

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
%% ----------


%% Cuerpo ----------
\newcommand{\makecorpus}{ %
    
    % Tabla de contenido
    \pagenumbering{roman}
    \tableofcontents
    \newpage
    
    % Resumen
    \ifblank{\@abstractfile}{}{
        \phantomsection
        \addcontentsline{toc}{section}{Resumen}
        \include{\@abstractfile}
        \newpage
    }
    
    % Glosario
    \ifglosario
        \phantomsection
        \addcontentsline{toc}{section}{\listglosarioname}
        \listofglosario
        \newpage
    \fi
    
    % Siglas
    \ifsiglas
        \phantomsection
        \addcontentsline{toc}{section}{\listsiglaname}
        \listofsigla
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
    
    % Cuerpo
    \pagenumbering{arabic}
}