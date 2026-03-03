const DashPlaylistSettings = @import("dash_playlist_settings.zig").DashPlaylistSettings;
const HlsPlaylistSettings = @import("hls_playlist_settings.zig").HlsPlaylistSettings;

/// The output item response.
pub const ResponseOutputItem = struct {
    /// DASH manifest configuration settings.
    dash_playlist_settings: ?DashPlaylistSettings = null,

    /// HLS manifest configuration settings.
    hls_playlist_settings: ?HlsPlaylistSettings = null,

    /// The name of the manifest for the channel that will appear in the channel
    /// output's playback URL.
    manifest_name: []const u8,

    /// The URL used for playback by content players.
    playback_url: []const u8,

    /// A string used to associate a package configuration source group with a
    /// channel output.
    source_group: []const u8,

    pub const json_field_names = .{
        .dash_playlist_settings = "DashPlaylistSettings",
        .hls_playlist_settings = "HlsPlaylistSettings",
        .manifest_name = "ManifestName",
        .playback_url = "PlaybackUrl",
        .source_group = "SourceGroup",
    };
};
