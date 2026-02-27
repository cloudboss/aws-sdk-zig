/// **Internal only**. Represents the dimensions of a metric. To learn more
/// about the metrics published to Amazon CloudWatch, see [Amazon MWAA
/// performance metrics in Amazon
/// CloudWatch](https://docs.aws.amazon.com/mwaa/latest/userguide/cw-metrics.html).
pub const Dimension = struct {
    /// **Internal only**. The name of the dimension.
    name: []const u8,

    /// **Internal only**. The value of the dimension.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
