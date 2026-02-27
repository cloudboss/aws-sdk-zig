pub const S3CannedAccessControlList = enum {
    private,
    public_read,
    public_read_write,
    aws_exec_read,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,
};
