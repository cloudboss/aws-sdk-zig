pub const AutomaticUpdatePolicy = enum {
    all_versions,
    emergency_versions_only,

    pub const json_field_names = .{
        .all_versions = "ALL_VERSIONS",
        .emergency_versions_only = "EMERGENCY_VERSIONS_ONLY",
    };
};
