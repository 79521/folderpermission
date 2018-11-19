# Get/Set FolderPermission
This is just a powershell app that crawl into your fileserver looking for folder that a especify user have permission to copy this ACL to another user.
It's recursive and can take a lot of time based in your initial folder deep. 
Is required to user input only 03 variables:
  $new_user = based like DOMAIN\UserName
  $copy_user = from who to copy folder permissions
  $main_pat = where to start the crawling, normally use \\fileserver\share\folder
  
  Remember to run with DomainAdmin Rights to go full into folders.
  This script just look into FOLDER permissions, to be more fast
  
DeepLab.io solution to set folder permission recursivelly copying ACL's from another user.
Fernando Keil
