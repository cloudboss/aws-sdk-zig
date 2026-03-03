const AssignmentStatus = @import("assignment_status.zig").AssignmentStatus;

/// IAM policy assignment summary.
pub const IAMPolicyAssignmentSummary = struct {
    /// Assignment name.
    assignment_name: ?[]const u8 = null,

    /// Assignment status.
    assignment_status: ?AssignmentStatus = null,

    pub const json_field_names = .{
        .assignment_name = "AssignmentName",
        .assignment_status = "AssignmentStatus",
    };
};
