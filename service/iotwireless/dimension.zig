const DimensionName = @import("dimension_name.zig").DimensionName;

/// The required list of dimensions for the metric.
pub const Dimension = struct {
    /// The name of the dimension.
    name: ?DimensionName,

    /// The dimension's value.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
