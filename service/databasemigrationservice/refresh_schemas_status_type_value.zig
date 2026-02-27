pub const RefreshSchemasStatusTypeValue = enum {
    successful,
    failed,
    refreshing,

    pub const json_field_names = .{
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
        .refreshing = "REFRESHING",
    };
};
