/// A key-value filter used to narrow the list of integration table properties
/// returned by ListIntegrationTableProperties. Specify a filter key and one or
/// more values to match.
pub const IntegrationTablePropertiesFilter = struct {
    /// The name of the filter. Supported filter keys are `SourceArn`, `TargetArn`,
    /// `SourceTableName`, and `TargetTableName`.
    name: ?[]const u8 = null,

    /// A list of filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
