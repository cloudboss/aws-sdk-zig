const GithubRepoOwnerType = @import("github_repo_owner_type.zig").GithubRepoOwnerType;

/// Configuration for GitHub repository integration.
pub const GitHubConfiguration = struct {
    /// GitHub instance identifier (e.g., github.com or github.enterprise.com)
    instance_identifier: ?[]const u8 = null,

    /// The GitHub repository owner name.
    owner: []const u8,

    owner_type: GithubRepoOwnerType,

    /// Associated Github repo ID
    repo_id: []const u8,

    /// Associated Github repo name
    repo_name: []const u8,

    /// Optional role ARN that AIDevOps assumes at runtime for automatic
    /// verification testing and VPC connectivity on this association.
    runtime_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_identifier = "instanceIdentifier",
        .owner = "owner",
        .owner_type = "ownerType",
        .repo_id = "repoId",
        .repo_name = "repoName",
        .runtime_role_arn = "runtimeRoleArn",
    };
};
