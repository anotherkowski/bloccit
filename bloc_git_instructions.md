## Before Checkpoint
git status
git checkout -b checkpoint-number

## After Checkpoint
git status
git add .
git commit -m "Checkpoint (number) completed"
git push origin checkpoint-number
git checkout master
git merge checkpoint-number
git push

## Before Assignment
git checkout -b assignment-number

## After Assignment
git add .
git commit -m "Assignment (number) completed"
git push origin assignment-number
git checkout master
