const ComponentFailureContext = @import("component_failure_context.zig").ComponentFailureContext;
const DistributionFailureContext = @import("distribution_failure_context.zig").DistributionFailureContext;
const ImageStatus = @import("image_status.zig").ImageStatus;

/// Contains details about the failure when the image creation process fails.
/// Properties appear in the failure context when the related information is
/// available
/// for the failure.
pub const ImageFailureContext = struct {
    /// The details about the component that failed, if the failure occurred while a
    /// component was running.
    component_failure: ?ComponentFailureContext = null,

    /// The details about the distribution failure, if the failure occurred while
    /// Image Builder
    /// distributed or configured the image.
    distribution_failure: ?DistributionFailureContext = null,

    /// The name of the workflow step that failed, as it appears in the workflow
    /// document.
    failed_step: ?[]const u8 = null,

    /// The status that the image had when the failure occurred. This indicates the
    /// stage
    /// of the image creation process where the image failed, for example
    /// `BUILDING` or `DISTRIBUTING`.
    image_status: ?ImageStatus = null,

    /// The unique identifier of the workflow step execution that failed.
    step_execution_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the workflow build version that was
    /// running when the image
    /// failed.
    workflow_arn: ?[]const u8 = null,

    /// The unique identifier of the workflow execution that was running when the
    /// image
    /// failed.
    workflow_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_failure = "componentFailure",
        .distribution_failure = "distributionFailure",
        .failed_step = "failedStep",
        .image_status = "imageStatus",
        .step_execution_id = "stepExecutionId",
        .workflow_arn = "workflowArn",
        .workflow_execution_id = "workflowExecutionId",
    };
};
