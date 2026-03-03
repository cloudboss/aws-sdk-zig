const ConflictMetadata = @import("conflict_metadata.zig").ConflictMetadata;
const MergeHunk = @import("merge_hunk.zig").MergeHunk;

/// Information about conflicts in a merge operation.
pub const Conflict = struct {
    /// Metadata about a conflict in a merge operation.
    conflict_metadata: ?ConflictMetadata = null,

    /// A list of hunks that contain the differences between files or lines causing
    /// the conflict.
    merge_hunks: ?[]const MergeHunk = null,

    pub const json_field_names = .{
        .conflict_metadata = "conflictMetadata",
        .merge_hunks = "mergeHunks",
    };
};
