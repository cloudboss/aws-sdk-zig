/// Describes the information about a production branch for an Amplify app.
pub const ProductionBranch = struct {
    /// The branch name for the production branch.
    branch_name: ?[]const u8 = null,

    /// The last deploy time of the production branch.
    last_deploy_time: ?i64 = null,

    /// The status of the production branch.
    status: ?[]const u8 = null,

    /// The thumbnail URL for the production branch.
    thumbnail_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch_name = "branchName",
        .last_deploy_time = "lastDeployTime",
        .status = "status",
        .thumbnail_url = "thumbnailUrl",
    };
};
