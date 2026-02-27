/// The details of the import of the metadata form type.
pub const Import = struct {
    /// The name of the import.
    name: []const u8,

    /// The revision of the import.
    revision: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .revision = "revision",
    };
};
