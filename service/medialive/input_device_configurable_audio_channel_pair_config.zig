const InputDeviceConfigurableAudioChannelPairProfile = @import("input_device_configurable_audio_channel_pair_profile.zig").InputDeviceConfigurableAudioChannelPairProfile;

/// One audio configuration that specifies the format for one audio pair that
/// the device produces as output.
pub const InputDeviceConfigurableAudioChannelPairConfig = struct {
    /// The ID for one audio pair configuration, a value from 1 to 8.
    id: ?i32,

    /// The profile to set for one audio pair configuration. Choose an enumeration
    /// value. Each value describes one audio configuration using the format (rate
    /// control algorithm)-(codec)_(quality)-(bitrate in bytes). For example,
    /// CBR-AAC_HQ-192000. Or choose DISABLED, in which case the device won't
    /// produce audio for this pair.
    profile: ?InputDeviceConfigurableAudioChannelPairProfile,

    pub const json_field_names = .{
        .id = "Id",
        .profile = "Profile",
    };
};
