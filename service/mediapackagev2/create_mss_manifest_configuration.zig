const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const MssManifestLayout = @import("mss_manifest_layout.zig").MssManifestLayout;

/// Configuration parameters for creating a Microsoft Smooth Streaming (MSS)
/// manifest. MSS is a streaming media format developed by Microsoft that
/// delivers adaptive bitrate streaming content to compatible players and
/// devices.
pub const CreateMssManifestConfiguration = struct {
    filter_configuration: ?FilterConfiguration = null,

    /// Determines the layout format of the MSS manifest. This controls how the
    /// manifest is structured and presented to client players, affecting
    /// compatibility with different MSS-compatible devices and applications.
    manifest_layout: ?MssManifestLayout = null,

    /// A short string that's appended to the endpoint URL to create a unique path
    /// to this MSS manifest. The manifest name must be unique within the origin
    /// endpoint and can contain letters, numbers, hyphens, and underscores.
    manifest_name: []const u8,

    /// The total duration (in seconds) of the manifest window. This determines how
    /// much content is available in the manifest at any given time. The manifest
    /// window slides forward as new segments become available, maintaining a
    /// consistent duration of content. The minimum value is 30 seconds.
    manifest_window_seconds: ?i32 = null,

    pub const json_field_names = .{
        .filter_configuration = "FilterConfiguration",
        .manifest_layout = "ManifestLayout",
        .manifest_name = "ManifestName",
        .manifest_window_seconds = "ManifestWindowSeconds",
    };
};
