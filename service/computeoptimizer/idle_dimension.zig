/// Describes the dimension of an idle resource utilization metric.
pub const IdleDimension = struct {
    /// The name of the dimension key.
    key: ?[]const u8 = null,

    /// The value of the dimension.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .values = "values",
    };
};
