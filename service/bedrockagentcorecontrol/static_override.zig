/// A static configuration bundle override.
pub const StaticOverride = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle to apply.
    bundle_arn: []const u8,

    /// The version of the configuration bundle to apply.
    bundle_version: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_version = "bundleVersion",
    };
};
