/// The configuration for HLS content.
pub const HlsConfiguration = struct {
    /// The URL that is used to initiate a playback session for devices that support
    /// Apple HLS. The session uses server-side reporting.
    manifest_endpoint_prefix: ?[]const u8,

    pub const json_field_names = .{
        .manifest_endpoint_prefix = "ManifestEndpointPrefix",
    };
};
