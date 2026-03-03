const FilterConfiguration = @import("filter_configuration.zig").FilterConfiguration;
const MssManifestLayout = @import("mss_manifest_layout.zig").MssManifestLayout;

/// Configuration details for a Microsoft Smooth Streaming (MSS) manifest
/// associated with an origin endpoint. This includes all the settings and
/// properties that define how the MSS content is packaged and delivered.
pub const GetMssManifestConfiguration = struct {
    filter_configuration: ?FilterConfiguration = null,

    /// The layout format of the MSS manifest, which determines how the manifest is
    /// structured for client compatibility.
    manifest_layout: ?MssManifestLayout = null,

    /// The name of the MSS manifest. This name is appended to the origin endpoint
    /// URL to create the unique path for accessing this specific MSS manifest.
    manifest_name: []const u8,

    /// The duration (in seconds) of the manifest window. This represents the total
    /// amount of content available in the manifest at any given time.
    manifest_window_seconds: ?i32 = null,

    /// The complete URL for accessing the MSS manifest. Client players use this URL
    /// to retrieve the manifest and begin streaming the Microsoft Smooth Streaming
    /// content.
    url: []const u8,

    pub const json_field_names = .{
        .filter_configuration = "FilterConfiguration",
        .manifest_layout = "ManifestLayout",
        .manifest_name = "ManifestName",
        .manifest_window_seconds = "ManifestWindowSeconds",
        .url = "Url",
    };
};
