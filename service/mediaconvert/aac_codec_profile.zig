/// Specify the AAC profile. For the widest player compatibility and where
/// higher bitrates are acceptable: Keep the default profile, LC (AAC-LC) For
/// improved audio performance at lower bitrates: Choose HEV1 or HEV2. HEV1
/// (AAC-HE v1) adds spectral band replication to improve speech audio at low
/// bitrates. HEV2 (AAC-HE v2) adds parametric stereo, which optimizes for
/// encoding stereo audio at very low bitrates. For improved audio quality at
/// lower bitrates, adaptive audio bitrate switching, and loudness control:
/// Choose XHE.
pub const AacCodecProfile = enum {
    lc,
    hev1,
    hev2,
    xhe,

    pub const json_field_names = .{
        .lc = "LC",
        .hev1 = "HEV1",
        .hev2 = "HEV2",
        .xhe = "XHE",
    };
};
