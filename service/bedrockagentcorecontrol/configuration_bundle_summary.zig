/// Summary information about a configuration bundle.
pub const ConfigurationBundleSummary = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The unique identifier of the configuration bundle.
    bundle_id: []const u8,

    /// The name of the configuration bundle.
    bundle_name: []const u8,

    /// The description of the configuration bundle.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_id = "bundleId",
        .bundle_name = "bundleName",
        .description = "description",
    };
};
