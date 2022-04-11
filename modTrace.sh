#!/bin/bash
######################################################################
## V 1.0 - 30/05/2019  Verification du transfert POSTIE
############################################################################################################################################

NOM_FICHIER_INI="modTrace.ini"


# FONCTIONS
trace()
{
	if [[ "$NIVEAU_LOG" -eq "0" ]]
	then
		echo -e "$(date +'%m/%d/%y %H:%M:%S') $2"
	fi

	if [[ "$1" -ge "$NIVEAU_LOG" ]]
	then
		echo -e "$(date +'%m/%d/%y %H:%M:%S') $2" >> $NOM_FIC_TRACE

	fi
}

trace_title()
{
	printf "%0.s-" {1..100}                                                 >> $NOM_FIC_TRACE
	echo                                                                    >> $NOM_FIC_TRACE
	printf "|%*s%*s|" $(echo 49+${#1}/2 | bc) "$1" $(echo 49-${#1}/2 | bc)  >> $NOM_FIC_TRACE
	echo                                                                    >> $NOM_FIC_TRACE   
	printf "%0.s-" {1..100}                                                 >> $NOM_FIC_TRACE
	echo                                                                    >> $NOM_FIC_TRACE
	if [[ "$NIVEAU_LOG" -eq "0" ]]
	then
		printf "%0.s-" {1..100}                                                 
		echo                                                                    
		printf "|%*s%*s|" $(echo 49+${#1}/2 | bc) "$1" $(echo 49-${#1}/2 | bc)  
		echo                                                                       
		printf "%0.s-" {1..100}                                                 
		echo                                                                    
	fi
}

trace_debug()
{
	trace 0 "[DEBUG         ]: $1" 
}

trace_info()
{
	trace 1 "[INFO          ]: $1" 
}

trace_warn()
{         
	trace 2 "[AVERTISSEMENT ]: $1" 
}

trace_err()
{
	trace 3 "[ERREUR        ]: $1"  
}

init ()
{
	MOTIF=$1
	grep $MOTIF $NOM_FICHIER_INI | grep -v "^#" | cut -d "=" -f 2
}
DATE_JOUR_HEURE=`date +%Y-%m-%d-%H-%M-%S`
REP_LOG=`init REP_LOG`
NIVEAU_LOG=`init NIVEAU_LOG`

NOM_FIC_TRACE="$REP_LOG/trace_${DATE_JOUR_HEURE}.trc"


trace_title  "Title"
trace_err "Err"
trace_warn "Warn"
trace_info "Info"
trace_debug "Debug"

exit 0









