/// Choose the audio frame wrapping mode for PCM tracks in MXF outputs. AUTO
/// (default): Uses codec-appropriate defaults - BWF for H.264/AVC, AES3 for
/// MPEG2/XDCAM. AES3: Use AES3 frame wrapping with SMPTE-compliant descriptors.
/// This setting only takes effect when the MXF profile is OP1a.
pub const MxfUncompressedAudioWrapping = enum {
    auto,
    aes3,

    pub const json_field_names = .{
        .auto = "AUTO",
        .aes3 = "AES3",
    };
};
