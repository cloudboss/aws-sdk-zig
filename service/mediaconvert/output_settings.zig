const HlsSettings = @import("hls_settings.zig").HlsSettings;

/// Specific settings for this type of output.
pub const OutputSettings = struct {
    /// Settings for HLS output groups
    hls_settings: ?HlsSettings = null,

    pub const json_field_names = .{
        .hls_settings = "HlsSettings",
    };
};
