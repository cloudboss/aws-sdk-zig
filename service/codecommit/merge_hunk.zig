const MergeHunkDetail = @import("merge_hunk_detail.zig").MergeHunkDetail;

/// Information about merge hunks in a merge or pull request operation.
pub const MergeHunk = struct {
    /// Information about the merge hunk in the base of a merge or pull request.
    base: ?MergeHunkDetail = null,

    /// Information about the merge hunk in the destination of a merge or pull
    /// request.
    destination: ?MergeHunkDetail = null,

    /// A Boolean value indicating whether a combination of hunks contains a
    /// conflict.
    /// Conflicts occur when the same file or the same lines in a file were modified
    /// in both the
    /// source and destination of a merge or pull request. Valid values include
    /// true, false, and
    /// null. True when the hunk represents a conflict and one or more files
    /// contains a line
    /// conflict. File mode conflicts in a merge do not set this to true.
    is_conflict: bool = false,

    /// Information about the merge hunk in the source of a merge or pull request.
    source: ?MergeHunkDetail = null,

    pub const json_field_names = .{
        .base = "base",
        .destination = "destination",
        .is_conflict = "isConflict",
        .source = "source",
    };
};
