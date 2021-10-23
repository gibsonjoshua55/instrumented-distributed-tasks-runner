# install otel cli
go get github.com/equinix-labs/otel-cli

# create the trace in honeycomb
otel-cli span \
  -n root-task
  -s nx-cli \
  --otlp-headers x-honeycomb-team=$HONEYCOMB_WRITEKEY,x-honeycomb-dataset=$HONEYCOMB_DATASET
  --endpoint api.honeycomb.io:443
  --tp-print \
  --tp-export > tools/scripts/set-trace-env.sh

# set the context to the TRACEPARENT env
. tools/scripts/set-trace-env.sh

# set the TRACEPARENT as an output for use in github actions
echo '::set-output name=TRACEPARENT::$TRACEPARENT'
