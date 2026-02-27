const EvaluationMethod = @import("evaluation_method.zig").EvaluationMethod;
const DetectorModelVersionStatus = @import("detector_model_version_status.zig").DetectorModelVersionStatus;

/// Information about the detector model version.
pub const DetectorModelVersionSummary = struct {
    /// The time the detector model version was created.
    creation_time: ?i64,

    /// The ARN of the detector model version.
    detector_model_arn: ?[]const u8,

    /// The name of the detector model.
    detector_model_name: ?[]const u8,

    /// The ID of the detector model version.
    detector_model_version: ?[]const u8,

    /// Information about the order in which events are evaluated and how actions
    /// are executed.
    evaluation_method: ?EvaluationMethod,

    /// The last time the detector model version was updated.
    last_update_time: ?i64,

    /// The ARN of the role that grants the detector model permission to perform its
    /// tasks.
    role_arn: ?[]const u8,

    /// The status of the detector model version.
    status: ?DetectorModelVersionStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .detector_model_arn = "detectorModelArn",
        .detector_model_name = "detectorModelName",
        .detector_model_version = "detectorModelVersion",
        .evaluation_method = "evaluationMethod",
        .last_update_time = "lastUpdateTime",
        .role_arn = "roleArn",
        .status = "status",
    };
};
