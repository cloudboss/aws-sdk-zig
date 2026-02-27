pub const ResourceType = enum {
    s3,
    ebs,

    pub const json_field_names = .{
        .s3 = "S3",
        .ebs = "EBS",
    };
};
