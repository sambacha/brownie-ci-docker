#!/usr/bin/env bash
# SPDX-License-Identifier: Apache-2.0

GITHUB_REF=$1

if [[ -n $GITHUB_REF && $GITHUB_REF == refs/tags/* ]]; then
  echo "${GITHUB_REF#refs/tags/}";

  exit 0
fi

echo "Unable to determine tag name from '${GITHUB_REF}'"

exit 1;
