const AwsLogSourceResource = @import("aws_log_source_resource.zig").AwsLogSourceResource;

/// Automatically enable new organization accounts as member accounts from an
/// Amazon Security Lake
/// administrator account.
pub const DataLakeAutoEnableNewAccountConfiguration = struct {
    /// The Amazon Web Services Regions where Security Lake is automatically
    /// enabled.
    region: []const u8,

    /// The Amazon Web Services sources that are automatically enabled in Security
    /// Lake.
    sources: []const AwsLogSourceResource,

    pub const json_field_names = .{
        .region = "region",
        .sources = "sources",
    };
};
