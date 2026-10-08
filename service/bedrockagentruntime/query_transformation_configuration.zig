const QueryTransformationType = @import("query_transformation_type.zig").QueryTransformationType;

/// To split up the prompt and retrieve multiple sources, set the transformation
/// type to `QUERY_DECOMPOSITION`.
pub const QueryTransformationConfiguration = struct {
    /// The type of transformation to apply to the prompt.
    type: QueryTransformationType,

    pub const json_field_names = .{
        .type = "type",
    };
};
