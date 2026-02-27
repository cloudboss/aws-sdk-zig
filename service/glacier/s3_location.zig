const aws = @import("aws");

const Grant = @import("grant.zig").Grant;
const CannedACL = @import("canned_acl.zig").CannedACL;
const Encryption = @import("encryption.zig").Encryption;
const StorageClass = @import("storage_class.zig").StorageClass;

/// Contains information about the location in Amazon S3 where the select job
/// results are stored.
pub const S3Location = struct {
    /// A list of grants that control access to the staged results.
    access_control_list: ?[]const Grant,

    /// The name of the Amazon S3 bucket where the job results are stored.
    bucket_name: ?[]const u8,

    /// The canned access control list (ACL) to apply to the job results.
    canned_acl: ?CannedACL,

    /// Contains information about the encryption used to store the job results in
    /// Amazon S3.
    encryption: ?Encryption,

    /// The prefix that is prepended to the results for this request.
    prefix: ?[]const u8,

    /// The storage class used to store the job results.
    storage_class: ?StorageClass,

    /// The tag-set that is applied to the job results.
    tagging: ?[]const aws.map.StringMapEntry,

    /// A map of metadata to store with the job results in Amazon S3.
    user_metadata: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .access_control_list = "AccessControlList",
        .bucket_name = "BucketName",
        .canned_acl = "CannedACL",
        .encryption = "Encryption",
        .prefix = "Prefix",
        .storage_class = "StorageClass",
        .tagging = "Tagging",
        .user_metadata = "UserMetadata",
    };
};
