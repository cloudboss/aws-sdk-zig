const AggregationTypeName = @import("aggregation_type_name.zig").AggregationTypeName;

/// The type of aggregation queries.
pub const AggregationType = struct {
    /// The name of the aggregation type.
    name: AggregationTypeName,

    /// A list of the values of aggregation types.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
