/// A filter that can be used when invoking a `DescribeIntegrations` request.
pub const IntegrationFilter = struct {
    /// The name of the filter.
    name: ?[]const u8 = null,

    /// A list of filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
