pub const CoverageSortKey = enum {
    account_id,
    cluster_name,
    coverage_status,
    issue,
    addon_version,
    updated_at,
    eks_cluster_name,
    ecs_cluster_name,
    instance_id,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .cluster_name = "CLUSTER_NAME",
        .coverage_status = "COVERAGE_STATUS",
        .issue = "ISSUE",
        .addon_version = "ADDON_VERSION",
        .updated_at = "UPDATED_AT",
        .eks_cluster_name = "EKS_CLUSTER_NAME",
        .ecs_cluster_name = "ECS_CLUSTER_NAME",
        .instance_id = "INSTANCE_ID",
    };
};
