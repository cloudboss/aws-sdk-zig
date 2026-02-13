const ParametersFilterKey = @import("parameters_filter_key.zig").ParametersFilterKey;

/// This data type is deprecated. Instead, use ParameterStringFilter.
pub const ParametersFilter = struct {
    /// The name of the filter.
    key: ParametersFilterKey,

    /// The filter values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
