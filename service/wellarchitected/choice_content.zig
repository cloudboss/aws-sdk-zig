/// The choice content.
pub const ChoiceContent = struct {
    /// The display text for the choice content.
    display_text: ?[]const u8 = null,

    /// The URL for the choice content.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_text = "DisplayText",
        .url = "Url",
    };
};
