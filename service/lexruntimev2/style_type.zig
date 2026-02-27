pub const StyleType = enum {
    default,
    spell_by_letter,
    spell_by_word,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .spell_by_letter = "SPELL_BY_LETTER",
        .spell_by_word = "SPELL_BY_WORD",
    };
};
