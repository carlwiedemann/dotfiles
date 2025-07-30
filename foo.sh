git bisect start
git bisect bad
git bisect good ed26738c281d9d31d8b9df6c9990c274b1a369e5
git bisect run ./bar.sh
git bisect reset
