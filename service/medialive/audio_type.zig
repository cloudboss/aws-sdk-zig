/// Audio Type
pub const AudioType = enum {
    clean_effects,
    hearing_impaired,
    @"undefined",
    visual_impaired_commentary,

    pub const json_field_names = .{
        .clean_effects = "CLEAN_EFFECTS",
        .hearing_impaired = "HEARING_IMPAIRED",
        .@"undefined" = "UNDEFINED",
        .visual_impaired_commentary = "VISUAL_IMPAIRED_COMMENTARY",
    };
};
