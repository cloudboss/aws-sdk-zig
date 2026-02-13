const DescribeActivationsFilterKeys = @import("describe_activations_filter_keys.zig").DescribeActivationsFilterKeys;

/// Filter for the DescribeActivation API.
pub const DescribeActivationsFilter = struct {
    /// The name of the filter.
    filter_key: ?DescribeActivationsFilterKeys,

    /// The filter values.
    filter_values: ?[]const []const u8,

    pub const json_field_names = .{
        .filter_key = "FilterKey",
        .filter_values = "FilterValues",
    };
};
