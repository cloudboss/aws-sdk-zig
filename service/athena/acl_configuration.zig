const S3AclOption = @import("s3_acl_option.zig").S3AclOption;

/// Indicates that an Amazon S3 canned ACL should be set to control ownership of
/// stored query results, including data files inserted by Athena as the result
/// of statements like CTAS or INSERT INTO. When Athena stores query results in
/// Amazon S3, the canned ACL is set with the `x-amz-acl` request
/// header. For more information about S3 Object Ownership, see [Object
/// Ownership
/// settings](https://docs.aws.amazon.com/AmazonS3/latest/userguide/about-object-ownership.html#object-ownership-overview) in the *Amazon S3 User
/// Guide*.
pub const AclConfiguration = struct {
    /// The Amazon S3 canned ACL that Athena should specify when storing
    /// query results, including data files inserted by Athena as the result
    /// of statements like CTAS or INSERT INTO. Currently the only supported canned
    /// ACL is
    /// `BUCKET_OWNER_FULL_CONTROL`. If a query runs in a workgroup and the
    /// workgroup overrides client-side settings, then the Amazon S3 canned ACL
    /// specified in the workgroup's settings is used for all queries that run in
    /// the workgroup.
    /// For more information about Amazon S3 canned ACLs, see [Canned
    /// ACL](https://docs.aws.amazon.com/AmazonS3/latest/userguide/acl-overview.html#canned-acl) in the *Amazon S3 User Guide*.
    s3_acl_option: S3AclOption,

    pub const json_field_names = .{
        .s3_acl_option = "S3AclOption",
    };
};
