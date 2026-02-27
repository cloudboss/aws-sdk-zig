/// The subtype containing details about the Codestar connection `Type`.
pub const CodeStarParameters = struct {
    /// The absolute path wehre the artifact resides within the repo and branch,
    /// formatted as
    /// "folder/file.json."
    artifact_path: []const u8,

    /// The specific branch where the artifact resides.
    branch: []const u8,

    /// The CodeStar ARN, which is the connection between Service Catalog and the
    /// external repository.
    connection_arn: []const u8,

    /// The specific repository where the product’s artifact-to-be-synced resides,
    /// formatted as
    /// "Account/Repo."
    repository: []const u8,

    pub const json_field_names = .{
        .artifact_path = "ArtifactPath",
        .branch = "Branch",
        .connection_arn = "ConnectionArn",
        .repository = "Repository",
    };
};
