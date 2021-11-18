**FREE
ctl-opt DFTACTGRP(*NO) ;

  //==========================================================================//
  //          ce programme permet de gérer le fichier des paramètres          //
  //==========================================================================//
  // attention indicateur 41 pour protéger la clé                             //
  dcl-f
    GPARAME   WORKSTN   ;
  dcl-f
    GPARAM
    USAGE(*UPDATE:*OUTPUT)
    rename(GPARAM:GPARAMF) ;
  dcl-s creat ind ;
  dcl-s cmdsql char(100) ;
  dcl-s cmd    char(200) ;
   // declarative pour récupérer la partion et la bib
/include GLICENCE/QRPGLESRC,GPARAM02


  //=======================================//
  //    lecture du fichier Paramètres      //
  //=======================================//
  read Gparam    ;
  if   %eof(GPARAM) ;
  RTVLIBPGM('GPARAM':lib) ;
  MAIL    = 'nom@SOCiete.com' ;
    creat = *on ;
  else ;
    creat = *off  ;
  endif ;
  glog = 'GLOGCMD' ;
  // recupération numéro de série
/include GLICENCE/QRPGLESRC,GPARAM03
  // recupération numéro de partition
/include GLICENCE/QRPGLESRC,GPARAM04
  dou  *in03 or *in12 ;
    exfmt fmt01 ;
    if not *in03 and not *in12 ;
      // Si F10 mise à jour
      if *in10 ;
        if creat        ;
          write gparamf ;
        else ;
          update gparamf ;
        endif   ;
        setll *start gparam;
        read  gparam ;
    // modification du moteur
    // cmd = 'CHGPGM PGM(SNDLOGC) USRPRF(*OWNER)' ;
    // exec sql
    // call qcmdexc(:cmd) ;
      endif   ;
    endif;
  enddo ;

*inlr = *on;
//
// fin du programme