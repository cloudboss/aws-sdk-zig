const DolbyVisionPresence = @import("dolby_vision_presence.zig").DolbyVisionPresence;

/// Dolby Vision characteristics of the video track: the profile and level, and
/// whether the RPU (dynamic metadata), base layer, and enhancement layer are
/// present. Use this to distinguish Dolby Vision content from standard HEVC and
/// to choose your encoding or passthrough settings. Omitted when the content is
/// not Dolby Vision.
pub const DolbyVisionMetadata = struct {
    /// Whether a Dolby Vision component is present in the track.
    base_layer: ?DolbyVisionPresence = null,

    /// Whether a Dolby Vision component is present in the track.
    enhancement_layer: ?DolbyVisionPresence = null,

    /// The Dolby Vision level, which indicates the maximum resolution and frame
    /// rate.
    level: ?i32 = null,

    /// The Dolby Vision profile, for example 5, 7, or 8. The profile determines the
    /// layer structure and playback compatibility of the content.
    profile: ?i32 = null,

    /// Whether a Dolby Vision component is present in the track.
    rpu: ?DolbyVisionPresence = null,

    pub const json_field_names = .{
        .base_layer = "BaseLayer",
        .enhancement_layer = "EnhancementLayer",
        .level = "Level",
        .profile = "Profile",
        .rpu = "Rpu",
    };
};
