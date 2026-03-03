const AwsLogSourceName = @import("aws_log_source_name.zig").AwsLogSourceName;

/// To add a natively-supported Amazon Web Services service as a log source, use
/// these
/// parameters to specify the configuration settings for the log source.
pub const AwsLogSourceConfiguration = struct {
    /// Specify the Amazon Web Services account information where you want to enable
    /// Security Lake.
    accounts: ?[]const []const u8 = null,

    /// Specify the Regions where you want to enable Security Lake.
    regions: []const []const u8,

    /// The name for a Amazon Web Services source.
    source_name: AwsLogSourceName,

    /// The version for a Amazon Web Services source.
    source_version: []const u8 = "latest",

    pub const json_field_names = .{
        .accounts = "accounts",
        .regions = "regions",
        .source_name = "sourceName",
        .source_version = "sourceVersion",
    };
};
