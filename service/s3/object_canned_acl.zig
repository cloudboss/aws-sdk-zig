pub const ObjectCannedACL = enum {
    private,
    public_read,
    public_read_write,
    authenticated_read,
    aws_exec_read,
    bucket_owner_read,
    bucket_owner_full_control,
};
