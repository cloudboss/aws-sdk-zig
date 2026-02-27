const GitBranchFilterCriteria = @import("git_branch_filter_criteria.zig").GitBranchFilterCriteria;
const GitFilePathFilterCriteria = @import("git_file_path_filter_criteria.zig").GitFilePathFilterCriteria;
const GitTagFilterCriteria = @import("git_tag_filter_criteria.zig").GitTagFilterCriteria;

/// The event criteria that specify when a specified repository event will start
/// the
/// pipeline for the specified trigger configuration, such as the lists of Git
/// tags to
/// include and exclude.
pub const GitPushFilter = struct {
    /// The field that specifies to filter on branches for the push trigger
    /// configuration.
    branches: ?GitBranchFilterCriteria,

    /// The field that specifies to filter on file paths for the push trigger
    /// configuration.
    file_paths: ?GitFilePathFilterCriteria,

    /// The field that contains the details for the Git tags trigger
    /// configuration.
    tags: ?GitTagFilterCriteria,

    pub const json_field_names = .{
        .branches = "branches",
        .file_paths = "filePaths",
        .tags = "tags",
    };
};
