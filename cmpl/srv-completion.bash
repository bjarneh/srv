#!bash
#
#  Copyright (C) 2012 bjarneh
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

_srv(){

    local cur prev srv_options srv_cmds wars i
    declare -a fnames

    srv_options="-n -f"
    srv_cmds="help\
             list\
             drop\
             fire\
             stop\
             start\
             anew\
             alog\
             access\
             clean\
             tail\
             restart"

    COMPREPLY=()

    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cur="${COMP_WORDS[COMP_CWORD]}"

    if [[ "${prev}" == "srv" ]]; then
        COMPREPLY=( $(compgen -W "${srv_cmds}" -- "${cur}") )
        return 0
    fi

    if [[ "${cur}" == -* ]]; then
        COMPREPLY=( $(compgen -W "${srv_options}" -- "${cur}") )
        return 0
    fi

    if [[ "${prev}" == "-f" ]]; then

        if [ -d "${CATALINA_HOME}/webapps" ]; then

            wars=$(ls ${CATALINA_HOME}/webapps/*.war 2>/dev/null)

            if [ ! -z "${wars}" ];then

                i=0
                for f in ${wars}; do
                    fnames["${i}"]=$(basename "${f}")
                    let i="${i}+1"
                done

                wars=( "${fnames[*]}" )

                COMPREPLY=( $(compgen -W "${wars}" -- "${cur}") )

            fi
        fi
    fi

    return 1

}


complete -F _srv srv
