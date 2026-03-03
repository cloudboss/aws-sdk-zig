/// Information about a repository.
pub const RepositoryMetadata = struct {
    /// The ID of the Amazon Web Services account associated with the repository.
    account_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the repository.
    arn: ?[]const u8 = null,

    /// The URL to use for cloning the repository over HTTPS.
    clone_url_http: ?[]const u8 = null,

    /// The URL to use for cloning the repository over SSH.
    clone_url_ssh: ?[]const u8 = null,

    /// The date and time the repository was created, in timestamp format.
    creation_date: ?i64 = null,

    /// The repository's default branch name.
    default_branch: ?[]const u8 = null,

    /// The ID of the Key Management Service encryption key used to encrypt and
    /// decrypt the repository.
    kms_key_id: ?[]const u8 = null,

    /// The date and time the repository was last modified, in timestamp format.
    last_modified_date: ?i64 = null,

    /// A comment or description about the repository.
    repository_description: ?[]const u8 = null,

    /// The ID of the repository.
    repository_id: ?[]const u8 = null,

    /// The repository's name.
    repository_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .arn = "Arn",
        .clone_url_http = "cloneUrlHttp",
        .clone_url_ssh = "cloneUrlSsh",
        .creation_date = "creationDate",
        .default_branch = "defaultBranch",
        .kms_key_id = "kmsKeyId",
        .last_modified_date = "lastModifiedDate",
        .repository_description = "repositoryDescription",
        .repository_id = "repositoryId",
        .repository_name = "repositoryName",
    };
};
