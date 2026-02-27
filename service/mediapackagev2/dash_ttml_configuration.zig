const DashTtmlProfile = @import("dash_ttml_profile.zig").DashTtmlProfile;

/// The settings for TTML subtitles.
pub const DashTtmlConfiguration = struct {
    /// The profile that MediaPackage uses when signaling subtitles in the manifest.
    /// `IMSC` is the default profile. `EBU-TT-D` produces subtitles that are
    /// compliant with the EBU-TT-D TTML profile. MediaPackage passes through
    /// subtitle styles to the manifest. For more information about EBU-TT-D
    /// subtitles, see [EBU-TT-D Subtitling Distribution
    /// Format](https://tech.ebu.ch/publications/tech3380).
    ttml_profile: DashTtmlProfile,

    pub const json_field_names = .{
        .ttml_profile = "TtmlProfile",
    };
};
