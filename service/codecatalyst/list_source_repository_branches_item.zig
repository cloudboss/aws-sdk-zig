/// Information about a branch of a source repository returned in a list of
/// branches.
pub const ListSourceRepositoryBranchesItem = struct {
    /// The commit ID of the tip of the branch at the time of the request, also
    /// known as the head commit.
    head_commit_id: ?[]const u8,

    /// The time the branch was last updated, in coordinated universal time (UTC)
    /// timestamp format as specified in [RFC
    /// 3339](https://www.rfc-editor.org/rfc/rfc3339#section-5.6).
    last_updated_time: ?i64,

    /// The name of the branch.
    name: ?[]const u8,

    /// The Git reference name of the branch.
    ref: ?[]const u8,

    pub const json_field_names = .{
        .head_commit_id = "headCommitId",
        .last_updated_time = "lastUpdatedTime",
        .name = "name",
        .ref = "ref",
    };
};
