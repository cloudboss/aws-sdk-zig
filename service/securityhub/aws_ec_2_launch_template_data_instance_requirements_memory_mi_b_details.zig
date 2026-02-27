/// The minimum and maximum amount of memory, in MiB, for an Amazon EC2
/// instance.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsMemoryMiBDetails = struct {
    /// The maximum amount of memory, in MiB.
    max: ?i32,

    /// The minimum amount of memory, in MiB.
    min: ?i32,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
