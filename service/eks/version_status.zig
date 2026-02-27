pub const VersionStatus = enum {
    unsupported,
    standard_support,
    extended_support,

    pub const json_field_names = .{
        .unsupported = "UNSUPPORTED",
        .standard_support = "STANDARD_SUPPORT",
        .extended_support = "EXTENDED_SUPPORT",
    };
};
