/// Returns a summary of information about the parameters of an enabled control.
pub const EnabledControlParameterSummary = struct {
    /// The key of a key/value pair.
    key: []const u8,

    /// The value of a key/value pair.
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
