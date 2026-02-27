const DashPlaylistSettings = @import("dash_playlist_settings.zig").DashPlaylistSettings;
const HlsPlaylistSettings = @import("hls_playlist_settings.zig").HlsPlaylistSettings;

/// The output configuration for this channel.
pub const RequestOutputItem = struct {
    /// DASH manifest configuration parameters.
    dash_playlist_settings: ?DashPlaylistSettings,

    /// HLS playlist configuration parameters.
    hls_playlist_settings: ?HlsPlaylistSettings,

    /// The name of the manifest for the channel. The name appears in the
    /// `PlaybackUrl`.
    manifest_name: []const u8,

    /// A string used to match which `HttpPackageConfiguration` is used for each
    /// `VodSource`.
    source_group: []const u8,

    pub const json_field_names = .{
        .dash_playlist_settings = "DashPlaylistSettings",
        .hls_playlist_settings = "HlsPlaylistSettings",
        .manifest_name = "ManifestName",
        .source_group = "SourceGroup",
    };
};
