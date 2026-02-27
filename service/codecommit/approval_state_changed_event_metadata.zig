const ApprovalState = @import("approval_state.zig").ApprovalState;

/// Returns information about a change in the approval state for a pull request.
pub const ApprovalStateChangedEventMetadata = struct {
    /// The approval status for the pull request.
    approval_status: ?ApprovalState,

    /// The revision ID of the pull request when the approval state changed.
    revision_id: ?[]const u8,

    pub const json_field_names = .{
        .approval_status = "approvalStatus",
        .revision_id = "revisionId",
    };
};
