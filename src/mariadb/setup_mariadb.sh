#!/bin/bash

set -x


mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<'EOF'
