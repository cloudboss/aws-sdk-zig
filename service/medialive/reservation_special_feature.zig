/// Special features, 'ADVANCED_AUDIO' 'AUDIO_NORMALIZATION' 'MGHD' or 'MGUHD'
pub const ReservationSpecialFeature = enum {
    advanced_audio,
    audio_normalization,
    mghd,
    mguhd,

    pub const json_field_names = .{
        .advanced_audio = "ADVANCED_AUDIO",
        .audio_normalization = "AUDIO_NORMALIZATION",
        .mghd = "MGHD",
        .mguhd = "MGUHD",
    };
};
