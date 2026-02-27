const PresetSpeke20Audio = @import("preset_speke_20_audio.zig").PresetSpeke20Audio;
const PresetSpeke20Video = @import("preset_speke_20_video.zig").PresetSpeke20Video;

/// Configure one or more content encryption keys for your endpoints that use
/// SPEKE Version 2.0. The encryption contract defines which content keys are
/// used to encrypt the audio and video tracks in your stream. To configure the
/// encryption contract, specify which audio and video encryption presets to
/// use.
pub const EncryptionContractConfiguration = struct {
    /// A collection of audio encryption presets.
    ///
    /// Value description:
    ///
    /// * PRESET-AUDIO-1 - Use one content key to encrypt all of the audio tracks in
    ///   your stream.
    /// * PRESET-AUDIO-2 - Use one content key to encrypt all of the stereo audio
    ///   tracks and one content key to encrypt all of the multichannel audio
    ///   tracks.
    /// * PRESET-AUDIO-3 - Use one content key to encrypt all of the stereo audio
    ///   tracks, one content key to encrypt all of the multichannel audio tracks
    ///   with 3 to 6 channels, and one content key to encrypt all of the
    ///   multichannel audio tracks with more than 6 channels.
    /// * SHARED - Use the same content key for all of the audio and video tracks in
    ///   your stream.
    /// * UNENCRYPTED - Don't encrypt any of the audio tracks in your stream.
    preset_speke_20_audio: PresetSpeke20Audio,

    /// A collection of video encryption presets.
    ///
    /// Value description:
    ///
    /// * PRESET-VIDEO-1 - Use one content key to encrypt all of the video tracks in
    ///   your stream.
    /// * PRESET-VIDEO-2 - Use one content key to encrypt all of the SD video tracks
    ///   and one content key for all HD and higher resolutions video tracks.
    /// * PRESET-VIDEO-3 - Use one content key to encrypt all of the SD video
    ///   tracks, one content key for HD video tracks and one content key for all
    ///   UHD video tracks.
    /// * PRESET-VIDEO-4 - Use one content key to encrypt all of the SD video
    ///   tracks, one content key for HD video tracks, one content key for all UHD1
    ///   video tracks and one content key for all UHD2 video tracks.
    /// * PRESET-VIDEO-5 - Use one content key to encrypt all of the SD video
    ///   tracks, one content key for HD1 video tracks, one content key for HD2
    ///   video tracks, one content key for all UHD1 video tracks and one content
    ///   key for all UHD2 video tracks.
    /// * PRESET-VIDEO-6 - Use one content key to encrypt all of the SD video
    ///   tracks, one content key for HD1 video tracks, one content key for HD2
    ///   video tracks and one content key for all UHD video tracks.
    /// * PRESET-VIDEO-7 - Use one content key to encrypt all of the SD+HD1 video
    ///   tracks, one content key for HD2 video tracks and one content key for all
    ///   UHD video tracks.
    /// * PRESET-VIDEO-8 - Use one content key to encrypt all of the SD+HD1 video
    ///   tracks, one content key for HD2 video tracks, one content key for all UHD1
    ///   video tracks and one content key for all UHD2 video tracks.
    /// * SHARED - Use the same content key for all of the video and audio tracks in
    ///   your stream.
    /// * UNENCRYPTED - Don't encrypt any of the video tracks in your stream.
    preset_speke_20_video: PresetSpeke20Video,

    pub const json_field_names = .{
        .preset_speke_20_audio = "PresetSpeke20Audio",
        .preset_speke_20_video = "PresetSpeke20Video",
    };
};
