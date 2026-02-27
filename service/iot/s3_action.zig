const CannedAccessControlList = @import("canned_access_control_list.zig").CannedAccessControlList;

/// Describes an action to write data to an Amazon S3 bucket.
pub const S3Action = struct {
    /// The Amazon S3 bucket.
    bucket_name: []const u8,

    /// The Amazon S3 canned ACL that controls access to the object identified by
    /// the object
    /// key. For more information, see [S3 canned
    /// ACLs](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl).
    canned_acl: ?CannedAccessControlList,

    /// The object key. For more information, see [Actions, resources, and condition
    /// keys for Amazon
    /// S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/list_amazons3.html).
    key: []const u8,

    /// The ARN of the IAM role that grants access.
    role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .canned_acl = "cannedAcl",
        .key = "key",
        .role_arn = "roleArn",
    };
};
