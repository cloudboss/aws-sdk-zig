/// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
/// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
/// E).
pub const Eac3BitstreamMode = enum {
    complete_main,
    commentary,
    emergency,
    hearing_impaired,
    visually_impaired,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
        .commentary = "COMMENTARY",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .visually_impaired = "VISUALLY_IMPAIRED",
    };
};
