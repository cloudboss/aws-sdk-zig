/// A summary of an item in an iterable form.
pub const IterableFormListItem = struct {
    /// The description of the item.
    description: ?[]const u8 = null,

    /// The identifiers of the glossary terms associated with the item.
    glossary_terms: ?[]const []const u8 = null,

    /// The unique identifier of the item.
    item_id: ?[]const u8 = null,

    /// The name of the item.
    item_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .glossary_terms = "GlossaryTerms",
        .item_id = "ItemId",
        .item_name = "ItemName",
    };
};
