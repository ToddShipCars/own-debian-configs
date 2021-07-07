#!/bin/bash
[ "$1" = -x ] && shift && set -x
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "This script should be sourced in order to work" 1>&2
  exit
fi

AWS_PROFILE=$1

ROLE_ARN=$(aws configure get role_arn --profile "${AWS_PROFILE}" 2>/dev/null)

if [ "${ROLE_ARN}" = "" ]; then
  echo "Not found aws profile: ${AWS_PROFILE}"
  return
fi

ACCOUNT_ID=$(echo "${ROLE_ARN}" | sed 's|arn:aws:iam::\([0-9]*\):role.*|\1|')

function get_current_account() {
  aws sts get-caller-identity 2>/dev/null | jq -r '.Account'
}

CURRENT_ACCOUNT_ID=$(get_current_account)

if [ "${ACCOUNT_ID}" = "${CURRENT_ACCOUNT_ID}" ]; then
  echo "Account still active: ${ROLE_ARN} for ${AWS_PROFILE}"
  return
fi

unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
unset AWS_SECURITY_TOKEN
unset ASSUMED_ROLE

eval $(command assume-role "${AWS_PROFILE}")

CURRENT_ACCOUNT_ID=$(get_current_account)

if [ "${ACCOUNT_ID}" = "${CURRENT_ACCOUNT_ID}" ]; then
  echo "Account activated: ${ROLE_ARN} for ${AWS_PROFILE}"
  return
fi