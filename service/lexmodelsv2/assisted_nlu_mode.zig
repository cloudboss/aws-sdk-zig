/// Defines the operational mode for Assisted Natural Language Understanding.
/// This enum determines how the enhanced NLU capabilities integrate with
/// standard intent recognition.
pub const AssistedNluMode = enum {
    primary,
    fallback,

    pub const json_field_names = .{
        .primary = "Primary",
        .fallback = "Fallback",
    };
};
