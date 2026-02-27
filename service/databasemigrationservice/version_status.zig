pub const VersionStatus = enum {
    up_to_date,
    outdated,
    unsupported,

    pub const json_field_names = .{
        .up_to_date = "UP_TO_DATE",
        .outdated = "OUTDATED",
        .unsupported = "UNSUPPORTED",
    };
};
