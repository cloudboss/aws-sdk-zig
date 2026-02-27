/// A decimal parameter.
pub const DecimalParameter = struct {
    /// A display name for the decimal parameter.
    name: []const u8,

    /// The values for the decimal parameter.
    values: []const f64,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
