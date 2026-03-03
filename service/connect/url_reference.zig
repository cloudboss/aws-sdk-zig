/// The URL reference.
pub const UrlReference = struct {
    /// Identifier of the URL reference.
    name: ?[]const u8 = null,

    /// A valid URL.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
