const ManifestLayout = @import("manifest_layout.zig").ManifestLayout;
const Profile = @import("profile.zig").Profile;
const ScteMarkersSource = @import("scte_markers_source.zig").ScteMarkersSource;
const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// A DASH manifest configuration.
pub const DashManifest = struct {
    /// Determines the position of some tags in the Media Presentation Description
    /// (MPD). When set to FULL, elements like SegmentTemplate and ContentProtection
    /// are included in each Representation. When set to COMPACT, duplicate elements
    /// are combined and presented at the AdaptationSet level.
    manifest_layout: ?ManifestLayout = null,

    /// An optional string to include in the name of the manifest.
    manifest_name: ?[]const u8 = null,

    /// Minimum duration (in seconds) that a player will buffer media before
    /// starting the presentation.
    min_buffer_time_seconds: ?i32 = null,

    /// The Dynamic Adaptive Streaming over HTTP (DASH) profile type. When set to
    /// "HBBTV_1_5", HbbTV 1.5 compliant output is enabled.
    profile: ?Profile = null,

    /// The source of scte markers used. When set to SEGMENTS, the scte markers are
    /// sourced from the segments of the ingested content. When set to MANIFEST, the
    /// scte markers are sourced from the manifest of the ingested content.
    scte_markers_source: ?ScteMarkersSource = null,

    stream_selection: ?StreamSelection = null,

    pub const json_field_names = .{
        .manifest_layout = "ManifestLayout",
        .manifest_name = "ManifestName",
        .min_buffer_time_seconds = "MinBufferTimeSeconds",
        .profile = "Profile",
        .scte_markers_source = "ScteMarkersSource",
        .stream_selection = "StreamSelection",
    };
};
