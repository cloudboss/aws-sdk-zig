const MxfAfdSignaling = @import("mxf_afd_signaling.zig").MxfAfdSignaling;
const MxfProfile = @import("mxf_profile.zig").MxfProfile;
const MxfUncompressedAudioWrapping = @import("mxf_uncompressed_audio_wrapping.zig").MxfUncompressedAudioWrapping;
const MxfXavcProfileSettings = @import("mxf_xavc_profile_settings.zig").MxfXavcProfileSettings;

/// These settings relate to your MXF output container.
pub const MxfSettings = struct {
    /// Optional. When you have AFD signaling set up in your output video stream,
    /// use this setting to choose whether to also include it in the MXF wrapper.
    /// Choose Don't copy to exclude AFD signaling from the MXF wrapper. Choose Copy
    /// from video stream to copy the AFD values from the video stream for this
    /// output to the MXF wrapper. Regardless of which option you choose, the AFD
    /// values remain in the video stream. Related settings: To set up your output
    /// to include or exclude AFD values, see AfdSignaling, under VideoDescription.
    /// On the console, find AFD signaling under the output's video encoding
    /// settings.
    afd_signaling: ?MxfAfdSignaling = null,

    /// Specify the MXF profile, also called shim, for this output. To automatically
    /// select a profile according to your output video codec and resolution, leave
    /// blank. For a list of codecs supported with each MXF profile, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/codecs-supported-with-each-mxf-profile.html. For more information about the automatic selection behavior, see https://docs.aws.amazon.com/mediaconvert/latest/ug/default-automatic-selection-of-mxf-profiles.html.
    profile: ?MxfProfile = null,

    /// Choose the audio frame wrapping mode for PCM tracks in MXF outputs. AUTO
    /// (default): Uses codec-appropriate defaults - BWF for H.264/AVC, AES3 for
    /// MPEG2/XDCAM. AES3: Use AES3 frame wrapping with SMPTE-compliant descriptors.
    /// This setting only takes effect when the MXF profile is OP1a.
    uncompressed_audio_wrapping: ?MxfUncompressedAudioWrapping = null,

    /// Specify the XAVC profile settings for MXF outputs when you set your MXF
    /// profile to XAVC.
    xavc_profile_settings: ?MxfXavcProfileSettings = null,

    pub const json_field_names = .{
        .afd_signaling = "AfdSignaling",
        .profile = "Profile",
        .uncompressed_audio_wrapping = "UncompressedAudioWrapping",
        .xavc_profile_settings = "XavcProfileSettings",
    };
};
