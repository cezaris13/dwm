cat index.html | grep -o " href=\"http.*\"" | grep "[Cc]hapter" | sed "s/\" title.*$//g;s/\/\".\+$//g;s/href=\"//g;s/\/\"$//g"
