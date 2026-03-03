const PullRequestStatusEnum = @import("pull_request_status_enum.zig").PullRequestStatusEnum;

/// Information about a change to the status of a pull request.
pub const PullRequestStatusChangedEventMetadata = struct {
    /// The changed status of the pull request.
    pull_request_status: ?PullRequestStatusEnum = null,

    pub const json_field_names = .{
        .pull_request_status = "pullRequestStatus",
    };
};
