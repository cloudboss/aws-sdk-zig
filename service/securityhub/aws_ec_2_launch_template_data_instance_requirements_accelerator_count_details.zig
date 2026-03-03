/// The minimum and maximum number of accelerators (GPUs, FPGAs, or Amazon Web
/// Services Inferentia chips) on an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorCountDetails = struct {
    /// The maximum number of accelerators. If this parameter isn't specified,
    /// there's no maximum limit. To exclude accelerator-enabled instance types, set
    /// `Max` to `0`.
    max: ?i32 = null,

    /// The minimum number of accelerators. If this parameter isn't specified,
    /// there's no minimum limit.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
