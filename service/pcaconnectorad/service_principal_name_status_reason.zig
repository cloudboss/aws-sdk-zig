pub const ServicePrincipalNameStatusReason = enum {
    directory_access_denied,
    directory_not_reachable,
    directory_resource_not_found,
    spn_exists_on_different_ad_object,
    spn_limit_exceeded,
    internal_failure,

    pub const json_field_names = .{
        .directory_access_denied = "DIRECTORY_ACCESS_DENIED",
        .directory_not_reachable = "DIRECTORY_NOT_REACHABLE",
        .directory_resource_not_found = "DIRECTORY_RESOURCE_NOT_FOUND",
        .spn_exists_on_different_ad_object = "SPN_EXISTS_ON_DIFFERENT_AD_OBJECT",
        .spn_limit_exceeded = "SPN_LIMIT_EXCEEDED",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
