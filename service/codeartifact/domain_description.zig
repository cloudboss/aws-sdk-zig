const DomainStatus = @import("domain_status.zig").DomainStatus;

/// Information about a domain. A domain is a container for repositories. When
/// you create a domain, it is empty until you
/// add one or more repositories.
pub const DomainDescription = struct {
    /// The Amazon Resource Name (ARN) of the domain.
    arn: ?[]const u8,

    /// The total size of all assets in the domain.
    asset_size_bytes: i64 = 0,

    /// A timestamp that represents the date and time the domain was created.
    created_time: ?i64,

    /// The ARN of an Key Management Service (KMS) key associated with a domain.
    encryption_key: ?[]const u8,

    /// The name of the domain.
    name: ?[]const u8,

    /// The Amazon Web Services account ID that owns the domain.
    owner: ?[]const u8,

    /// The number of repositories in the domain.
    repository_count: i32 = 0,

    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket that is used to store
    /// package assets in the domain.
    s_3_bucket_arn: ?[]const u8,

    /// The current status of a domain.
    status: ?DomainStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .asset_size_bytes = "assetSizeBytes",
        .created_time = "createdTime",
        .encryption_key = "encryptionKey",
        .name = "name",
        .owner = "owner",
        .repository_count = "repositoryCount",
        .s_3_bucket_arn = "s3BucketArn",
        .status = "status",
    };
};
