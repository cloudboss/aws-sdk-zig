const QueryTransformationMode = @import("query_transformation_mode.zig").QueryTransformationMode;
const TextToSqlConfiguration = @import("text_to_sql_configuration.zig").TextToSqlConfiguration;

/// Contains configurations for transforming the natural language query into
/// SQL.
pub const TransformationConfiguration = struct {
    /// The mode of the transformation.
    mode: QueryTransformationMode,

    /// Specifies configurations for transforming text to SQL.
    text_to_sql_configuration: ?TextToSqlConfiguration,

    pub const json_field_names = .{
        .mode = "mode",
        .text_to_sql_configuration = "textToSqlConfiguration",
    };
};
