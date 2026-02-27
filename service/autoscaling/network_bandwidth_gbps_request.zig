/// Specifies the minimum and maximum for the `NetworkBandwidthGbps` object
/// when you specify
/// [InstanceRequirements](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_InstanceRequirements.html) for an Auto Scaling group.
///
/// Setting the minimum bandwidth does not guarantee that your instance will
/// achieve
/// the minimum bandwidth. Amazon EC2 will identify instance types that support
/// the specified
/// minimum bandwidth, but the actual bandwidth of your instance might go below
/// the
/// specified minimum at times. For more information, see [Available instance
/// bandwidth](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html#available-instance-bandwidth) in the
/// *Amazon EC2 User Guide*.
pub const NetworkBandwidthGbpsRequest = struct {
    /// The maximum amount of network bandwidth, in gigabits per second (Gbps).
    max: ?f64,

    /// The minimum amount of network bandwidth, in gigabits per second (Gbps).
    min: ?f64,
};
