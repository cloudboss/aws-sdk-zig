/// Ac3 Bitstream Mode
pub const Ac3BitstreamMode = enum {
    commentary,
    complete_main,
    dialogue,
    emergency,
    hearing_impaired,
    music_and_effects,
    visually_impaired,
    voice_over,

    pub const json_field_names = .{
        .commentary = "COMMENTARY",
        .complete_main = "COMPLETE_MAIN",
        .dialogue = "DIALOGUE",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .music_and_effects = "MUSIC_AND_EFFECTS",
        .visually_impaired = "VISUALLY_IMPAIRED",
        .voice_over = "VOICE_OVER",
    };
};
