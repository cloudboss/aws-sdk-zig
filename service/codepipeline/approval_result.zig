const ApprovalStatus = @import("approval_status.zig").ApprovalStatus;

/// Represents information about the result of an approval request.
pub const ApprovalResult = struct {
    /// The response submitted by a reviewer assigned to an approval action
    /// request.
    status: ApprovalStatus,

    /// The summary of the current status of the approval request.
    summary: []const u8,

    pub const json_field_names = .{
        .status = "status",
        .summary = "summary",
    };
};
