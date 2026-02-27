pub const S3AclOption = enum {
    bucket_owner_full_control,

    pub const json_field_names = .{
        .bucket_owner_full_control = "BUCKET_OWNER_FULL_CONTROL",
    };
};
