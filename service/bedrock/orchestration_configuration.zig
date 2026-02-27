const QueryTransformationConfiguration = @import("query_transformation_configuration.zig").QueryTransformationConfiguration;

/// The configuration details for the model to process the prompt prior to
/// retrieval and response generation.
pub const OrchestrationConfiguration = struct {
    /// Contains configuration details for transforming the prompt.
    query_transformation_configuration: QueryTransformationConfiguration,

    pub const json_field_names = .{
        .query_transformation_configuration = "queryTransformationConfiguration",
    };
};
