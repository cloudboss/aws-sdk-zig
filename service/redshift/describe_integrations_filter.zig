const DescribeIntegrationsFilterName = @import("describe_integrations_filter_name.zig").DescribeIntegrationsFilterName;

/// A set of elements to filter the returned integrations.
pub const DescribeIntegrationsFilter = struct {
    /// Specifies the type of integration filter.
    name: DescribeIntegrationsFilterName,

    /// Specifies the values to filter on.
    values: []const []const u8,
};
