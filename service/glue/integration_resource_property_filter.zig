/// A filter for integration resource properties.
pub const IntegrationResourcePropertyFilter = struct {
    /// The name of the filter. Supported filter keys are `SourceArn` and
    /// `TargetArn`.
    name: ?[]const u8 = null,

    /// A list of filter values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
