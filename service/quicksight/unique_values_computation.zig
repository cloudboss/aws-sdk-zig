const DimensionField = @import("dimension_field.zig").DimensionField;

/// The unique values computation configuration.
pub const UniqueValuesComputation = struct {
    /// The category field that is used in a computation.
    category: ?DimensionField = null,

    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "Category",
        .computation_id = "ComputationId",
        .name = "Name",
    };
};
