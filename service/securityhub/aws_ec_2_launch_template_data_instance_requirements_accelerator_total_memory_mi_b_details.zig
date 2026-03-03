/// The minimum and maximum amount of memory, in MiB, for the accelerators on an
/// Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsAcceleratorTotalMemoryMiBDetails = struct {
    /// The maximum amount of memory, in MiB. If this parameter isn't specified,
    /// there's no maximum limit.
    max: ?i32 = null,

    /// The minimum amount of memory, in MiB. If `0` is specified, there's no
    /// maximum limit.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
