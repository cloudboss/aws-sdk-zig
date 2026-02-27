/// For the metric that the CloudWatch alarm is associated with, a complex type
/// that
/// contains information about one dimension.
pub const Dimension = struct {
    /// For the metric that the CloudWatch alarm is associated with, the name of one
    /// dimension.
    name: []const u8,

    /// For the metric that the CloudWatch alarm is associated with, the value of
    /// one
    /// dimension.
    value: []const u8,
};
