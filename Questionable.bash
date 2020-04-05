#!/bin/bash

#    _________________________________________________________________________________________________
#   |* ___________________________________________GPL-3_Licence_____________________________________ *|
#   | /                                                                                             \ |
#   | |         This program is free software: you can redistribute it and/or modify                | |
#   | |         it under the terms of the GNU General Public License as published by                | |
#   | |         the Free Software Foundation, either version 3 of the License, or                   | |
#   | |         (at your option) any later version.                                                 | |
#   | |                                                                                             | |
#   | |         This program is distributed in the hope that it will be useful,                     | |
#   | |         but WITHOUT ANY WARRANTY; without even the implied warranty of                      | |
#   | |         MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                       | |
#   | |         GNU General Public License for more details.                                        | |
#   | |                                                                                             | |
#   | |         You should have received a copy of the GNU General Public License                   | |
#   | |         along with this program.  If not, see <http://www.gnu.org/licenses/>.               | |
#   | |                                                                                             | |
#   | \_____________________________________________________________________________________________/ |
#   |* _____________________________________Questionable_|_4/5/2020_________________________________ *|
#   | /                                                                                             \ |
#   | |                                    Written by: Joshua Hoffman                               | |
#   | |                                 joshua.hoffman.ray@protonmail.com                           | |
#   | |                                                                                             | |
#   | \________________________________________Modulation_Project___________________________________/ |
#   |_________________________________________________________________________________________________|

Questionable () {

	Decision () {

	until [[ ${Say_It,,} =~ ^(y|n) ]]; do
	read -ep "$(echo $1 | tr "_" " ") (y/n)?:" You_Say && Say_It=${You_Say::1}
		if [[ ! ${Decision_B1:=0} = 0 ]]; then
		read -ep "You selected $You_Say (y/n)?: " Say_What && Say_What=${Say_What::1}
			if [[ ! ${Say_What,,} =~ ^(y) || ! ${Say_It,,} =~ ^(y|n) ]]; then
			read -p "You seem$Really unsure, press enter to retry..."
			unset Say_What Say_It You_Say && Really=" really$Really"
			fi
		fi
	done
	
	Say_Bye=${Say_It/n/} && unset Say_It && ${Questionable_return:=return} ${#Say_Bye}
	
	}
	
Name=${FUNCNAME[0]}
declare -A ${Name}_Local
declare -A User_Input
Posiotional=( $@ )

	if [[ ${Posiotional[0]:="-y"} != '-y' ]]; then
	
		while [[ $((D++)) != ${#Posiotional[@]} ]]; do
		declare -A ${Name}_Local && declare -i B=$D-1
		eval ${Name}_Local[$B]="${Posiotional[$B]}"
		eval read -\${Questionable_e:=e}\${Questionable_p:=p} \"Enter \${Posiotional[$B]:=value}:\" Answer_$B
		
			if [[ ${Questionable_B1:=0} != 0 ]]; then
			eval Decision '"I got:' \$Answer_"$B" '- Correct"'; Confirm=$?
			
				if [[ $Confirm = 0 ]]; then 
				eval Answers_"$B"='' && ((D--))
				continue
				else
				eval User_Input[${Posiotional[$B]}]=\$Answer_"$B"
				fi
	
			fi
		
			if [[ ${Questionable_B2:=1} != 0 ]] && [[ $((B+1)) = ${#Posiotional[@]} ]]; then
						
				for C in ${!User_Input[@]}; do
				((E++))
				eval echo "${E}. ${Posiotional[$((E-1))]}: \${User_Input[${Posiotional[$((E-1))]}]} "
				done
			
			Decision "Correct"; Final=$?
			
				if [[ $Final = 0 ]]; then
				unset ${User_Input[@]}
				D='' && B='' && E=''
				fi
			
			fi
		
		done
		
	else
	Posiotional=( ${Posiotional[@]:1} )
	Decision ${Posiotional[@]}
	return $?
	fi
	
}

Questionable $@
