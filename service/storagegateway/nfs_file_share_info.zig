const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const NFSFileShareDefaults = @import("nfs_file_share_defaults.zig").NFSFileShareDefaults;
const ObjectACL = @import("object_acl.zig").ObjectACL;
const Tag = @import("tag.zig").Tag;

/// The Unix file permissions and ownership information assigned, by default, to
/// native S3
/// objects when an S3 File Gateway discovers them in S3 buckets. This operation
/// is only
/// supported in S3 File Gateways.
pub const NFSFileShareInfo = struct {
    /// The Amazon Resource Name (ARN) of the storage used for audit logs.
    audit_destination_arn: ?[]const u8,

    /// Specifies the Region of the S3 bucket where the NFS file share stores files.
    ///
    /// This parameter is required for NFS file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    bucket_region: ?[]const u8,

    /// Refresh cache information for the file share.
    cache_attributes: ?CacheAttributes,

    client_list: ?[]const []const u8,

    /// The default storage class for objects put into an Amazon S3 bucket by the S3
    /// File Gateway. The default value is `S3_STANDARD`. Optional.
    ///
    /// Valid Values: `S3_STANDARD` | `S3_INTELLIGENT_TIERING` |
    /// `S3_STANDARD_IA` | `S3_ONEZONE_IA`
    default_storage_class: ?[]const u8,

    /// A value that specifies the type of server-side encryption that the file
    /// share will use
    /// for the data that it stores in Amazon S3.
    ///
    /// We recommend using `EncryptionType` instead of `KMSEncrypted`
    /// to set the file share encryption method. You do not need to provide values
    /// for both
    /// parameters.
    ///
    /// If values for both parameters exist in the same request, then the specified
    /// encryption methods must not conflict. For example, if `EncryptionType` is
    /// `SseS3`, then `KMSEncrypted` must be `false`. If
    /// `EncryptionType` is `SseKms` or `DsseKms`, then
    /// `KMSEncrypted` must be `true`.
    encryption_type: ?EncryptionType,

    file_share_arn: ?[]const u8,

    file_share_id: ?[]const u8,

    /// The name of the file share. Optional.
    ///
    /// `FileShareName` must be set if an S3 prefix name is set in
    /// `LocationARN`, or if an access point or access point alias is used.
    file_share_name: ?[]const u8,

    file_share_status: ?[]const u8,

    gateway_arn: ?[]const u8,

    /// A value that enables guessing of the MIME type for uploaded objects based on
    /// file
    /// extensions. Set this value to `true` to enable MIME type guessing, otherwise
    /// set
    /// to `false`. The default value is `true`.
    ///
    /// Valid Values: `true` | `false`
    guess_mime_type_enabled: ?bool,

    /// Optional. Set to `true` to use Amazon S3 server-side encryption with
    /// your own KMS key (SSE-KMS), or `false` to use a key managed by
    /// Amazon S3 (SSE-S3). To use dual-layer encryption (DSSE-KMS), set the
    /// `EncryptionType` parameter instead.
    ///
    /// We recommend using `EncryptionType` instead of `KMSEncrypted`
    /// to set the file share encryption method. You do not need to provide values
    /// for both
    /// parameters.
    ///
    /// If values for both parameters exist in the same request, then the specified
    /// encryption methods must not conflict. For example, if `EncryptionType` is
    /// `SseS3`, then `KMSEncrypted` must be `false`. If
    /// `EncryptionType` is `SseKms` or `DsseKms`, then
    /// `KMSEncrypted` must be `true`.
    ///
    /// Valid Values: `true` | `false`
    kms_encrypted: bool = false,

    kms_key: ?[]const u8,

    location_arn: ?[]const u8,

    nfs_file_share_defaults: ?NFSFileShareDefaults,

    /// The notification policy of the file share. `SettlingTimeInSeconds` controls
    /// the number of seconds to wait after the last point in time a client wrote to
    /// a file before
    /// generating an `ObjectUploaded` notification. Because clients can make many
    /// small
    /// writes to files, it's best to set this parameter for as long as possible to
    /// avoid
    /// generating multiple notifications for the same file in a small time period.
    ///
    /// `SettlingTimeInSeconds` has no effect on the timing of the object
    /// uploading to Amazon S3, only the timing of the notification.
    ///
    /// This setting is not meant to specify an exact time at which the notification
    /// will be
    /// sent. In some cases, the gateway might require more than the specified delay
    /// time to
    /// generate and send notifications.
    ///
    /// The following example sets `NotificationPolicy` on with
    /// `SettlingTimeInSeconds` set to 60.
    ///
    /// `{\"Upload\": {\"SettlingTimeInSeconds\": 60}}`
    ///
    /// The following example sets `NotificationPolicy` off.
    ///
    /// `{}`
    notification_policy: ?[]const u8,

    object_acl: ?ObjectACL,

    path: ?[]const u8,

    /// A value that sets the write status of a file share. Set this value to `true`
    /// to set the write status to read-only, otherwise set to `false`.
    ///
    /// Valid Values: `true` | `false`
    read_only: ?bool,

    /// A value that sets who pays the cost of the request and the cost associated
    /// with data
    /// download from the S3 bucket. If this value is set to `true`, the requester
    /// pays
    /// the costs; otherwise, the S3 bucket owner pays. However, the S3 bucket owner
    /// always pays
    /// the cost of storing data.
    ///
    /// `RequesterPays` is a configuration for the S3 bucket that backs the file
    /// share, so make sure that the configuration on the file share is the same as
    /// the S3
    /// bucket configuration.
    ///
    /// Valid Values: `true` | `false`
    requester_pays: ?bool,

    role: ?[]const u8,

    squash: ?[]const u8,

    /// A list of up to 50 tags assigned to the NFS file share, sorted
    /// alphabetically by key
    /// name. Each tag is a key-value pair. For a gateway with more than 10 tags
    /// assigned, you can
    /// view all tags using the `ListTagsForResource` API operation.
    tags: ?[]const Tag,

    /// Specifies the DNS name for the VPC endpoint that the NFS file share uses to
    /// connect to
    /// Amazon S3.
    ///
    /// This parameter is required for NFS file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    vpc_endpoint_dns_name: ?[]const u8,

    pub const json_field_names = .{
        .audit_destination_arn = "AuditDestinationARN",
        .bucket_region = "BucketRegion",
        .cache_attributes = "CacheAttributes",
        .client_list = "ClientList",
        .default_storage_class = "DefaultStorageClass",
        .encryption_type = "EncryptionType",
        .file_share_arn = "FileShareARN",
        .file_share_id = "FileShareId",
        .file_share_name = "FileShareName",
        .file_share_status = "FileShareStatus",
        .gateway_arn = "GatewayARN",
        .guess_mime_type_enabled = "GuessMIMETypeEnabled",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .location_arn = "LocationARN",
        .nfs_file_share_defaults = "NFSFileShareDefaults",
        .notification_policy = "NotificationPolicy",
        .object_acl = "ObjectACL",
        .path = "Path",
        .read_only = "ReadOnly",
        .requester_pays = "RequesterPays",
        .role = "Role",
        .squash = "Squash",
        .tags = "Tags",
        .vpc_endpoint_dns_name = "VPCEndpointDNSName",
    };
};
