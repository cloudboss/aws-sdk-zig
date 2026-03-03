/// An Availability Zone for the automatic scaling group.
pub const AwsAutoScalingAutoScalingGroupAvailabilityZonesListDetails = struct {
    /// The name of the Availability Zone.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
