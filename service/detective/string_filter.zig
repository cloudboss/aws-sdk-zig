/// A string for filtering Detective investigations.
pub const StringFilter = struct {
    /// The string filter value.
    value: []const u8,

    pub const json_field_names = .{
        .value = "Value",
    };
};
