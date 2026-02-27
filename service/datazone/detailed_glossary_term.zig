/// Details of a glossary term attached to the inventory asset.
pub const DetailedGlossaryTerm = struct {
    /// The name of a glossary term attached to the inventory asset.
    name: ?[]const u8,

    /// The shoft description of a glossary term attached to the inventory asset.
    short_description: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .short_description = "shortDescription",
    };
};
