pub const PresetSpeke20Video = enum {
    preset_video_1,
    preset_video_2,
    preset_video_3,
    preset_video_4,
    preset_video_5,
    preset_video_6,
    preset_video_7,
    preset_video_8,
    shared,
    unencrypted,

    pub const json_field_names = .{
        .preset_video_1 = "PRESET_VIDEO_1",
        .preset_video_2 = "PRESET_VIDEO_2",
        .preset_video_3 = "PRESET_VIDEO_3",
        .preset_video_4 = "PRESET_VIDEO_4",
        .preset_video_5 = "PRESET_VIDEO_5",
        .preset_video_6 = "PRESET_VIDEO_6",
        .preset_video_7 = "PRESET_VIDEO_7",
        .preset_video_8 = "PRESET_VIDEO_8",
        .shared = "SHARED",
        .unencrypted = "UNENCRYPTED",
    };
};
