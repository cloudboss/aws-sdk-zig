/// A value that sets the access control list (ACL) permission for objects in
/// the S3 bucket
/// that an S3 File Gateway puts objects into. The default value is
/// `private`.
pub const ObjectACL = enum {
    private,
    public_read,
    public_read_write,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,
    aws_exec_read,

    pub const json_field_names = .{
        .private = "private",
        .public_read = "public_read",
        .public_read_write = "public_read_write",
        .authenticated_read = "authenticated_read",
        .bucket_owner_read = "bucket_owner_read",
        .bucket_owner_full_control = "bucket_owner_full_control",
        .aws_exec_read = "aws_exec_read",
    };
};
