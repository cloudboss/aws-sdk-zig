const TriggerFilterGroup = @import("trigger_filter_group.zig").TriggerFilterGroup;

/// Capabilities for an integrated GitLab repository.
pub const GitLabResourceCapabilities = struct {
    /// Whether to post code review comments on merge request discussions.
    leave_comments: ?bool = null,

    /// Whether to create merge requests with automated fixes.
    remediate_code: ?bool = null,

    /// The filter groups that control which merge request events start an automatic
    /// code review when `leaveComments` is enabled. A review starts when any group
    /// matches. If you omit this, a review starts on
    /// `PULL_REQUEST_READY_FOR_REVIEW` events.
    trigger_filter_groups: ?[]const TriggerFilterGroup = null,

    pub const json_field_names = .{
        .leave_comments = "leaveComments",
        .remediate_code = "remediateCode",
        .trigger_filter_groups = "triggerFilterGroups",
    };
};
