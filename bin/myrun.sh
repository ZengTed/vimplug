#!/bin/bash
##################
#This is my tools
##################

zthelp()
{
#    echo "mycscope"
    echo "ss"
    echo "mycscope"
    echo "  jfilter"
    echo "  cfilter"
    echo "  pyfilter"
    echo "mytags"
    echo "mymount [-u] [1|2|3|4|5|edu]"
    echo "all"
    echo "allr"
    echo "zvi"
}

myaliyun()
{
    echo "59.110.54.175 ubuntu root fzghy"
    echo "120.55.167.129 mysql guihuayuan ghy@2016#2016"
}
mycscope()
{
    [ ! -d "$1" ] && echo "error(no path). This tool is full-code filter code file except all kinds of test directory" && return 
    find "$1" \( -path '*/[tT]est*' -o -path '*[^a-zA-Z][tT]est*' \) -type d -prune -o \( -name "*.c" -o -name "*.java" -o -name "*.cpp" -o -name "*.h" -o -name "*.cc" -o -name "*.py" \) -type f
}

jfilter()
{
    [ ! -d "$1" ] && echo "error(no path). This tool is java-code filter code file except all kinds of test directory" && return 
    find "$1" \( -path '*/[tT]est*' -o -path '*[^a-zA-Z][tT]est*' \) -type d -prune -o -name "*.java"  -type f
}

cfilter()
{
    [ ! -d "$1" ] && echo "error(no path). This tool is c-code filter code file except all kinds of test directory" && return 
    find "$1" \( -path '*/[tT]est*' -o -path '*[^a-zA-Z][tT]est*' \) -type d -prune -o \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.cc" \) -type f
}

pyfilter()
{
    [ ! -d "$1" ] && echo "error(no path). This tool is python-code filter code file except all kinds of test directory" && return 
#    find "$1" \( -path '*/[tT]est*' -o -path '*[^a-zA-Z][tT]est*' \) -type d -prune -o -name "*.py" -type f
    find "$1" -name "*.py" -type f
}

mytags()
{
    [ -f ./cscope.files ]  && ctags -f ./tags -L ./cscope.files && cscope -qbi ./cscope.files
    [ ! -f ./cscope.files ] && echo "当前目录没找到cscope.files,请先mycscope,jfilter,cfilter"
}

alias myctags=mytags

allr()
{
    case "x$1" in
        "xa")
            adb shell logcat -v time -b radio;;
        "xg")
            expression="$2"
            for p1 in "${@:3}"; do
                expression="$expression""|""$p1"
            done
            expression="($expression)"
            adb shell logcat -v time -b radio|grep -iE "$expression"
            ;;
        *)
            echo "[ a | g ] ==> catch radio log"
            ;;
    esac
}

all()
{
    h2s="192.168.0.110"

    case "x$1" in
        "xa")
            adb shell logcat -v time ;;
        "xc")
            [ $# -eq 2 ] && adb connect $2 || adb devices ;;
        "xcc")
            [ "x$h2s" != "x" ] && adb connect $h2s ;;
        "xs")
            adb shell ;;
        "xd")
            adb disconnect ;;
        "xg")
            expression="$2"
            for p1 in "${@:3}"; do
                expression="$expression""|""$p1"
            done
            expression="($expression)"
            adb shell logcat -v time|grep -iE "$expression"
            ;;
        "xdu")
            [ $# -eq 1 ] && upnpc -l && return

            expression=""
            for p1 in "${@:2}"; do
                expression="$expression $p1 TCP $p1 UDP "
            done
            upnpc -d $expression
            ;;
        *)
            echo "[ c | cc | s | d ] ==> adb-connect-device operations ($h2s)"
            echo "[ du ] ==> upnpc list or delete port1 port2 ... "
            echo "[ a | g ] ==> catch applogcat"
            ;;
    esac
}

mymount()
{
## ,dir_mode=0777,file_mode=0777 ##
    if [ "x$1" = "xu" -o "x$1" = "x-u" ]; then
        sudo umount /mnt
    else
        case "x$1" in
            "x1"|"x2"|"x3"|"x4"|"x5")
                sudo umount /mnt 2>/dev/null
                sudo mount -t cifs //192.168.0.110/theater$1 /mnt -o username=hansel,uid=1000,gid=1000,iocharset=utf8,rw 
                ;;
            "xedu")
                sudo umount /mnt 2>/dev/null
                sudo mount -t cifs //192.168.0.110/education /mnt -o username=hansel,uid=1000,gid=1000,iocharset=utf8,rw
                ;;
            *)
                echo "only mount movie - 1,2,3,4,5 and edu"
                echo "only umount - u"
                ;;
        esac
    fi

}

zvi()
{
    cdir=`pwd`
    rdir=`echo $cdir|awk -F '/' {'print "/" $2 "/" $3'}`
    [ "x$rdir" = "x" ] && echo "没有匹配的croot路径" && return
    
    mdir=`expr "$cdir" : "$rdir\/\(.*\)"`
    fdir=$mdir"/"$1

    cd $rdir
    [ ! -f "$fdir" ] && echo "no found file, pls check it" && echo "$rdir/./$fdir" && cd - && return

    vi $fdir

    cd - > /dev/null
}
