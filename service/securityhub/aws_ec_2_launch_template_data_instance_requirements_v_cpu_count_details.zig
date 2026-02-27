/// The minimum and maximum number of vCPUs for an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsVCpuCountDetails = struct {
    /// The maximum number of vCPUs.
    max: ?i32,

    /// The minimum number of vCPUs.
    min: ?i32,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
