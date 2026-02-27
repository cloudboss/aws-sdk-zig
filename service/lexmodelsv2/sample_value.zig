/// Defines one of the values for a slot type.
pub const SampleValue = struct {
    /// The value that can be used for a slot type.
    value: []const u8,

    pub const json_field_names = .{
        .value = "value",
    };
};
