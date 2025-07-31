 # has line
# if [[ $(git grep checkr | wc -l) -gt 0 ]]; then
#   exit 0
# else
#   exit 1
# fi

# lacks line
if [[ $(git grep monkey | wc -l) -eq 0 ]]; then
  exit 0
else
  exit 1
fi
