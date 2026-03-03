/// The minimum and maximum baseline bandwidth to Amazon EBS, in Mbps. For more
/// information, see
/// [Amazon
/// EBS–optimized
/// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in the *Amazon EC2 User Guide*.
pub const BaselineEbsBandwidthMbpsRequest = struct {
    /// The maximum baseline bandwidth, in Mbps. To specify no maximum limit, omit
    /// this parameter.
    max: ?i32 = null,

    /// The minimum baseline bandwidth, in Mbps. To specify no minimum limit, omit
    /// this parameter.
    min: ?i32 = null,
};
