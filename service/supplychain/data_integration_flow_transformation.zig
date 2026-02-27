const DataIntegrationFlowSQLTransformationConfiguration = @import("data_integration_flow_sql_transformation_configuration.zig").DataIntegrationFlowSQLTransformationConfiguration;
const DataIntegrationFlowTransformationType = @import("data_integration_flow_transformation_type.zig").DataIntegrationFlowTransformationType;

/// The DataIntegrationFlow transformation parameters.
pub const DataIntegrationFlowTransformation = struct {
    /// The SQL DataIntegrationFlow transformation configuration.
    sql_transformation: ?DataIntegrationFlowSQLTransformationConfiguration,

    /// The DataIntegrationFlow transformation type.
    transformation_type: DataIntegrationFlowTransformationType,

    pub const json_field_names = .{
        .sql_transformation = "sqlTransformation",
        .transformation_type = "transformationType",
    };
};
