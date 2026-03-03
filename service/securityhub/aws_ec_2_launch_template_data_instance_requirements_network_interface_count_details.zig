/// The minimum and maximum number of network interfaces to be attached to an
/// Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsNetworkInterfaceCountDetails = struct {
    /// The maximum number of network interfaces.
    max: ?i32 = null,

    /// The minimum number of network interfaces.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
