pub const ClusterVersionStatus = enum {
    unsupported,
    standard_support,
    extended_support,

    pub const json_field_names = .{
        .unsupported = "unsupported",
        .standard_support = "standard_support",
        .extended_support = "extended_support",
    };
};
