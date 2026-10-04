/// A summary of a glossary term.
pub const GlossaryTermItem = struct {
    /// The unique identifier of the glossary term.
    id: ?[]const u8 = null,

    /// The name of the glossary term.
    name: ?[]const u8 = null,

    /// The short description of the glossary term.
    short_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .short_description = "ShortDescription",
    };
};
