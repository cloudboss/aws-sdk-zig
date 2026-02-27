const OverrideStatus = @import("override_status.zig").OverrideStatus;

/// Returns information about an override event for approval rules for a pull
/// request.
pub const ApprovalRuleOverriddenEventMetadata = struct {
    /// The status of the override event.
    override_status: ?OverrideStatus,

    /// The revision ID of the pull request when the override event occurred.
    revision_id: ?[]const u8,

    pub const json_field_names = .{
        .override_status = "overrideStatus",
        .revision_id = "revisionId",
    };
};
