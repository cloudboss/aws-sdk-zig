/// Structure containing a name field limited to 64 characters for header or
/// query parameter identification.
pub const SingleHeader = struct {
    /// The name value, limited to 64 characters.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
