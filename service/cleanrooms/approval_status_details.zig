const ApprovalStatus = @import("approval_status.zig").ApprovalStatus;

/// Contains detailed information about the approval state of a given member in
/// the collaboration for a given collaboration change request.
pub const ApprovalStatusDetails = struct {
    /// The approval status of a member's vote on the change request. Valid values
    /// are PENDING (if they haven't voted), APPROVED, or DENIED.
    status: ApprovalStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
