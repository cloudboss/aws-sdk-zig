const CacheAttributes = @import("cache_attributes.zig").CacheAttributes;
const CaseSensitivity = @import("case_sensitivity.zig").CaseSensitivity;
const EncryptionType = @import("encryption_type.zig").EncryptionType;
const ObjectACL = @import("object_acl.zig").ObjectACL;
const Tag = @import("tag.zig").Tag;

/// The Windows file permissions and ownership information assigned, by default,
/// to native
/// S3 objects when S3 File Gateway discovers them in S3 buckets. This operation
/// is only
/// supported for S3 File Gateways.
pub const SMBFileShareInfo = struct {
    /// Indicates whether `AccessBasedEnumeration` is enabled.
    access_based_enumeration: ?bool,

    /// A list of users or groups in the Active Directory that have administrator
    /// rights to the
    /// file share. A group must be prefixed with the @ character. Acceptable
    /// formats include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    admin_user_list: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the storage used for audit logs.
    audit_destination_arn: ?[]const u8,

    authentication: ?[]const u8,

    /// Specifies the Region of the S3 bucket where the SMB file share stores files.
    ///
    /// This parameter is required for SMB file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    bucket_region: ?[]const u8,

    /// Refresh cache information for the file share.
    cache_attributes: ?CacheAttributes,

    /// The case of an object name in an Amazon S3 bucket. For
    /// `ClientSpecified`, the client determines the case sensitivity. For
    /// `CaseSensitive`, the gateway determines the case sensitivity. The default
    /// value is `ClientSpecified`.
    case_sensitivity: ?CaseSensitivity,

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

    /// A list of users or groups in the Active Directory that are not allowed to
    /// access the
    /// file share. A group must be prefixed with the @ character. Acceptable
    /// formats include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    invalid_user_list: ?[]const []const u8,

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

    /// Specifies whether opportunistic locking is enabled for the SMB file share.
    ///
    /// Enabling opportunistic locking on case-sensitive shares is not recommended
    /// for
    /// workloads that involve access to files with the same name in different case.
    ///
    /// Valid Values: `true` | `false`
    oplocks_enabled: ?bool,

    /// The file share path used by the SMB client to identify the mount point.
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

    /// If this value is set to `true`, it indicates that access control list (ACL)
    /// is enabled on the SMB file share. If it is set to `false`, it indicates that
    /// file and directory permissions are mapped to the POSIX permission.
    ///
    /// For more information, see [Using Windows ACLs to limit SMB file share
    /// access](https://docs.aws.amazon.com/filegateway/latest/files3/smb-acl.html)
    /// in the *Amazon S3 File Gateway User
    /// Guide*.
    smbacl_enabled: ?bool,

    /// A list of up to 50 tags assigned to the SMB file share, sorted
    /// alphabetically by key
    /// name. Each tag is a key-value pair. For a gateway with more than 10 tags
    /// assigned, you can
    /// view all tags using the `ListTagsForResource` API operation.
    tags: ?[]const Tag,

    /// A list of users or groups in the Active Directory that are allowed to access
    /// the file
    /// share. A group must be prefixed with the @ character. Acceptable formats
    /// include:
    /// `DOMAIN\User1`, `user1`, `@group1`, and
    /// `@DOMAIN\group1`. Can only be set if Authentication is set to
    /// `ActiveDirectory`.
    valid_user_list: ?[]const []const u8,

    /// Specifies the DNS name for the VPC endpoint that the SMB file share uses to
    /// connect to
    /// Amazon S3.
    ///
    /// This parameter is required for SMB file shares that connect to Amazon S3
    /// through a VPC endpoint, a VPC access point, or an access point alias that
    /// points to a
    /// VPC access point.
    vpc_endpoint_dns_name: ?[]const u8,

    pub const json_field_names = .{
        .access_based_enumeration = "AccessBasedEnumeration",
        .admin_user_list = "AdminUserList",
        .audit_destination_arn = "AuditDestinationARN",
        .authentication = "Authentication",
        .bucket_region = "BucketRegion",
        .cache_attributes = "CacheAttributes",
        .case_sensitivity = "CaseSensitivity",
        .default_storage_class = "DefaultStorageClass",
        .encryption_type = "EncryptionType",
        .file_share_arn = "FileShareARN",
        .file_share_id = "FileShareId",
        .file_share_name = "FileShareName",
        .file_share_status = "FileShareStatus",
        .gateway_arn = "GatewayARN",
        .guess_mime_type_enabled = "GuessMIMETypeEnabled",
        .invalid_user_list = "InvalidUserList",
        .kms_encrypted = "KMSEncrypted",
        .kms_key = "KMSKey",
        .location_arn = "LocationARN",
        .notification_policy = "NotificationPolicy",
        .object_acl = "ObjectACL",
        .oplocks_enabled = "OplocksEnabled",
        .path = "Path",
        .read_only = "ReadOnly",
        .requester_pays = "RequesterPays",
        .role = "Role",
        .smbacl_enabled = "SMBACLEnabled",
        .tags = "Tags",
        .valid_user_list = "ValidUserList",
        .vpc_endpoint_dns_name = "VPCEndpointDNSName",
    };
};
