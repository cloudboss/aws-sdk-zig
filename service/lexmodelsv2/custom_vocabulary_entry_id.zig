/// The unique entry identifier for the custom vocabulary
/// items.
pub const CustomVocabularyEntryId = struct {
    /// The unique item identifier for the custom vocabulary
    /// items.
    item_id: []const u8,

    pub const json_field_names = .{
        .item_id = "itemId",
    };
};
