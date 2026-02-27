/// S3 Canned Acl
pub const S3CannedAcl = enum {
    authenticated_read,
    bucket_owner_full_control,
    bucket_owner_read,
    public_read,

    pub const json_field_names = .{
        .authenticated_read = "AUTHENTICATED_READ",
        .bucket_owner_full_control = "BUCKET_OWNER_FULL_CONTROL",
        .bucket_owner_read = "BUCKET_OWNER_READ",
        .public_read = "PUBLIC_READ",
    };
};
