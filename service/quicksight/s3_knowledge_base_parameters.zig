/// The parameters that are required to connect to a S3 Knowledge Base data
/// source.
pub const S3KnowledgeBaseParameters = struct {
    /// The URL of the S3 bucket that contains the knowledge base data.
    bucket_url: []const u8,

    /// The location of metadata files within the S3 bucket that describe the
    /// structure and content of the knowledge base.
    metadata_files_location: ?[]const u8,

    /// Use the `RoleArn` structure to override an account-wide role for a specific
    /// S3 Knowledge Base data source. For example, say an account administrator has
    /// turned off all S3 access with an account-wide role. The administrator can
    /// then use `RoleArn` to bypass the account-wide role and allow S3 access for
    /// the single S3 Knowledge Base data source that is specified in the structure,
    /// even if the account-wide role forbidding S3 access is still active.
    role_arn: ?[]const u8,

    pub const json_field_names = .{
        .bucket_url = "BucketUrl",
        .metadata_files_location = "MetadataFilesLocation",
        .role_arn = "RoleArn",
    };
};
