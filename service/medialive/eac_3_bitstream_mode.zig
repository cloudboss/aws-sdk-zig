/// Eac3 Bitstream Mode
pub const Eac3BitstreamMode = enum {
    commentary,
    complete_main,
    emergency,
    hearing_impaired,
    visually_impaired,

    pub const json_field_names = .{
        .commentary = "COMMENTARY",
        .complete_main = "COMPLETE_MAIN",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .visually_impaired = "VISUALLY_IMPAIRED",
    };
};
