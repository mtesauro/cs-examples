#!/bin/bash

REPORTS="/opt/cs-project/reports"
BDIR="$REPORTS/ssllabs"

# Get us to the right directory
cd /opt/cs-project

# Create reports directory if needed
if [ ! -d "$REPORTS" ]; then
  mkdir $REPORTS
fi

cd $REPORTS

# Create the ssllabs directory if needed
if [ ! -d "$BDIR" ]; then
  mkdir $BDIR
fi

cd $BDIR

# Run ssllabs here where the dojo uploader expects it
ssllabs-scan "${@}" 
