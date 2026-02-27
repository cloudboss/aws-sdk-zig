/// The dimension of an Amazon CloudWatch metric that is used when DevOps Guru
/// analyzes the resources in
/// your account for operational problems and anomalous behavior. A dimension is
/// a
/// name/value pair that is part of the identity of a metric. A metric can have
/// up to 10
/// dimensions. For more information, see
/// [Dimensions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#Dimension) in the *Amazon CloudWatch User Guide*.
pub const CloudWatchMetricsDimension = struct {
    /// The name of the CloudWatch dimension.
    name: ?[]const u8,

    /// The value of the CloudWatch dimension.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
