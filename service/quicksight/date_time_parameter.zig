/// A date-time parameter.
pub const DateTimeParameter = struct {
    /// A display name for the date-time parameter.
    name: []const u8,

    /// The values for the date-time parameter.
    values: []const i64,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
