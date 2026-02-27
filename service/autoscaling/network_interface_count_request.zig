/// Specifies the minimum and maximum for the `NetworkInterfaceCount` object
/// when you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
pub const NetworkInterfaceCountRequest = struct {
    /// The maximum number of network interfaces.
    max: ?i32,

    /// The minimum number of network interfaces.
    min: ?i32,
};
