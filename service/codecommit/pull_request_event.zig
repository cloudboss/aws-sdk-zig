const ApprovalRuleEventMetadata = @import("approval_rule_event_metadata.zig").ApprovalRuleEventMetadata;
const ApprovalRuleOverriddenEventMetadata = @import("approval_rule_overridden_event_metadata.zig").ApprovalRuleOverriddenEventMetadata;
const ApprovalStateChangedEventMetadata = @import("approval_state_changed_event_metadata.zig").ApprovalStateChangedEventMetadata;
const PullRequestCreatedEventMetadata = @import("pull_request_created_event_metadata.zig").PullRequestCreatedEventMetadata;
const PullRequestEventType = @import("pull_request_event_type.zig").PullRequestEventType;
const PullRequestMergedStateChangedEventMetadata = @import("pull_request_merged_state_changed_event_metadata.zig").PullRequestMergedStateChangedEventMetadata;
const PullRequestSourceReferenceUpdatedEventMetadata = @import("pull_request_source_reference_updated_event_metadata.zig").PullRequestSourceReferenceUpdatedEventMetadata;
const PullRequestStatusChangedEventMetadata = @import("pull_request_status_changed_event_metadata.zig").PullRequestStatusChangedEventMetadata;

/// Returns information about a pull request event.
pub const PullRequestEvent = struct {
    /// The Amazon Resource Name (ARN) of the user whose actions resulted in the
    /// event.
    /// Examples include updating the pull request with more commits or changing the
    /// status of a
    /// pull request.
    actor_arn: ?[]const u8 = null,

    /// Information about a pull request event.
    approval_rule_event_metadata: ?ApprovalRuleEventMetadata = null,

    /// Information about an approval rule override event for a pull request.
    approval_rule_overridden_event_metadata: ?ApprovalRuleOverriddenEventMetadata = null,

    /// Information about an approval state change for a pull request.
    approval_state_changed_event_metadata: ?ApprovalStateChangedEventMetadata = null,

    /// The day and time of the pull request event, in timestamp format.
    event_date: ?i64 = null,

    /// Information about the source and destination branches for the pull request.
    pull_request_created_event_metadata: ?PullRequestCreatedEventMetadata = null,

    /// The type of the pull request event (for example, a status change event
    /// (PULL_REQUEST_STATUS_CHANGED) or update event
    /// (PULL_REQUEST_SOURCE_REFERENCE_UPDATED)).
    pull_request_event_type: ?PullRequestEventType = null,

    /// The system-generated ID of the pull request.
    pull_request_id: ?[]const u8 = null,

    /// Information about the change in mergability state for the pull request
    /// event.
    pull_request_merged_state_changed_event_metadata: ?PullRequestMergedStateChangedEventMetadata = null,

    /// Information about the updated source branch for the pull request event.
    pull_request_source_reference_updated_event_metadata: ?PullRequestSourceReferenceUpdatedEventMetadata = null,

    /// Information about the change in status for the pull request event.
    pull_request_status_changed_event_metadata: ?PullRequestStatusChangedEventMetadata = null,

    pub const json_field_names = .{
        .actor_arn = "actorArn",
        .approval_rule_event_metadata = "approvalRuleEventMetadata",
        .approval_rule_overridden_event_metadata = "approvalRuleOverriddenEventMetadata",
        .approval_state_changed_event_metadata = "approvalStateChangedEventMetadata",
        .event_date = "eventDate",
        .pull_request_created_event_metadata = "pullRequestCreatedEventMetadata",
        .pull_request_event_type = "pullRequestEventType",
        .pull_request_id = "pullRequestId",
        .pull_request_merged_state_changed_event_metadata = "pullRequestMergedStateChangedEventMetadata",
        .pull_request_source_reference_updated_event_metadata = "pullRequestSourceReferenceUpdatedEventMetadata",
        .pull_request_status_changed_event_metadata = "pullRequestStatusChangedEventMetadata",
    };
};
