/// The alpha-2 or alpha-3 character code for the country that the results will
/// be present in.
pub const Country = struct {
    /// Country, represented by its alpha 2-character code.
    code_2: ?[]const u8 = null,

    /// Country, represented by its alpha t-character code.
    code_3: ?[]const u8 = null,

    /// Name of the country.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .code_2 = "Code2",
        .code_3 = "Code3",
        .name = "Name",
    };
};
