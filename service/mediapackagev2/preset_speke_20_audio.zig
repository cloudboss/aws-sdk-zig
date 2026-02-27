pub const PresetSpeke20Audio = enum {
    preset_audio_1,
    preset_audio_2,
    preset_audio_3,
    shared,
    unencrypted,

    pub const json_field_names = .{
        .preset_audio_1 = "PRESET_AUDIO_1",
        .preset_audio_2 = "PRESET_AUDIO_2",
        .preset_audio_3 = "PRESET_AUDIO_3",
        .shared = "SHARED",
        .unencrypted = "UNENCRYPTED",
    };
};
