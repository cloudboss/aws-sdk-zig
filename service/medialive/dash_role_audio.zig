/// Dash Role Audio
pub const DashRoleAudio = enum {
    alternate,
    commentary,
    description,
    dub,
    emergency,
    enhanced_audio_intelligibility,
    karaoke,
    main,
    supplementary,

    pub const json_field_names = .{
        .alternate = "ALTERNATE",
        .commentary = "COMMENTARY",
        .description = "DESCRIPTION",
        .dub = "DUB",
        .emergency = "EMERGENCY",
        .enhanced_audio_intelligibility = "ENHANCED_AUDIO_INTELLIGIBILITY",
        .karaoke = "KARAOKE",
        .main = "MAIN",
        .supplementary = "SUPPLEMENTARY",
    };
};
