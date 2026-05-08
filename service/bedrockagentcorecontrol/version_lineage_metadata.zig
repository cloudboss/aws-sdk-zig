const VersionCreatedBySource = @import("version_created_by_source.zig").VersionCreatedBySource;

/// The version lineage metadata that tracks parent versions and creation
/// source. Supports git-like two-parent merges for branch management.
pub const VersionLineageMetadata = struct {
    /// The branch name for this version. If not specified, inherits the parent's
    /// branch or defaults to `mainline`.
    branch_name: ?[]const u8 = null,

    /// A commit message describing the changes in this version.
    commit_message: ?[]const u8 = null,

    /// The source that created this version.
    created_by: ?VersionCreatedBySource = null,

    /// A list of parent version identifiers. Regular commits have 0-1 parents.
    /// Merge commits have 2 parents: the target branch parent and the source branch
    /// parent. The first parent represents the primary lineage.
    parent_version_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .commit_message = "commitMessage",
        .created_by = "createdBy",
        .parent_version_ids = "parentVersionIds",
    };
};
