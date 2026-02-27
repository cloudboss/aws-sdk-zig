/// The new custom vocabulary item from the custom
/// vocabulary list.
pub const NewCustomVocabularyItem = struct {
    /// The display as value assigned to the new custom vocabulary item from the
    /// custom
    /// vocabulary list.
    display_as: ?[]const u8,

    /// The unique phrase for the new custom vocabulary item from the custom
    /// vocabulary list.
    phrase: []const u8,

    /// The weight assigned to the new custom vocabulary item from the custom
    /// vocabulary list.
    weight: ?i32,

    pub const json_field_names = .{
        .display_as = "displayAs",
        .phrase = "phrase",
        .weight = "weight",
    };
};
