pub const CannedAclForObjectsValue = enum {
    none,
    private,
    public_read,
    public_read_write,
    authenticated_read,
    aws_exec_read,
    bucket_owner_read,
    bucket_owner_full_control,

    pub const json_field_names = .{
        .none = "NONE",
        .private = "PRIVATE",
        .public_read = "PUBLIC_READ",
        .public_read_write = "PUBLIC_READ_WRITE",
        .authenticated_read = "AUTHENTICATED_READ",
        .aws_exec_read = "AWS_EXEC_READ",
        .bucket_owner_read = "BUCKET_OWNER_READ",
        .bucket_owner_full_control = "BUCKET_OWNER_FULL_CONTROL",
    };
};
