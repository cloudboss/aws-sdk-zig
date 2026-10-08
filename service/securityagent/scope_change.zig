/// A code change in a CI/CD pipeline run that defines what a CI/CD pentest job
/// tests. Each scope change identifies an integrated repository and the commit
/// range for the change.
pub const ScopeChange = struct {
    /// The commit SHA that the change is compared against. When omitted, the change
    /// is evaluated against the head commit alone.
    base_commit_sha: ?[]const u8 = null,

    /// The commit SHA at the tip of the change to be tested.
    head_commit_sha: []const u8,

    /// The identifier of the integration for the source-code provider that hosts
    /// the repository.
    integration_id: []const u8,

    /// The provider-specific identifier of the repository the change belongs to.
    provider_resource_id: []const u8,

    /// The identifier of the CI/CD pipeline run that triggered this pentest job.
    trigger_run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_commit_sha = "baseCommitSha",
        .head_commit_sha = "headCommitSha",
        .integration_id = "integrationId",
        .provider_resource_id = "providerResourceId",
        .trigger_run_id = "triggerRunId",
    };
};
