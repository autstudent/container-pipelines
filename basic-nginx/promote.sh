git checkout master
echo "test" >> index.html
git add -A
git commit -m "add index changes"
git push origin master
git checkout nerw
cp index.html build/index.html
cp nginx.conf build/nginx.conf
oc start-build basic-nginx --from-dir="." -F -w -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-dev -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-stage -n basic-nginx-build
oc tag basic-nginx:latest basic-nginx:basic-nginx-build-prod -n basic-nginx-build
