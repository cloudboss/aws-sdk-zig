const AwsLogSourceName = @import("aws_log_source_name.zig").AwsLogSourceName;

/// Amazon Security Lake can collect logs and events from natively-supported
/// Amazon Web Services
/// services.
pub const AwsLogSourceResource = struct {
    /// The name for a Amazon Web Services source. This must be a Regionally unique
    /// value.
    source_name: ?AwsLogSourceName,

    /// The version for a Amazon Web Services source. This must be a Regionally
    /// unique value.
    source_version: ?[]const u8,

    pub const json_field_names = .{
        .source_name = "sourceName",
        .source_version = "sourceVersion",
    };
};
