const S3DestinationAccessControl = @import("s3_destination_access_control.zig").S3DestinationAccessControl;
const S3EncryptionSettings = @import("s3_encryption_settings.zig").S3EncryptionSettings;
const S3StorageClass = @import("s3_storage_class.zig").S3StorageClass;

/// Settings associated with S3 destination
pub const S3DestinationSettings = struct {
    /// Optional. Have MediaConvert automatically apply Amazon S3 access control for
    /// the outputs in this output group. When you don't use this setting, S3
    /// automatically applies the default access control list PRIVATE.
    access_control: ?S3DestinationAccessControl = null,

    /// Settings for how your job outputs are encrypted as they are uploaded to
    /// Amazon S3.
    encryption: ?S3EncryptionSettings = null,

    /// Specify the S3 storage class to use for this output. To use your
    /// destination's default storage class: Keep the default value, Not set. For
    /// more information about S3 storage classes, see
    /// https://docs.aws.amazon.com/AmazonS3/latest/userguide/storage-class-intro.html
    storage_class: ?S3StorageClass = null,

    pub const json_field_names = .{
        .access_control = "AccessControl",
        .encryption = "Encryption",
        .storage_class = "StorageClass",
    };
};
