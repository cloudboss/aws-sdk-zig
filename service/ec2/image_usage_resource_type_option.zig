/// The options that affect the scope of the report.
pub const ImageUsageResourceTypeOption = struct {
    /// The name of the option.
    option_name: ?[]const u8 = null,

    /// The number of launch template versions to check.
    option_values: ?[]const []const u8 = null,
};
