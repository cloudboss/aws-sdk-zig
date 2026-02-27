const QueryTransformationType = @import("query_transformation_type.zig").QueryTransformationType;

/// The configuration details for transforming the prompt.
pub const QueryTransformationConfiguration = struct {
    /// The type of transformation to apply to the prompt.
    type: QueryTransformationType,

    pub const json_field_names = .{
        .type = "type",
    };
};
