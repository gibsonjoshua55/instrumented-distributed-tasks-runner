# install otel cli
wget --no-check-certificate https://github.com/equinix-labs/otel-cli/releases/download/v0.0.18/otel-cli_0.0.18_x86_64.deb
apt install ./otel-cli_0.0.18_x86_64.deb

# create the trace in honeycomb
otel-cli span \
  -n root-task
  -s nx-cli \
  --otlp-headers x-honeycomb-team=$HONEYCOMB_WRITEKEY,x-honeycomb-dataset=$HONEYCOMB_DATASET \
  --endpoint api.honeycomb.io:443 \
  --tp-print \
  --tp-export > tools/scripts/set-trace-env.sh

# set the context to the TRACEPARENT env
. tools/scripts/set-trace-env.sh

# set the TRACEPARENT as an output for use in github actions
echo '::set-output name=TRACEPARENT::$TRACEPARENT'
