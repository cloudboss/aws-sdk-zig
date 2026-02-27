/// The minimum and maximum amount of memory per vCPU, in GiB.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsMemoryGiBPerVCpuDetails = struct {
    /// The maximum amount of memory per vCPU, in GiB. If this parameter is omitted,
    /// there's no maximum limit.
    max: ?f64,

    /// The minimum amount of memory per vCPU, in GiB. If this parameter is omitted,
    /// there's no maximum limit.
    min: ?f64,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
