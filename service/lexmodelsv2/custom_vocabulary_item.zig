/// The unique custom vocabulary item from the custom
/// vocabulary list.
pub const CustomVocabularyItem = struct {
    /// The DisplayAs value for the custom vocabulary item
    /// from the custom vocabulary list.
    display_as: ?[]const u8 = null,

    /// The unique item identifer for the custom vocabulary item
    /// from the custom vocabulary list.
    item_id: []const u8,

    /// The unique phrase for the custom vocabulary item
    /// from the custom vocabulary list.
    phrase: []const u8,

    /// The weight assigned for the custom vocabulary item
    /// from the custom vocabulary list.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .display_as = "displayAs",
        .item_id = "itemId",
        .phrase = "phrase",
        .weight = "weight",
    };
};
