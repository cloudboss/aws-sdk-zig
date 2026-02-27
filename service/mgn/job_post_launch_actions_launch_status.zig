const PostLaunchActionExecutionStatus = @import("post_launch_action_execution_status.zig").PostLaunchActionExecutionStatus;
const SsmDocument = @import("ssm_document.zig").SsmDocument;
const SsmDocumentType = @import("ssm_document_type.zig").SsmDocumentType;

/// Launch Status of the Job Post Launch Actions.
pub const JobPostLaunchActionsLaunchStatus = struct {
    /// AWS Systems Manager Document's execution ID of the of the Job Post Launch
    /// Actions.
    execution_id: ?[]const u8,

    /// AWS Systems Manager Document's execution status.
    execution_status: ?PostLaunchActionExecutionStatus,

    /// AWS Systems Manager Document's failure reason.
    failure_reason: ?[]const u8,

    /// AWS Systems Manager's Document of the of the Job Post Launch Actions.
    ssm_document: ?SsmDocument,

    /// AWS Systems Manager Document type.
    ssm_document_type: ?SsmDocumentType,

    pub const json_field_names = .{
        .execution_id = "executionID",
        .execution_status = "executionStatus",
        .failure_reason = "failureReason",
        .ssm_document = "ssmDocument",
        .ssm_document_type = "ssmDocumentType",
    };
};
