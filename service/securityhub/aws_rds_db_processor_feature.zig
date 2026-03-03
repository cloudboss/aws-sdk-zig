/// A processor feature.
pub const AwsRdsDbProcessorFeature = struct {
    /// The name of the processor feature. Valid values are `coreCount` or
    /// `threadsPerCore`.
    name: ?[]const u8 = null,

    /// The value of the processor feature.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
