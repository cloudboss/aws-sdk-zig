pub const SupportedStorageEnum = enum {
    ebs,
    s3,

    pub const json_field_names = .{
        .ebs = "EBS",
        .s3 = "S3",
    };
};
