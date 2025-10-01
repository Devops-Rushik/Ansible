
#  This script is designed to make it easy for taking, deleting and reverting snapshots of the servers from vcenter

read -p " Enter present for create snapshot , absent for delete sanpshot, revert for revert the snapshot : " option
if [ "$option" == "present" ];then
        read -p "Enter 1 for single server 2 for multiple servers: " number
        if [ "$number" == 1 ];then
                read -p "Enter server name for which snapshot is required: "  username
                read -p "Write down the snapshot name you want or give change number: "  sname
                echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "**********Taking snapshot for $username *************"
                ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$username snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
                 echo "**********Snapshot completed for $username************"
        elif [ "$number" == 2 ];then
                read -p "Enter file name for which snapshot is required: "  username
                for i in `cat $username`
                do
                read -p "Write down the snapshot name you want or give change number: "  sname
                echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "**********Taking snapshot for $i**************"
                ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$i snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
                echo "**********Snapshot completed for $i***********"
		done
	else 
		echo "Entered invalid option, Try again"
	fi;
elif [ "$option" == "absent" ];then
	read -p "Enter 1 for single server 2 for multiple servers: " number
	if [ "$number" == 1 ];then
		read -p "Enter server name for which snapshot to be deleted: " username
		read -p "Write down the snapshot name you want to delete: " sname
		echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "*********Deleting $sname snapshot for $username*************"
		ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$username snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
		echo "*********Snapshot deleted for $username************"
	elif [ "$number" == 2 ];then
		read -p "Enter file name for which snapshot is required: "  username
                for i in `cat $username`
                do
		read -p "Write down the snapshot name you want to delete: " sname
                echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "*********Deleting $sname snapshot for $i*************"
                ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$i snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
                echo "*********Snapshot deleted for $i************"
		done
	else
                echo "Entered invalid option, Try again"
        fi;
elif [ "$option" == "revert" ];then
        read -p "Enter 1 for single server 2 for multiple servers: " number
        if [ "$number" == 1 ];then
                read -p "Enter server name for which snapshot to be reverted: " username
                read -p "Enter the snapshot name you want to revert: " sname
                echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "*********Reverting $sname snapshot for $username*************"
                ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$username snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
                echo "*********Snapshot reverted for $username************"
        elif [ "$number" == 2];then
                read -p "Enter file name for which snapshot is to be reverted: "  username
                for i in `cat $username`
                do
                read -p "Enter the snapshot name you want to revert: " sname
                echo "##################################"
                read -p "Provide the Vcenter name : "  vname
                read -p "Login ID for the VCenter : "  loginid
                read -s -p "Enter the  password : " pass
                echo "##################################"
                echo "*********Reverting $sname snapshot for $i*************"
                ansible-playbook /etc/ansible/playbooks/snapshotall.yml --extra-vars "hname=$i snap_name=$sname user_name=$loginid vcenter_name=$vname pass=$pass status=$option"
                echo "*********Snapshot reverted for $i************"
                done
        else
                echo "Entered invalid option, Try again"
        fi;
else
                echo "Entered invalid option, Try again"
fi;
