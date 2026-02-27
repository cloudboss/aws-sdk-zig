const InputDeviceUhdAudioChannelPairProfile = @import("input_device_uhd_audio_channel_pair_profile.zig").InputDeviceUhdAudioChannelPairProfile;

/// One audio configuration that specifies the format for one audio pair that
/// the device produces as output.
pub const InputDeviceUhdAudioChannelPairConfig = struct {
    /// The ID for one audio pair configuration, a value from 1 to 8.
    id: ?i32,

    /// The profile for one audio pair configuration. This property describes one
    /// audio configuration in the format (rate control
    /// algorithm)-(codec)_(quality)-(bitrate in bytes). For example,
    /// CBR-AAC_HQ-192000. Or DISABLED, in which case the device won't produce audio
    /// for this pair.
    profile: ?InputDeviceUhdAudioChannelPairProfile,

    pub const json_field_names = .{
        .id = "Id",
        .profile = "Profile",
    };
};
