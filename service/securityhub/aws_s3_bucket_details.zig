const AwsS3BucketBucketLifecycleConfigurationDetails = @import("aws_s3_bucket_bucket_lifecycle_configuration_details.zig").AwsS3BucketBucketLifecycleConfigurationDetails;
const AwsS3BucketLoggingConfiguration = @import("aws_s3_bucket_logging_configuration.zig").AwsS3BucketLoggingConfiguration;
const AwsS3BucketNotificationConfiguration = @import("aws_s3_bucket_notification_configuration.zig").AwsS3BucketNotificationConfiguration;
const AwsS3BucketBucketVersioningConfiguration = @import("aws_s3_bucket_bucket_versioning_configuration.zig").AwsS3BucketBucketVersioningConfiguration;
const AwsS3BucketWebsiteConfiguration = @import("aws_s3_bucket_website_configuration.zig").AwsS3BucketWebsiteConfiguration;
const AwsS3BucketObjectLockConfiguration = @import("aws_s3_bucket_object_lock_configuration.zig").AwsS3BucketObjectLockConfiguration;
const AwsS3AccountPublicAccessBlockDetails = @import("aws_s3_account_public_access_block_details.zig").AwsS3AccountPublicAccessBlockDetails;
const AwsS3BucketServerSideEncryptionConfiguration = @import("aws_s3_bucket_server_side_encryption_configuration.zig").AwsS3BucketServerSideEncryptionConfiguration;

/// The details of an Amazon Simple Storage Service (Amazon S3) bucket.
pub const AwsS3BucketDetails = struct {
    /// The access control list for the S3 bucket.
    access_control_list: ?[]const u8 = null,

    /// The lifecycle configuration for objects in the specified bucket.
    bucket_lifecycle_configuration: ?AwsS3BucketBucketLifecycleConfigurationDetails = null,

    /// The logging configuration for the S3 bucket.
    bucket_logging_configuration: ?AwsS3BucketLoggingConfiguration = null,

    /// The notification configuration for the S3 bucket.
    bucket_notification_configuration: ?AwsS3BucketNotificationConfiguration = null,

    /// The versioning state of an S3 bucket.
    bucket_versioning_configuration: ?AwsS3BucketBucketVersioningConfiguration = null,

    /// The website configuration parameters for the S3 bucket.
    bucket_website_configuration: ?AwsS3BucketWebsiteConfiguration = null,

    /// Indicates when the S3 bucket was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_at: ?[]const u8 = null,

    /// The name of the bucket.
    name: ?[]const u8 = null,

    /// Specifies which rule Amazon S3 applies by default to every new object placed
    /// in the bucket.
    object_lock_configuration: ?AwsS3BucketObjectLockConfiguration = null,

    /// The Amazon Web Services account identifier of the account that owns the S3
    /// bucket.
    owner_account_id: ?[]const u8 = null,

    /// The canonical user ID of the owner of the S3 bucket.
    owner_id: ?[]const u8 = null,

    /// The display name of the owner of the S3 bucket.
    owner_name: ?[]const u8 = null,

    /// Provides information about the Amazon S3 Public Access Block configuration
    /// for the S3 bucket.
    public_access_block_configuration: ?AwsS3AccountPublicAccessBlockDetails = null,

    /// The encryption rules that are applied to the S3 bucket.
    server_side_encryption_configuration: ?AwsS3BucketServerSideEncryptionConfiguration = null,

    pub const json_field_names = .{
        .access_control_list = "AccessControlList",
        .bucket_lifecycle_configuration = "BucketLifecycleConfiguration",
        .bucket_logging_configuration = "BucketLoggingConfiguration",
        .bucket_notification_configuration = "BucketNotificationConfiguration",
        .bucket_versioning_configuration = "BucketVersioningConfiguration",
        .bucket_website_configuration = "BucketWebsiteConfiguration",
        .created_at = "CreatedAt",
        .name = "Name",
        .object_lock_configuration = "ObjectLockConfiguration",
        .owner_account_id = "OwnerAccountId",
        .owner_id = "OwnerId",
        .owner_name = "OwnerName",
        .public_access_block_configuration = "PublicAccessBlockConfiguration",
        .server_side_encryption_configuration = "ServerSideEncryptionConfiguration",
    };
};
