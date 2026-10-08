const GithubRepoOwnerType = @import("github_repo_owner_type.zig").GithubRepoOwnerType;

/// Details specific to a registered GitHub service.
pub const RegisteredGithubServiceDetails = struct {
    /// The GitHub repository owner name.
    owner: []const u8,

    /// The GitHub repository owner type.
    owner_type: GithubRepoOwnerType,

    /// The GitHub Enterprise Server instance URL (absent for github.com).
    target_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .owner = "owner",
        .owner_type = "ownerType",
        .target_url = "targetUrl",
    };
};
