const CloudConnectorFilterKey = @import("cloud_connector_filter_key.zig").CloudConnectorFilterKey;

/// A filter for listing cloud connectors.
pub const CloudConnectorFilter = struct {
    /// The name of the filter key.
    filter_key: ?CloudConnectorFilterKey = null,

    /// The filter values. Valid values for each filter key are as follows:
    ///
    /// **SubscriptionId**
    ///
    /// The Azure subscription ID to filter by. To return only tenant-level
    /// connectors,
    /// specify `NONE`.
    ///
    /// **TenantId**
    ///
    /// The Azure tenant ID to filter by. Filters the results to connectors
    /// that target the specified tenant.
    filter_values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .filter_key = "FilterKey",
        .filter_values = "FilterValues",
    };
};
