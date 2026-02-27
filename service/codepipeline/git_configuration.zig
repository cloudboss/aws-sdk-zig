const GitPullRequestFilter = @import("git_pull_request_filter.zig").GitPullRequestFilter;
const GitPushFilter = @import("git_push_filter.zig").GitPushFilter;

/// A type of trigger configuration for Git-based source actions.
///
/// You can specify the Git configuration trigger type for all third-party
/// Git-based source actions that are supported by the
/// `CodeStarSourceConnection` action type.
pub const GitConfiguration = struct {
    /// The field where the repository event that will start the pipeline is
    /// specified as
    /// pull requests.
    pull_request: ?[]const GitPullRequestFilter,

    /// The field where the repository event that will start the pipeline, such as
    /// pushing
    /// Git tags, is specified with details.
    push: ?[]const GitPushFilter,

    /// The name of the pipeline source action where the trigger configuration, such
    /// as Git
    /// tags, is specified. The trigger configuration will start the pipeline upon
    /// the specified
    /// change only.
    ///
    /// You can only specify one trigger configuration per source action.
    source_action_name: []const u8,

    pub const json_field_names = .{
        .pull_request = "pullRequest",
        .push = "push",
        .source_action_name = "sourceActionName",
    };
};
