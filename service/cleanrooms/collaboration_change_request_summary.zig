const aws = @import("aws");

const ApprovalStatusDetails = @import("approval_status_details.zig").ApprovalStatusDetails;
const Change = @import("change.zig").Change;
const ChangeRequestStatus = @import("change_request_status.zig").ChangeRequestStatus;

/// Summary information about a collaboration change request.
pub const CollaborationChangeRequestSummary = struct {
    /// Summary of approval statuses from all collaboration members for this change
    /// request.
    approvals: ?[]const aws.map.MapEntry(ApprovalStatusDetails),

    /// Summary of the changes in this change request.
    changes: []const Change,

    /// The unique identifier for the collaboration.
    collaboration_id: []const u8,

    /// The time when the change request was created.
    create_time: i64,

    /// The unique identifier for the change request.
    id: []const u8,

    /// Whether the change request was automatically approved.
    is_auto_approved: bool,

    /// The current status of the change request.
    status: ChangeRequestStatus,

    /// The time when the change request was last updated.
    update_time: i64,

    pub const json_field_names = .{
        .approvals = "approvals",
        .changes = "changes",
        .collaboration_id = "collaborationId",
        .create_time = "createTime",
        .id = "id",
        .is_auto_approved = "isAutoApproved",
        .status = "status",
        .update_time = "updateTime",
    };
};
