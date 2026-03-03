/// Defines a CloudWatch dimension value to publish.
pub const StatelessCustomPublishMetricActionDimension = struct {
    /// The value to use for the custom metric dimension.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
