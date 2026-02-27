/// A single mapping entry for each supported specifier or sub-field.
pub const MappingRule = struct {
    /// Specifier within a certificate field, such as CN, OU, or UID from the
    /// Subject field.
    specifier: []const u8,

    pub const json_field_names = .{
        .specifier = "specifier",
    };
};
