const ConnectorFilterName = @import("connector_filter_name.zig").ConnectorFilterName;

/// Filters connectors based on the connector provider.
pub const ConnectorFilter = struct {
    /// The name of the filter. Currently, only `provider` is supported.
    filter_name: ?ConnectorFilterName = null,

    /// The value of the filter. For `provider`, valid values include: `AZURE`.
    filter_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filter_name = "filterName",
        .filter_values = "filterValues",
    };
};
