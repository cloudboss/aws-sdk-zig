const MergeOptionTypeEnum = @import("merge_option_type_enum.zig").MergeOptionTypeEnum;

/// Returns information about a merge or potential merge between a source
/// reference and a destination reference in a pull request.
pub const MergeMetadata = struct {
    /// A Boolean value indicating whether the merge has been made.
    is_merged: bool = false,

    /// The commit ID for the merge commit, if any.
    merge_commit_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the user who merged the branches.
    merged_by: ?[]const u8,

    /// The merge strategy used in the merge.
    merge_option: ?MergeOptionTypeEnum,

    pub const json_field_names = .{
        .is_merged = "isMerged",
        .merge_commit_id = "mergeCommitId",
        .merged_by = "mergedBy",
        .merge_option = "mergeOption",
    };
};
