/// The minimum and maximum amount of network bandwidth, in gigabits per second
/// (Gbps).
///
/// Setting the minimum bandwidth does not guarantee that your instance will
/// achieve the
/// minimum bandwidth. Amazon EC2 will identify instance types that support the
/// specified minimum
/// bandwidth, but the actual bandwidth of your instance might go below the
/// specified minimum
/// at times. For more information, see [Available instance
/// bandwidth](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-network-bandwidth.html#available-instance-bandwidth) in the
/// *Amazon EC2 User Guide*.
pub const NetworkBandwidthGbps = struct {
    /// The maximum amount of network bandwidth, in Gbps. If this parameter is not
    /// specified, there is no
    /// maximum limit.
    max: ?f64 = null,

    /// The minimum amount of network bandwidth, in Gbps. If this parameter is not
    /// specified, there is no minimum
    /// limit.
    min: ?f64 = null,
};
