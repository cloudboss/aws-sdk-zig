const ModelInputConfiguration = @import("model_input_configuration.zig").ModelInputConfiguration;
const ModelEndpointStatus = @import("model_endpoint_status.zig").ModelEndpointStatus;
const ModelSource = @import("model_source.zig").ModelSource;
const ModelOutputConfiguration = @import("model_output_configuration.zig").ModelOutputConfiguration;

/// The Amazon SageMaker model.
pub const ExternalModel = struct {
    /// The model ARN.
    arn: ?[]const u8,

    /// Timestamp of when the model was last created.
    created_time: ?[]const u8,

    /// The input configuration.
    input_configuration: ?ModelInputConfiguration,

    /// The role used to invoke the model.
    invoke_model_endpoint_role_arn: ?[]const u8,

    /// Timestamp of when the model was last updated.
    last_updated_time: ?[]const u8,

    /// The Amazon SageMaker model endpoints.
    model_endpoint: ?[]const u8,

    /// The Amazon Fraud Detector status for the external model endpoint
    model_endpoint_status: ?ModelEndpointStatus,

    /// The source of the model.
    model_source: ?ModelSource,

    /// The output configuration.
    output_configuration: ?ModelOutputConfiguration,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .input_configuration = "inputConfiguration",
        .invoke_model_endpoint_role_arn = "invokeModelEndpointRoleArn",
        .last_updated_time = "lastUpdatedTime",
        .model_endpoint = "modelEndpoint",
        .model_endpoint_status = "modelEndpointStatus",
        .model_source = "modelSource",
        .output_configuration = "outputConfiguration",
    };
};
