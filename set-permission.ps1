#Set variables
$new_user = "domain\new-user"
$copy_user= "domain\model-user"
#set main/start folder
$main_path = "\\FolderInitialPath"

#Search for folder where $copy_user have permission and set to $ACL the path and access properties
$ACL = Get-ChildItem -Path $main_path -Recurse | where-object {($_.PsIsContainer)}| Get-ACL | Where-Object AccessToString -like "*$copy_user*" | Select-Object Path,Access

#crawl into $ACL
foreach($folderpath in $acl)
{
	ECHO ""
	ECHO "ROOT FOLDER"
	#make some cleaning
	$path = $folderpath.path.split("::")[-1]
	$path
	#create $ruler var with actual ACLs
	$ruler =  Get-Acl -path $path
	#create $rule var to look what permissions $copy_user have
	$rule= Get-Acl -path $path  | Select-Object -ExpandProperty Access
	
	#crawl into $rule
	Foreach($permission in $rule){
	
		#some tests into each access rule
		If($permission.IdentityReference.Value -eq $copy_User){
			#Create $ace var to generate new ACL equal to $copy_user permissions and set to $new_user
			$ace = New-Object System.Security.AccessControl.FileSystemAccessRule($new_user,$permission.FileSystemRights,$permission.InheritanceFlags,$permission.PropagationFlags,$permission.AccessControlType)
			ECHO "###NEW RULE###"
			$ace
			ECHO "####"
			#add the new ACL $ace in $ruler
			$ruler.SetAccessRule($ace)
			#set new ACLS into folder $path
			Set-Acl -Path $path -aclobject $ruler
			#Get-Acl -path $path | Select-Object -ExpandProperty Access
		}
	}
}
