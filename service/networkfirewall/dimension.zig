/// The value to use in an Amazon CloudWatch custom metric dimension. This is
/// used in the
/// `PublishMetrics`
/// CustomAction. A CloudWatch custom metric dimension is a name/value pair
/// that's
/// part of the identity of a metric.
///
/// Network Firewall sets the dimension name to `CustomAction` and you provide
/// the
/// dimension value.
///
/// For more information about CloudWatch custom metric dimensions, see
/// [Publishing Custom
/// Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html#usingDimensions) in the [Amazon CloudWatch User
/// Guide](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/WhatIsCloudWatch.html).
pub const Dimension = struct {
    /// The value to use in the custom metric dimension.
    value: []const u8,

    pub const json_field_names = .{
        .value = "Value",
    };
};
