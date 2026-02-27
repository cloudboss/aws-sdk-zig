/// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
/// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
/// E).
pub const Eac3AtmosBitstreamMode = enum {
    complete_main,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
    };
};
