#!/bin/sh

# FIXME This requires a modified ~/replica.my.cnf

. ~/www/python/venv/bin/activate
cd ~/www/python/src/scripts/

dump_base_dir=/public/dumps/public/enwiki
dump_date=`ls $dump_base_dir | tail -n1`
dump_dir=$dump_base_dir/$dump_date

echo >&2 "Latest dump is $dump_date"
jsub -sync y -cwd -o unsourced ./print_unsourced_pageids_from_wikipedia
jsub -sync y -mem 4g -cwd ./parse_pages_articles.py $dump_dir/enwiki-$dump_date-pages-articles.xml.bz2 unsourced
jsub -sync y -mem 4g -cwd ./assign_categories.py --max-categories=5500
