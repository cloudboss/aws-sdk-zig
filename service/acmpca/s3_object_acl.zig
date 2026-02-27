pub const S3ObjectAcl = enum {
    public_read,
    bucket_owner_full_control,

    pub const json_field_names = .{
        .public_read = "PUBLIC_READ",
        .bucket_owner_full_control = "BUCKET_OWNER_FULL_CONTROL",
    };
};
