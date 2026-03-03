const DataIntegrationFlowDatasetTargetConfiguration = @import("data_integration_flow_dataset_target_configuration.zig").DataIntegrationFlowDatasetTargetConfiguration;
const DataIntegrationFlowS3TargetConfiguration = @import("data_integration_flow_s3_target_configuration.zig").DataIntegrationFlowS3TargetConfiguration;
const DataIntegrationFlowTargetType = @import("data_integration_flow_target_type.zig").DataIntegrationFlowTargetType;

/// The DataIntegrationFlow target parameters.
pub const DataIntegrationFlowTarget = struct {
    /// The dataset DataIntegrationFlow target. Note that for AWS Supply Chain
    /// dataset under **asc** namespace, it has a connection_id internal field that
    /// is not allowed to be provided by client directly, they will be auto
    /// populated.
    dataset_target: ?DataIntegrationFlowDatasetTargetConfiguration = null,

    /// The S3 DataIntegrationFlow target.
    s_3_target: ?DataIntegrationFlowS3TargetConfiguration = null,

    /// The DataIntegrationFlow target type.
    target_type: DataIntegrationFlowTargetType,

    pub const json_field_names = .{
        .dataset_target = "datasetTarget",
        .s_3_target = "s3Target",
        .target_type = "targetType",
    };
};
