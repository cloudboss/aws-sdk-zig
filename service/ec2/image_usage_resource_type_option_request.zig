/// The options that affect the scope of the report.
pub const ImageUsageResourceTypeOptionRequest = struct {
    /// The name of the option.
    ///
    /// Valid value: `version-depth` - The number of launch template versions to
    /// check.
    option_name: ?[]const u8 = null,

    /// A value for the specified option.
    ///
    /// Valid values: Integers between `1` and `10000`
    ///
    /// Default: `20`
    option_values: ?[]const []const u8 = null,
};
