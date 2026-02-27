/// Details about the dimensions for the metric associated with the alarm.
pub const AwsCloudWatchAlarmDimensionsDetails = struct {
    /// The name of a dimension.
    name: ?[]const u8,

    /// The value of a dimension.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
