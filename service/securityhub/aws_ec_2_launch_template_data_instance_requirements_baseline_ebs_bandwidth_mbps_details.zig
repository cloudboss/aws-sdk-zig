/// The minimum and maximum baseline bandwidth to Amazon Elastic Block Store
/// (Amazon EBS), in Mbps. For more information,
/// see [Amazon EBS–optimized instances
/// ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-optimized.html) in
/// the *Amazon EC2 User Guide*.
pub const AwsEc2LaunchTemplateDataInstanceRequirementsBaselineEbsBandwidthMbpsDetails = struct {
    /// The maximum baseline bandwidth, in Mbps. If this parameter is omitted,
    /// there's no maximum limit.
    max: ?i32 = null,

    /// The minimum baseline bandwidth, in Mbps. If this parameter is omitted,
    /// there's no minimum limit.
    min: ?i32 = null,

    pub const json_field_names = .{
        .max = "Max",
        .min = "Min",
    };
};
