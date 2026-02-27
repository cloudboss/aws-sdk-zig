/// A key-value parameter to an `EnabledBaseline` resource.
pub const EnabledBaselineParameter = struct {
    /// A string denoting the parameter key.
    key: []const u8,

    /// A low-level `Document` object of any type (for example, a Java Object).
    value: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .value = "value",
    };
};
