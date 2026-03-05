#!/usr/bin/env bash
set -euo pipefail

found=0
deleted=0
failed=0

log_warn() {
    printf 'WARN: %s\n' "$1"
}

log_info() {
    printf '%s\n' "$1"
}

record_found() {
    found=$((found + 1))
}

record_deleted() {
    deleted=$((deleted + 1))
}

record_failed() {
    failed=$((failed + 1))
}

run_delete() {
    if "$@"; then
        record_deleted
    else
        record_failed
        log_warn "delete failed: $*"
    fi
}

empty_s3_bucket() {
    local bucket=$1
    aws s3 rm "s3://${bucket}" --recursive >/dev/null 2>&1 || true
}

delete_route53_records() {
    local zone_id=$1
    local records
    records=$(aws route53 list-resource-record-sets \
        --hosted-zone-id "$zone_id" \
        --query 'ResourceRecordSets[?Type != `NS` && Type != `SOA`]' \
        --output json) || true

    if [[ "$records" == "[]" || -z "$records" ]]; then
        return 0
    fi

    local change_batch
    change_batch=$(printf '{"Changes":%s}' "$(printf '%s' "$records" | \
        python3 -c 'import json,sys;print(json.dumps([{"Action":"DELETE","ResourceRecordSet":r} for r in json.load(sys.stdin)]))')")

    aws route53 change-resource-record-sets \
        --hosted-zone-id "$zone_id" \
        --change-batch "$change_batch" >/dev/null 2>&1 || true
}

cleanup_arn() {
    local arn=$1

    if [[ -z "$arn" ]]; then
        return 0
    fi

    record_found
    log_info "found: $arn"

    case "$arn" in
        arn:aws:s3:::*)
            local bucket
            bucket="${arn#arn:aws:s3:::}"
            empty_s3_bucket "$bucket"
            run_delete aws s3api delete-bucket --bucket "$bucket" >/dev/null 2>&1 || true
            ;;
        arn:aws:dynamodb:*:table/*)
            run_delete aws dynamodb delete-table --table-name "${arn##*/}" >/dev/null 2>&1 || true
            ;;
        arn:aws:lambda:*:function:*)
            run_delete aws lambda delete-function --function-name "${arn##*:}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:sqs:*:*)
            run_delete aws sqs delete-queue --queue-url "$arn" >/dev/null 2>&1 || true
            ;;
        arn:aws:sns:*:*)
            run_delete aws sns delete-topic --topic-arn "$arn" >/dev/null 2>&1 || true
            ;;
        arn:aws:kinesis:*:stream/*)
            run_delete aws kinesis delete-stream --stream-name "${arn##*/}" \
                --enforce-consumer-deletion >/dev/null 2>&1 || true
            ;;
        arn:aws:secretsmanager:*:secret:*)
            run_delete aws secretsmanager delete-secret --secret-id "$arn" \
                --force-delete-without-recovery >/dev/null 2>&1 || true
            ;;
        arn:aws:ssm:*:parameter/*)
            run_delete aws ssm delete-parameter --name "${arn#*:parameter}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:elastic-ip/eipalloc-*)
            run_delete aws ec2 release-address --allocation-id "${arn#*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:instance/*)
            run_delete aws ec2 terminate-instances --instance-ids "${arn##*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:volume/*)
            run_delete aws ec2 delete-volume --volume-id "${arn##*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:security-group/*)
            run_delete aws ec2 delete-security-group --group-id "${arn##*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:subnet/subnet-*)
            run_delete aws ec2 delete-subnet --subnet-id "${arn#*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:ec2:*:vpc/*)
            run_delete aws ec2 delete-vpc --vpc-id "${arn##*/}" >/dev/null 2>&1 || true
            ;;
        arn:aws:elasticloadbalancing:*:loadbalancer/*)
            run_delete aws elb delete-load-balancer --load-balancer-name "${arn##*/}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:route53:::hostedzone/*)
            local zone_id
            zone_id="${arn##*/}"
            delete_route53_records "$zone_id"
            run_delete aws route53 delete-hosted-zone --id "$zone_id" >/dev/null 2>&1 || true
            ;;
        arn:aws:logs:*:log-group:*)
            run_delete aws logs delete-log-group --log-group-name "${arn#*:log-group:}" \
                >/dev/null 2>&1 || true
            ;;
        arn:aws:cloudwatch:*:alarm:*)
            run_delete aws cloudwatch delete-alarms --alarm-names "${arn##*:}" \
                >/dev/null 2>&1 || true
            ;;
        *)
            log_warn "unknown arn type: $arn"
            ;;
    esac
}

