# # has line
# if [[ $(rg -uu checkr | wc -l) -gt 0 ]]; then
#   exit 0
# else
#   exit 1
# fi

# lacks line
if [[ $(rg -uu monkey | wc -l) -eq 0 ]]; then
  exit 0
else
  exit 1
fi
