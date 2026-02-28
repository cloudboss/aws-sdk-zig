/// Information about the Quick Setup type.
pub const QuickSetupTypeOutput = struct {
    /// The latest version number of the configuration.
    latest_version: ?[]const u8,

    /// The type of the Quick Setup configuration.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .latest_version = "LatestVersion",
        .@"type" = "Type",
    };
};
