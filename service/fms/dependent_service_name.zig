pub const DependentServiceName = enum {
    aws_config,
    awswaf,
    aws_shield_advanced,
    aws_virtual_private_cloud,

    pub const json_field_names = .{
        .aws_config = "AWSConfig",
        .awswaf = "AWSWAF",
        .aws_shield_advanced = "AWSShieldAdvanced",
        .aws_virtual_private_cloud = "AWSVirtualPrivateCloud",
    };
};
