pub const CapabilityIssueCode = enum {
    access_denied,
    cluster_unreachable,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .cluster_unreachable = "CLUSTER_UNREACHABLE",
    };
};