cleanup_tagged_resources() {
    local arns
    arns=$(aws resourcegroupstaggingapi get-resources \
        --tag-filters Key=aws-sdk-zig-test,Values=true \
        --query 'ResourceTagMappingList[].ResourceARN' \
        --output text) || true

    if [[ -z "$arns" ]]; then
        return 0
    fi

    local arn
    for arn in $arns; do
        cleanup_arn "$arn"
    done
}

detach_managed_policies() {
    local role_name=$1
    local policy_arns
    policy_arns=$(aws iam list-attached-role-policies \
        --role-name "$role_name" \
        --query 'AttachedPolicies[].PolicyArn' \
        --output text) || true

    local policy_arn
    for policy_arn in $policy_arns; do
        aws iam detach-role-policy --role-name "$role_name" --policy-arn "$policy_arn" \
            >/dev/null 2>&1 || true
    done
}

delete_inline_policies() {
    local role_name=$1
    local policy_names
    policy_names=$(aws iam list-role-policies \
        --role-name "$role_name" \
        --query 'PolicyNames' \
        --output text) || true

    local policy_name
    for policy_name in $policy_names; do
        aws iam delete-role-policy --role-name "$role_name" --policy-name "$policy_name" \
            >/dev/null 2>&1 || true
    done
}

cleanup_iam_roles() {
    local role_names
    role_names=$(aws iam list-roles \
        --query "Roles[?starts_with(RoleName, 'sdk-zig-live-')].RoleName" \
        --output text) || true

    local role_name
    for role_name in $role_names; do
        record_found
        log_info "found iam role: $role_name"
        detach_managed_policies "$role_name"
        delete_inline_policies "$role_name"
        run_delete aws iam delete-role --role-name "$role_name" >/dev/null 2>&1 || true
    done
}

detach_policy_from_entities() {
    local policy_arn=$1
    local entities
    entities=$(aws iam list-entities-for-policy \
        --policy-arn "$policy_arn" \
        --query '{Roles:PolicyRoles[].RoleName,Users:PolicyUsers[].UserName,Groups:PolicyGroups[].GroupName}' \
        --output json) || true

    local role
    for role in $(printf '%s' "$entities" | python3 -c 'import json,sys;d=json.load(sys.stdin);print(" ".join(d.get("Roles", [])))'); do
        aws iam detach-role-policy --role-name "$role" --policy-arn "$policy_arn" \
            >/dev/null 2>&1 || true
    done

    local user
    for user in $(printf '%s' "$entities" | python3 -c 'import json,sys;d=json.load(sys.stdin);print(" ".join(d.get("Users", [])))'); do
        aws iam detach-user-policy --user-name "$user" --policy-arn "$policy_arn" \
            >/dev/null 2>&1 || true
    done

    local group
    for group in $(printf '%s' "$entities" | python3 -c 'import json,sys;d=json.load(sys.stdin);print(" ".join(d.get("Groups", [])))'); do
        aws iam detach-group-policy --group-name "$group" --policy-arn "$policy_arn" \
            >/dev/null 2>&1 || true
    done
}

cleanup_iam_policies() {
    local policy_arns
    policy_arns=$(aws iam list-policies --scope Local \
        --query "Policies[?starts_with(PolicyName, 'sdk-zig-live-')].Arn" \
        --output text) || true

    local policy_arn
    for policy_arn in $policy_arns; do
        record_found
        log_info "found iam policy: $policy_arn"
        detach_policy_from_entities "$policy_arn"
        run_delete aws iam delete-policy --policy-arn "$policy_arn" >/dev/null 2>&1 || true
    done
}

cleanup_tagged_resources
cleanup_iam_roles
cleanup_iam_policies

log_info "Found $found resources, deleted $deleted, failed $failed"
exit 0
