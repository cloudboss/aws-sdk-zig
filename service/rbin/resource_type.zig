pub const ResourceType = enum {
    ebs_snapshot,
    ec2_image,
    ebs_volume,

    pub const json_field_names = .{
        .ebs_snapshot = "EBS_SNAPSHOT",
        .ec2_image = "EC2_IMAGE",
        .ebs_volume = "EBS_VOLUME",
    };
};
