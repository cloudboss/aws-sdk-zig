/// An infrastructure as code defined resource output.
pub const Output = struct {
    /// The output key.
    key: ?[]const u8 = null,

    /// The output value.
    value_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "key",
        .value_string = "valueString",
    };
};
