/// The minimum and maximum baseline bandwidth to Amazon EBS, in Mbps. For more
/// information, see
/// [Amazon
/// EBS–optimized
/// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the *Amazon EC2 User Guide*.
pub const BaselineEbsBandwidthMbps = struct {
    /// The maximum baseline bandwidth, in Mbps. If this parameter is not specified,
    /// there is no
    /// maximum limit.
    max: ?i32,

    /// The minimum baseline bandwidth, in Mbps. If this parameter is not specified,
    /// there is no
    /// minimum limit.
    min: ?i32,
};
