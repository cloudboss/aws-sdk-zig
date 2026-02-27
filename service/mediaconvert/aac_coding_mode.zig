/// The Coding mode that you specify determines the number of audio channels and
/// the audio channel layout metadata in your AAC output. Valid coding modes
/// depend on the Rate control mode and Profile that you select. The following
/// list shows the number of audio channels and channel layout for each coding
/// mode. * 1.0 Audio Description (Receiver Mix): One channel, C. Includes audio
/// description data from your stereo input. For more information see ETSI TS
/// 101 154 Annex E. * 1.0 Mono: One channel, C. * 2.0 Stereo: Two channels, L,
/// R. * 5.1 Surround: Six channels, C, L, R, Ls, Rs, LFE. To follow the number
/// of channels from your input audio, choose CODING_MODE_AUTO, and the service
/// will automatically choose from one of the coding modes above.
pub const AacCodingMode = enum {
    ad_receiver_mix,
    coding_mode_1_0,
    coding_mode_1_1,
    coding_mode_2_0,
    coding_mode_5_1,
    coding_mode_auto,

    pub const json_field_names = .{
        .ad_receiver_mix = "AD_RECEIVER_MIX",
        .coding_mode_1_0 = "CODING_MODE_1_0",
        .coding_mode_1_1 = "CODING_MODE_1_1",
        .coding_mode_2_0 = "CODING_MODE_2_0",
        .coding_mode_5_1 = "CODING_MODE_5_1",
        .coding_mode_auto = "CODING_MODE_AUTO",
    };
};
