/// Indicates whether optimization to directory listing on S3 servers is used.
/// Disabled by default for compatibility.
pub const DirectoryListingOptimization = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
