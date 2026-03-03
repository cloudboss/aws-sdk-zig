const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// Specifies information about the specified endpoint.
/// For information about endpoints, see [Managing
/// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
pub const EndpointProperties = struct {
    /// The creation date and time of the endpoint.
    creation_time: ?i64 = null,

    /// The number of inference units currently used by the model using this
    /// endpoint.
    current_inference_units: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to trained custom models encrypted with
    /// a customer
    /// managed key (ModelKmsKeyId).
    data_access_role_arn: ?[]const u8 = null,

    /// Data access role ARN to use in case the new model is encrypted with a
    /// customer KMS
    /// key.
    desired_data_access_role_arn: ?[]const u8 = null,

    /// The desired number of inference units to be used by the model using this
    /// endpoint.
    ///
    /// Each inference unit represents of a throughput of 100 characters per second.
    desired_inference_units: ?i32 = null,

    /// ARN of the new model to use for updating an existing endpoint. This ARN is
    /// going to be
    /// different from the model ARN when the update is in progress
    desired_model_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the endpoint.
    endpoint_arn: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel
    flywheel_arn: ?[]const u8 = null,

    /// The date and time that the endpoint was last modified.
    last_modified_time: ?i64 = null,

    /// Specifies a reason for failure in cases of `Failed` status.
    message: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the model to which the endpoint is
    /// attached.
    model_arn: ?[]const u8 = null,

    /// Specifies the status of the endpoint. Because the endpoint updates and
    /// creation are
    /// asynchronous, so customers will need to wait for the endpoint to be `Ready`
    /// status
    /// before making inference requests.
    status: ?EndpointStatus = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .current_inference_units = "CurrentInferenceUnits",
        .data_access_role_arn = "DataAccessRoleArn",
        .desired_data_access_role_arn = "DesiredDataAccessRoleArn",
        .desired_inference_units = "DesiredInferenceUnits",
        .desired_model_arn = "DesiredModelArn",
        .endpoint_arn = "EndpointArn",
        .flywheel_arn = "FlywheelArn",
        .last_modified_time = "LastModifiedTime",
        .message = "Message",
        .model_arn = "ModelArn",
        .status = "Status",
    };
};
