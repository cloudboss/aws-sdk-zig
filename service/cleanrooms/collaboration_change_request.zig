const aws = @import("aws");

const ApprovalStatusDetails = @import("approval_status_details.zig").ApprovalStatusDetails;
const Change = @import("change.zig").Change;
const ChangeRequestStatus = @import("change_request_status.zig").ChangeRequestStatus;

/// Represents a request to modify a collaboration. Change requests enable
/// structured modifications to collaborations after they have been created.
pub const CollaborationChangeRequest = struct {
    /// A list of approval details from collaboration members, including approval
    /// status and multi-party approval workflow information.
    approvals: ?[]const aws.map.MapEntry(ApprovalStatusDetails),

    /// The list of changes specified in this change request.
    changes: []const Change,

    /// The unique identifier for the collaboration being modified.
    collaboration_id: []const u8,

    /// The time when the change request was created.
    create_time: i64,

    /// The unique identifier for the change request.
    id: []const u8,

    /// Whether the change request was automatically approved based on the
    /// collaboration's auto-approval settings.
    is_auto_approved: bool,

    /// The current status of the change request. Valid values are `PENDING`,
    /// `APPROVED`, `DENIED`, `COMMITTED`, and `CANCELLED`.
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
