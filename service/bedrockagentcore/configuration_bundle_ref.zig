/// A reference to a specific version of a configuration bundle.
pub const ConfigurationBundleRef = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The version of the configuration bundle.
    bundle_version: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_version = "bundleVersion",
    };
};
