I have large size file (170MB) on local machine.

issue: while creating any new file and try to push that file on GitHub repo from local machine i was continuously getting below error and was complicated.

getting below error:

Enumerating objects: 18, done.
Counting objects: 100% (18/18), done.
Delta compression using up to 2 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (16/16), 141.14 MiB | 28.36 MiB/s, done.
Total 16 (delta 3), reused 1 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (3/3), completed with 1 local object.
remote: error: Trace: c4d0eb8c92c473dc4e906de4addfa081cac9913df9fa1eb3b2201eb8b00b829a
remote: error: See https://gh.io/lfs for more information.
remote: error: File .terraform/providers/registry.terraform.io/hashicorp/aws/5.100.0/linux_amd64/terraform-provider-aws_v5.100.0_x5 is 674.20 MB; this exceeds GitHub's file size limit of 100.00 MB
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.
To https://github.com/anandaadhe/Terraform.git
 ! [remote rejected] main -> main (pre-receive hook declined)
error: failed to push some refs to 'https://github.com/anandaadhe/Terraform.git'

--------------------------------------------------------
use below commands to solve the above error:

# 1. Backup your repo first (safety net)
cp -r ~/Terraform ~/Terraform-backup

# 2. Go into the repo
cd ~/Terraform

# 3. Add .gitignore so these files are never tracked again
cat >> .gitignore << 'EOF'
.terraform/
.terraform.lock.hcl
*.tfstate
*.tfstate.backup
EOF

# 4. Remove the .terraform folder from local disk completely
rm -rf .terraform

# 5. Remove any tfstate files from local disk (optional, only if you don't need them)
rm -f *.tfstate *.tfstate.backup

# 6. Untrack these from git going forward
git rm -r --cached .terraform 2>/dev/null
git rm --cached *.tfstate *.tfstate.backup 2>/dev/null
git add .gitignore
git commit -m "Remove .terraform and tfstate files, add gitignore"

# 7. Install git-filter-repo (if not already installed)
sudo apt install git-filter-repo -y
# or (optional) if apt doesn't have it:
# pip3 install git-filter-repo

# 8. Strip .terraform folder from ALL git history
git filter-repo --path .terraform --invert-paths --force

# 9. Strip tfstate files from ALL git history too
git filter-repo --path-glob '*.tfstate' --invert-paths --force
git filter-repo --path-glob '*.tfstate.backup' --invert-paths --force

# 10. Re-add the remote (filter-repo removes it)
git remote add origin https://github.com/anandaadhe/Terraform.git

# 11. Force-push cleaned history to GitHub
git push origin main --force

# 12. Verify — should return nothing
git log --oneline -- .terraform
git log --oneline -- '*.tfstate'

# 13. Check repo size shrank
du -sh .git