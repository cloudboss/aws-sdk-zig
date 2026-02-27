pub const AddonIssueCode = enum {
    access_denied,
    internal_failure,
    cluster_unreachable,
    insufficient_number_of_replicas,
    configuration_conflict,
    admission_request_denied,
    unsupported_addon_modification,
    k8_s_resource_not_found,
    addon_subscription_needed,
    addon_permission_failure,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .internal_failure = "INTERNAL_FAILURE",
        .cluster_unreachable = "CLUSTER_UNREACHABLE",
        .insufficient_number_of_replicas = "INSUFFICIENT_NUMBER_OF_REPLICAS",
        .configuration_conflict = "CONFIGURATION_CONFLICT",
        .admission_request_denied = "ADMISSION_REQUEST_DENIED",
        .unsupported_addon_modification = "UNSUPPORTED_ADDON_MODIFICATION",
        .k8_s_resource_not_found = "K8S_RESOURCE_NOT_FOUND",
        .addon_subscription_needed = "ADDON_SUBSCRIPTION_NEEDED",
        .addon_permission_failure = "ADDON_PERMISSION_FAILURE",
    };
};
