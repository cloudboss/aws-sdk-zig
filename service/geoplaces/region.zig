/// The region or state results should be to be present in.
///
/// Example: `North Rhine-Westphalia`.
pub const Region = struct {
    /// Abbreviated code for a the state, province or region of the country.
    ///
    /// Example: `BC`.
    code: ?[]const u8 = null,

    /// Name for a the state, province, or region of the country.
    ///
    /// Example: `British Columbia`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .name = "Name",
    };
};
