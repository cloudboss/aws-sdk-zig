const GitBranchFilterCriteria = @import("git_branch_filter_criteria.zig").GitBranchFilterCriteria;
const GitPullRequestEventType = @import("git_pull_request_event_type.zig").GitPullRequestEventType;
const GitFilePathFilterCriteria = @import("git_file_path_filter_criteria.zig").GitFilePathFilterCriteria;

/// The event criteria for the pull request trigger configuration, such as the
/// lists of
/// branches or file paths to include and exclude.
///
/// The following are valid values for the events for this filter:
///
/// * CLOSED
///
/// * OPEN
///
/// * UPDATED
pub const GitPullRequestFilter = struct {
    /// The field that specifies to filter on branches for the pull request trigger
    /// configuration.
    branches: ?GitBranchFilterCriteria = null,

    /// The field that specifies which pull request events to filter on (OPEN,
    /// UPDATED,
    /// CLOSED) for the trigger configuration.
    events: ?[]const GitPullRequestEventType = null,

    /// The field that specifies to filter on file paths for the pull request
    /// trigger
    /// configuration.
    file_paths: ?GitFilePathFilterCriteria = null,

    pub const json_field_names = .{
        .branches = "branches",
        .events = "events",
        .file_paths = "filePaths",
    };
};
