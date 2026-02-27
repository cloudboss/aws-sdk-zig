/// Specify which SPEKE version 2.0 video preset MediaConvert uses to request
/// content keys from your SPEKE server. For more information, see:
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/drm-content-speke-v2-presets.html To encrypt to your video outputs, choose from the following: Video preset 1, Video preset 2, Video preset 3, Video preset 4, Video preset 5, Video preset 6, Video preset 7, or Video preset 8. To encrypt your video outputs, using the same content key for both your video and audio outputs: Choose Shared. When you do, you must also set SPEKE v2.0 audio preset to Shared. To not encrypt your video outputs: Choose Unencrypted. When you do, to encrypt your audio outputs, you must also specify a SPEKE v2.0 audio preset (other than Shared or Unencrypted).
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
