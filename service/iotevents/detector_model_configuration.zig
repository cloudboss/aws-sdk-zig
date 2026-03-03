const EvaluationMethod = @import("evaluation_method.zig").EvaluationMethod;
const DetectorModelVersionStatus = @import("detector_model_version_status.zig").DetectorModelVersionStatus;

/// Information about how the detector model is configured.
pub const DetectorModelConfiguration = struct {
    /// The time the detector model was created.
    creation_time: ?i64 = null,

    /// The ARN of the detector model.
    detector_model_arn: ?[]const u8 = null,

    /// A brief description of the detector model.
    detector_model_description: ?[]const u8 = null,

    /// The name of the detector model.
    detector_model_name: ?[]const u8 = null,

    /// The version of the detector model.
    detector_model_version: ?[]const u8 = null,

    /// Information about the order in which events are evaluated and how actions
    /// are executed.
    evaluation_method: ?EvaluationMethod = null,

    /// The value used to identify a detector instance. When a device or system
    /// sends input, a new
    /// detector instance with a unique key value is created. AWS IoT Events can
    /// continue to route input to its
    /// corresponding detector instance based on this identifying information.
    ///
    /// This parameter uses a JSON-path expression to select the attribute-value
    /// pair in the
    /// message payload that is used for identification. To route the message to the
    /// correct detector
    /// instance, the device must send a message payload that contains the same
    /// attribute-value.
    key: ?[]const u8 = null,

    /// The time the detector model was last updated.
    last_update_time: ?i64 = null,

    /// The ARN of the role that grants permission to AWS IoT Events to perform its
    /// operations.
    role_arn: ?[]const u8 = null,

    /// The status of the detector model.
    status: ?DetectorModelVersionStatus = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .detector_model_arn = "detectorModelArn",
        .detector_model_description = "detectorModelDescription",
        .detector_model_name = "detectorModelName",
        .detector_model_version = "detectorModelVersion",
        .evaluation_method = "evaluationMethod",
        .key = "key",
        .last_update_time = "lastUpdateTime",
        .role_arn = "roleArn",
        .status = "status",
    };
};
