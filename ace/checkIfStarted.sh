#! /bin/bash

export TARGET_NAMESPACE=${1:-"cp4i"}
export INTEGRATION_SERVER_NAME=${2:-"none"}

# wait 5 minutes for queue manager to be up and running
# (shouldn't take more than 2 minutes, but just in case)
for i in {1..60}
do
  replicasRunning=`oc get integrationserver $INTEGRATION_SERVER_NAME -o jsonpath="{.status.availableReplicas}"`
  if [ "$replicasRunning" == "3" ] ; then break; fi
  echo "Waiting for $INTEGRATION_SERVER_NAME...$i"
  sleep 5
done

if [ $replicasRunning == 3 ]
   then echo Integration Server $INTEGRATION_SERVER_NAME is ready;
   exit;
fi

echo "*** Integration Server $INTEGRATION_SERVER_NAME is not ready ***"
exit 1