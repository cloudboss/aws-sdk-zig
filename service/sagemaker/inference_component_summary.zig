const InferenceComponentStatus = @import("inference_component_status.zig").InferenceComponentStatus;

/// A summary of the properties of an inference component.
pub const InferenceComponentSummary = struct {
    /// The time when the inference component was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the endpoint that hosts the inference
    /// component.
    endpoint_arn: []const u8,

    /// The name of the endpoint that hosts the inference component.
    endpoint_name: []const u8,

    /// The Amazon Resource Name (ARN) of the inference component.
    inference_component_arn: []const u8,

    /// The name of the inference component.
    inference_component_name: []const u8,

    /// The status of the inference component.
    inference_component_status: ?InferenceComponentStatus,

    /// The time when the inference component was last updated.
    last_modified_time: i64,

    /// The name of the production variant that hosts the inference component.
    variant_name: []const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .endpoint_arn = "EndpointArn",
        .endpoint_name = "EndpointName",
        .inference_component_arn = "InferenceComponentArn",
        .inference_component_name = "InferenceComponentName",
        .inference_component_status = "InferenceComponentStatus",
        .last_modified_time = "LastModifiedTime",
        .variant_name = "VariantName",
    };
};
