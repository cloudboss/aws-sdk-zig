/// Specifies the credit option for CPU usage of a T2, T3, or T3a Amazon EC2
/// instance.
pub const AwsEc2LaunchTemplateDataCreditSpecificationDetails = struct {
    /// The credit option for CPU usage of a T instance.
    cpu_credits: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu_credits = "CpuCredits",
    };
};
