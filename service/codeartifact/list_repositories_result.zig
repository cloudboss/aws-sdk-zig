const RepositorySummary = @import("repository_summary.zig").RepositorySummary;

pub const ListRepositoriesResult = struct {
    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8,

    /// The returned list of
    /// [RepositorySummary](https://docs.aws.amazon.com/codeartifact/latest/APIReference/API_RepositorySummary.html)
    /// objects.
    repositories: ?[]const RepositorySummary,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .repositories = "repositories",
    };
};
