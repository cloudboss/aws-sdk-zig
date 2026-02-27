const PresetSpeke20Audio = @import("preset_speke_20_audio.zig").PresetSpeke20Audio;
const PresetSpeke20Video = @import("preset_speke_20_video.zig").PresetSpeke20Video;

/// Use encryptionContractConfiguration to configure one or more content
/// encryption keys for your endpoints that use SPEKE 2.0.
/// The encryption contract defines which content keys are used to encrypt the
/// audio and video tracks in your stream.
/// To configure the encryption contract, specify which audio and video
/// encryption presets to use.
/// Note the following considerations when using
/// encryptionContractConfiguration:
/// encryptionContractConfiguration can be used for DASH endpoints that use
/// SPEKE 2.0. SPEKE 2.0 relies on the CPIX 2.3 specification.
/// You must disable key rotation for this endpoint by setting
/// keyRotationIntervalSeconds to 0.
pub const EncryptionContractConfiguration = struct {
    /// A collection of audio encryption presets.
    preset_speke_20_audio: PresetSpeke20Audio,

    /// A collection of video encryption presets.
    preset_speke_20_video: PresetSpeke20Video,

    pub const json_field_names = .{
        .preset_speke_20_audio = "PresetSpeke20Audio",
        .preset_speke_20_video = "PresetSpeke20Video",
    };
};
