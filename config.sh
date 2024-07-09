ROM_DIRECTORY="/mnt/Android/BlissRoms"
SCRIPTS_DIR=$(pwd)



addAndCommit() {
    git add -A && git commit -m "BLISSBOT: PATCH"
}