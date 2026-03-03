const DolbyVisionCompatibility = @import("dolby_vision_compatibility.zig").DolbyVisionCompatibility;
const DolbyVisionLevel6Metadata = @import("dolby_vision_level_6_metadata.zig").DolbyVisionLevel6Metadata;
const DolbyVisionLevel6Mode = @import("dolby_vision_level_6_mode.zig").DolbyVisionLevel6Mode;
const DolbyVisionMapping = @import("dolby_vision_mapping.zig").DolbyVisionMapping;
const DolbyVisionProfile = @import("dolby_vision_profile.zig").DolbyVisionProfile;

/// Create Dolby Vision Profile 5 or Profile 8.1 compatible video output.
pub const DolbyVision = struct {
    /// When you set Compatibility mapping to Duplicate Stream, DolbyVision streams
    /// that have a backward compatible base layer (e.g., DolbyVision 8.1) will
    /// cause a duplicate stream to be signaled in the manifest as a duplicate
    /// stream. When you set Compatibility mapping to Supplemntal Codecs,
    /// DolbyVision streams that have a backward compatible base layer (e.g.,
    /// DolbyVision 8.1) will cause the associate stream in the manifest to include
    /// a SUPPLEMENTAL_CODECS property.
    compatibility: ?DolbyVisionCompatibility = null,

    /// Use these settings when you set DolbyVisionLevel6Mode to SPECIFY to override
    /// the MaxCLL and MaxFALL values in your input with new values.
    l6_metadata: ?DolbyVisionLevel6Metadata = null,

    /// Use Dolby Vision Mode to choose how the service will handle Dolby Vision
    /// MaxCLL and MaxFALL properies.
    l6_mode: ?DolbyVisionLevel6Mode = null,

    /// Required when you set Dolby Vision Profile to Profile 8.1. When you set
    /// Content mapping to None, content mapping is not applied to the
    /// HDR10-compatible signal. Depending on the source peak nit level, clipping
    /// might occur on HDR devices without Dolby Vision. When you set Content
    /// mapping to HDR10 1000, the transcoder creates a 1,000 nits peak
    /// HDR10-compatible signal by applying static content mapping to the source.
    /// This mode is speed-optimized for PQ10 sources with metadata that is created
    /// from analysis. For graded Dolby Vision content, be aware that creative
    /// intent might not be guaranteed with extreme 1,000 nits trims.
    mapping: ?DolbyVisionMapping = null,

    /// Required when you enable Dolby Vision. Use Profile 5 to include
    /// frame-interleaved Dolby Vision metadata in your output. Your input must
    /// include Dolby Vision metadata or an HDR10 YUV color space. Use Profile 8.1
    /// to include frame-interleaved Dolby Vision metadata and HDR10 metadata in
    /// your output. Your input must include Dolby Vision metadata.
    profile: ?DolbyVisionProfile = null,

    pub const json_field_names = .{
        .compatibility = "Compatibility",
        .l6_metadata = "L6Metadata",
        .l6_mode = "L6Mode",
        .mapping = "Mapping",
        .profile = "Profile",
    };
};
