const FieldAggregationType = @import("field_aggregation_type.zig").FieldAggregationType;

/// Indicates the field or attribute of a resource or data structure on which a
/// condition is being applied or evaluated.
pub const Field = struct {
    /// (Optional) Indicates the type of aggregation or summary operation (such as
    /// Sum, Average, and so on) to be performed on a particular field or set of
    /// data.
    aggregation: ?FieldAggregationType = null,

    /// Name of the field.
    name: []const u8,

    pub const json_field_names = .{
        .aggregation = "aggregation",
        .name = "name",
    };
};
