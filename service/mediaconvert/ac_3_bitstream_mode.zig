/// Specify the bitstream mode for the AC-3 stream that the encoder emits. For
/// more information about the AC3 bitstream mode, see ATSC A/52-2012 (Annex E).
pub const Ac3BitstreamMode = enum {
    complete_main,
    commentary,
    dialogue,
    emergency,
    hearing_impaired,
    music_and_effects,
    visually_impaired,
    voice_over,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
        .commentary = "COMMENTARY",
        .dialogue = "DIALOGUE",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .music_and_effects = "MUSIC_AND_EFFECTS",
        .visually_impaired = "VISUALLY_IMPAIRED",
        .voice_over = "VOICE_OVER",
    };
};
