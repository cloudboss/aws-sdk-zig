pub const FargateProfileIssueCode = enum {
    pod_execution_role_already_in_use,
    access_denied,
    cluster_unreachable,
    internal_failure,

    pub const json_field_names = .{
        .pod_execution_role_already_in_use = "POD_EXECUTION_ROLE_ALREADY_IN_USE",
        .access_denied = "ACCESS_DENIED",
        .cluster_unreachable = "CLUSTER_UNREACHABLE",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
