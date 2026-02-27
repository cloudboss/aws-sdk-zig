pub const PullRequestBuildCommentApproval = enum {
    disabled,
    all_pull_requests,
    fork_pull_requests,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .all_pull_requests = "ALL_PULL_REQUESTS",
        .fork_pull_requests = "FORK_PULL_REQUESTS",
    };
};
