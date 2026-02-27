/// An object representing a repository.
pub const Repository = struct {
    /// The date and time, in JavaScript date format, when the repository was
    /// created.
    created_at: ?i64,

    /// The Amazon Web Services account ID that's associated with the public
    /// registry that contains the
    /// repository.
    registry_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the repository. The ARN
    /// contains the `arn:aws:ecr` namespace, followed by the region of the
    /// repository, Amazon Web Services account ID of the repository owner,
    /// repository namespace, and repository name. For example,
    /// `arn:aws:ecr:region:012345678910:repository/test`.
    repository_arn: ?[]const u8,

    /// The name of the repository.
    repository_name: ?[]const u8,

    /// The URI for the repository. You can use this URI for container image `push`
    /// and `pull` operations.
    repository_uri: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .registry_id = "registryId",
        .repository_arn = "repositoryArn",
        .repository_name = "repositoryName",
        .repository_uri = "repositoryUri",
    };
};
