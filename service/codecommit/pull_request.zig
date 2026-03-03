const ApprovalRule = @import("approval_rule.zig").ApprovalRule;
const PullRequestStatusEnum = @import("pull_request_status_enum.zig").PullRequestStatusEnum;
const PullRequestTarget = @import("pull_request_target.zig").PullRequestTarget;

/// Returns information about a pull request.
pub const PullRequest = struct {
    /// The approval rules applied to the pull request.
    approval_rules: ?[]const ApprovalRule = null,

    /// The Amazon Resource Name (ARN) of the user who created the pull request.
    author_arn: ?[]const u8 = null,

    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    client_request_token: ?[]const u8 = null,

    /// The date and time the pull request was originally created, in timestamp
    /// format.
    creation_date: ?i64 = null,

    /// The user-defined description of the pull request. This description can be
    /// used to clarify what should be reviewed and other details of the request.
    description: ?[]const u8 = null,

    /// The day and time of the last user or system activity on the pull request, in
    /// timestamp format.
    last_activity_date: ?i64 = null,

    /// The system-generated ID of the pull request.
    pull_request_id: ?[]const u8 = null,

    /// The status of the pull request. Pull request status can only change from
    /// `OPEN` to `CLOSED`.
    pull_request_status: ?PullRequestStatusEnum = null,

    /// The targets of the pull request, including the source branch and destination
    /// branch for the pull request.
    pull_request_targets: ?[]const PullRequestTarget = null,

    /// The system-generated revision ID for the pull request.
    revision_id: ?[]const u8 = null,

    /// The user-defined title of the pull request. This title is displayed in the
    /// list of
    /// pull requests to other repository users.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .approval_rules = "approvalRules",
        .author_arn = "authorArn",
        .client_request_token = "clientRequestToken",
        .creation_date = "creationDate",
        .description = "description",
        .last_activity_date = "lastActivityDate",
        .pull_request_id = "pullRequestId",
        .pull_request_status = "pullRequestStatus",
        .pull_request_targets = "pullRequestTargets",
        .revision_id = "revisionId",
        .title = "title",
    };
};
