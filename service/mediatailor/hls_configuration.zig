/// The configuration for HLS content.
pub const HlsConfiguration = struct {
    /// The dual-stack (IPv4 and IPv6) URL that MediaTailor generates to initiate a
    /// playback session for devices that support Apple HLS. The session uses
    /// server-side reporting.
    dual_stack_manifest_endpoint_prefix: ?[]const u8 = null,

    /// The URL that MediaTailor generates to initiate a playback session for
    /// devices that support Apple HLS. The session uses server-side reporting.
    manifest_endpoint_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .dual_stack_manifest_endpoint_prefix = "DualStackManifestEndpointPrefix",
        .manifest_endpoint_prefix = "ManifestEndpointPrefix",
    };
};
