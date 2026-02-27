const PublicAccessConfiguration = @import("public_access_configuration.zig").PublicAccessConfiguration;
const PublicAccessStatus = @import("public_access_status.zig").PublicAccessStatus;

/// Contains information about the Amazon S3 bucket policies and encryption.
pub const S3Bucket = struct {
    /// Contains information about the public access policies that apply to the
    /// Amazon S3 bucket at the account level.
    account_public_access: ?PublicAccessConfiguration,

    /// Contains information about public access policies that apply to the Amazon
    /// S3 bucket.
    bucket_public_access: ?PublicAccessConfiguration,

    /// The timestamp at which the Amazon S3 bucket was created.
    created_at: ?i64,

    /// Describes the effective permissions on this S3 bucket, after factoring all
    /// the attached policies.
    effective_permission: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the encryption key that is used to encrypt
    /// the Amazon S3 bucket and its objects.
    encryption_key_arn: ?[]const u8,

    /// The type of encryption used for the Amazon S3 buckets and its objects. For
    /// more information,
    /// see [Protecting data with server-side
    /// encryption](https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html)
    /// in the *Amazon S3 User Guide*.
    encryption_type: ?[]const u8,

    /// The owner ID of the associated S3Amazon S3bucket.
    owner_id: ?[]const u8,

    /// Indicates whether or not the public read access is allowed for an Amazon S3
    /// bucket.
    public_read_access: ?PublicAccessStatus,

    /// Indicates whether or not the public write access is allowed for an Amazon S3
    /// bucket.
    public_write_access: ?PublicAccessStatus,

    /// Represents a list of Amazon S3 object identifiers.
    s3_object_uids: ?[]const []const u8,

    pub const json_field_names = .{
        .account_public_access = "AccountPublicAccess",
        .bucket_public_access = "BucketPublicAccess",
        .created_at = "CreatedAt",
        .effective_permission = "EffectivePermission",
        .encryption_key_arn = "EncryptionKeyArn",
        .encryption_type = "EncryptionType",
        .owner_id = "OwnerId",
        .public_read_access = "PublicReadAccess",
        .public_write_access = "PublicWriteAccess",
        .s3_object_uids = "S3ObjectUids",
    };
};
