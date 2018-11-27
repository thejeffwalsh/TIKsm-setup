#!/bin/bash
#Test all of the Helm Deployments

helm test metrics
helm test data
helm test dash
helm unittest ../gtikk-charts/*/  #unit test all charts

case $1 in
	-n) true;;
	* )read -p "Do you wish to clean up the tests? (y/n)" yn;
	case $yn in
		[Yy]* ) chmod +x cleanUpTest.sh; ./cleanUpTest.sh;;
		[Nn]* ) exit;;
		* ) echo "Please answer y/n..";;
	esac;;
esac
echo "Done Testing!!!"