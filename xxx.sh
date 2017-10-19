ES_DATA_REPLICAS=$(echo "$NODES" | wc -l)

if [ "$ES_DATA_REPLICAS" -lt 3 ]; then
  print_red "Minimum amount of Elasticsearch data nodes is 3 (in case when you have 1 replica shard), you have ${ES_DATA_REPLICAS} worker nodes"
  print_red "Won't deploy more than one Elasticsearch data pod per node exiting..."
  exit 1
fi

print_green "Labeling nodes which will serve Elasticsearch data pods"
for node in $NODES; do
  eval "${KUBECTL} label node ${node} elasticsearch.data=true --overwrite"
done

  render_template "${yaml}" | eval "${KUBECTL} create -n monitoring -f -"
