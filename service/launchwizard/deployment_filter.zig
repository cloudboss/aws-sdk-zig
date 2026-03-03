const DeploymentFilterKey = @import("deployment_filter_key.zig").DeploymentFilterKey;

/// A filter name and value pair that is used to return more specific results
/// from a describe operation. Filters can be used to match a set of resources
/// by specific criteria.
pub const DeploymentFilter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: ?DeploymentFilterKey = null,

    /// The filter values. Filter values are case-sensitive. If you specify multiple
    /// values for a filter, the values are joined with an `OR`, and the request
    /// returns all results that match any of the specified values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
