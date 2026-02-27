pub const CannedACL = enum {
    private,
    public_read,
    public_read_write,
    aws_exec_read,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,

    pub const json_field_names = .{
        .private = "Private",
        .public_read = "PublicRead",
        .public_read_write = "PublicReadWrite",
        .aws_exec_read = "AwsExecRead",
        .authenticated_read = "AuthenticatedRead",
        .bucket_owner_read = "BucketOwnerRead",
        .bucket_owner_full_control = "BucketOwnerFullControl",
    };
};
