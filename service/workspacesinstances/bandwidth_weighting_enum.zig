pub const BandwidthWeightingEnum = enum {
    default,
    vpc_1,
    ebs_1,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .vpc_1 = "VPC_1",
        .ebs_1 = "EBS_1",
    };
};
