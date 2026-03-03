const InferenceExperimentSchedule = @import("inference_experiment_schedule.zig").InferenceExperimentSchedule;
const InferenceExperimentStatus = @import("inference_experiment_status.zig").InferenceExperimentStatus;
const InferenceExperimentType = @import("inference_experiment_type.zig").InferenceExperimentType;

/// Lists a summary of properties of an inference experiment.
pub const InferenceExperimentSummary = struct {
    /// The timestamp at which the inference experiment was completed.
    completion_time: ?i64 = null,

    /// The timestamp at which the inference experiment was created.
    creation_time: i64,

    /// The description of the inference experiment.
    description: ?[]const u8 = null,

    /// The timestamp when you last modified the inference experiment.
    last_modified_time: i64,

    /// The name of the inference experiment.
    name: []const u8,

    /// The ARN of the IAM role that Amazon SageMaker can assume to access model
    /// artifacts and container images, and manage Amazon SageMaker Inference
    /// endpoints for model deployment.
    role_arn: ?[]const u8 = null,

    /// The duration for which the inference experiment ran or will run.
    ///
    /// The maximum duration that you can set for an inference experiment is 30
    /// days.
    schedule: ?InferenceExperimentSchedule = null,

    /// The status of the inference experiment.
    status: InferenceExperimentStatus,

    /// The error message for the inference experiment status result.
    status_reason: ?[]const u8 = null,

    /// The type of the inference experiment.
    @"type": InferenceExperimentType,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .status = "Status",
        .status_reason = "StatusReason",
        .@"type" = "Type",
    };
};
