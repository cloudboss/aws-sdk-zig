const DataIntegrationFlowDatasetSource = @import("data_integration_flow_dataset_source.zig").DataIntegrationFlowDatasetSource;
const DataIntegrationFlowS3Source = @import("data_integration_flow_s3_source.zig").DataIntegrationFlowS3Source;
const DataIntegrationFlowSourceType = @import("data_integration_flow_source_type.zig").DataIntegrationFlowSourceType;

/// The source information of a flow execution.
pub const DataIntegrationFlowExecutionSourceInfo = struct {
    /// The source details of a flow execution with dataset source.
    dataset_source: ?DataIntegrationFlowDatasetSource = null,

    /// The source details of a flow execution with S3 source.
    s_3_source: ?DataIntegrationFlowS3Source = null,

    /// The data integration flow execution source type.
    source_type: DataIntegrationFlowSourceType,

    pub const json_field_names = .{
        .dataset_source = "datasetSource",
        .s_3_source = "s3Source",
        .source_type = "sourceType",
    };
};
