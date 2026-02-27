/// Ignore this setting unless Style Passthrough is set to Enabled and Font
/// color set to Black, Yellow, Red, Green, Blue, or Hex. Use Apply font color
/// for additional font color controls. When you choose White text only, or
/// leave blank, your font color setting only applies to white text in your
/// input captions. For example, if your font color setting is Yellow, and your
/// input captions have red and white text, your output captions will have red
/// and yellow text. When you choose ALL_TEXT, your font color setting applies
/// to all of your output captions text.
pub const DvbSubtitleApplyFontColor = enum {
    white_text_only,
    all_text,

    pub const json_field_names = .{
        .white_text_only = "WHITE_TEXT_ONLY",
        .all_text = "ALL_TEXT",
    };
};
