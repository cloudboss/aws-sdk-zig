const PresetSpeke20Audio = @import("preset_speke_20_audio.zig").PresetSpeke20Audio;
const PresetSpeke20Video = @import("preset_speke_20_video.zig").PresetSpeke20Video;

/// Specify the SPEKE version, either v1.0 or v2.0, that MediaConvert uses when
/// encrypting your output. For more information, see:
/// https://docs.aws.amazon.com/speke/latest/documentation/speke-api-specification.html To use SPEKE v1.0: Leave blank. To use SPEKE v2.0: Specify a SPEKE v2.0 video preset and a SPEKE v2.0 audio preset.
pub const EncryptionContractConfiguration = struct {
    /// Specify which SPEKE version 2.0 audio preset MediaConvert uses to request
    /// content keys from your SPEKE server. For more information, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/drm-content-speke-v2-presets.html To encrypt to your audio outputs, choose from the following: Audio preset 1, Audio preset 2, or Audio preset 3. To encrypt your audio outputs, using the same content key for both your audio and video outputs: Choose Shared. When you do, you must also set SPEKE v2.0 video preset to Shared. To not encrypt your audio outputs: Choose Unencrypted. When you do, to encrypt your video outputs, you must also specify a SPEKE v2.0 video preset (other than Shared or Unencrypted).
    speke_audio_preset: ?PresetSpeke20Audio = null,

    /// Specify which SPEKE version 2.0 video preset MediaConvert uses to request
    /// content keys from your SPEKE server. For more information, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/drm-content-speke-v2-presets.html To encrypt to your video outputs, choose from the following: Video preset 1, Video preset 2, Video preset 3, Video preset 4, Video preset 5, Video preset 6, Video preset 7, or Video preset 8. To encrypt your video outputs, using the same content key for both your video and audio outputs: Choose Shared. When you do, you must also set SPEKE v2.0 audio preset to Shared. To not encrypt your video outputs: Choose Unencrypted. When you do, to encrypt your audio outputs, you must also specify a SPEKE v2.0 audio preset (other than Shared or Unencrypted).
    speke_video_preset: ?PresetSpeke20Video = null,

    pub const json_field_names = .{
        .speke_audio_preset = "SpekeAudioPreset",
        .speke_video_preset = "SpekeVideoPreset",
    };
};
