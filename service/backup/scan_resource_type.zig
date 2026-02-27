pub const ScanResourceType = enum {
    ebs,
    ec2,
    s3,

    pub const json_field_names = .{
        .ebs = "EBS",
        .ec2 = "EC2",
        .s3 = "S3",
    };
};
