/// A summary of a business glossary.
pub const GlossaryItem = struct {
    /// The description of the glossary.
    description: ?[]const u8 = null,

    /// The unique identifier of the glossary.
    id: ?[]const u8 = null,

    /// The name of the glossary.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
