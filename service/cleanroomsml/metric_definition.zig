/// Information about the model metric that is reported for a trained model.
pub const MetricDefinition = struct {
    /// The name of the model metric.
    name: []const u8,

    /// The regular expression statement that defines how the model metric is
    /// reported.
    regex: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .regex = "regex",
    };
};
