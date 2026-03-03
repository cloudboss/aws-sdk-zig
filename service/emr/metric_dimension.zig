/// A CloudWatch dimension, which is specified using a `Key` (known as a
/// `Name` in CloudWatch), `Value` pair. By default, Amazon EMR uses one
/// dimension whose `Key` is `JobFlowID` and
/// `Value` is a variable representing the cluster ID, which is
/// `${emr.clusterId}`. This enables the rule to bootstrap when the cluster ID
/// becomes available.
pub const MetricDimension = struct {
    /// The dimension name.
    key: ?[]const u8 = null,

    /// The dimension value.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
