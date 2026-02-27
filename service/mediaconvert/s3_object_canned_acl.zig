/// Choose an Amazon S3 canned ACL for MediaConvert to apply to this output.
pub const S3ObjectCannedAcl = enum {
    public_read,
    authenticated_read,
    bucket_owner_read,
    bucket_owner_full_control,

    pub const json_field_names = .{
        .public_read = "PUBLIC_READ",
        .authenticated_read = "AUTHENTICATED_READ",
        .bucket_owner_read = "BUCKET_OWNER_READ",
        .bucket_owner_full_control = "BUCKET_OWNER_FULL_CONTROL",
    };
};
