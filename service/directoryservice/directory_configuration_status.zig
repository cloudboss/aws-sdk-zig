pub const DirectoryConfigurationStatus = enum {
    requested,
    updating,
    updated,
    failed,
    default,

    pub const json_field_names = .{
        .requested = "REQUESTED",
        .updating = "UPDATING",
        .updated = "UPDATED",
        .failed = "FAILED",
        .default = "DEFAULT",
    };
};
