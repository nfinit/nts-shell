#!/usr/bin/env bash

##################################################
# NTS TASKSTAT: Simple TaskWarrior status system #
##################################################

# Check if TaskWarrior has actually been used on the account first #
if [ -f "$HOME/.taskrc" ]; then
	TASKTODAY=`task +TODAY count`
	TASKPRITY=`task priority:H count`
	TASKOVRDU=`task +OVERDUE count`
	TASKTOTAL=$((TASKTODAY + TASKPRITY + TASKOVRDU))
	if [ $TASKTOTAL -gt 0 ]; then
		# Notify user of tasks due today #
		TASKDIV=0
		TASKCOUNT=$TASKTODAY
		if [ $TASKCOUNT -gt 0 ]; then
			TASKDIV=1
			tput setaf 006
			echo -ne "\nYou have $TASKCOUNT task"
			if [ ! $TASKCOUNT -eq 1 ]; then
				echo -n "s"
			fi
			echo -e " due today."
			tput sgr0
		fi
		# Notify user of high-priority task #
		if [ ! $TASKDIV -eq 1 ]; then
			TASKDIV=1
			echo -ne "\n"
		fi
		TASKCOUNT=$TASKPRITY
		if [ $TASKCOUNT -gt 0 ]; then
			tput setaf 003
			echo -ne "You have $TASKCOUNT high-priority task"
			if [ ! $TASKCOUNT -eq 1 ]; then
			echo -n "s"
			fi
			echo -e " pending completion."
			tput sgr0
		fi
		# Notify user of overdue tasks #
		if [ ! $TASKDIV -eq 1 ]; then
			TASKDIV=1
			echo -ne "\n"
		fi
		TASKCOUNT=$TASKOVRDU
		if [ $TASKCOUNT -gt 0 ]; then
			tput setaf 001
			echo -ne "You have $TASKCOUNT overdue task"
			if [ ! $TASKCOUNT -eq 1 ]; then
				echo -n "s"
			fi
			echo -ne ".\n"
			tput sgr0
		fi
		if [ $TASKDIV -eq 1 ]; then
			TASKDIV=1
			echo -ne "\n"
		fi
	fi
fi
