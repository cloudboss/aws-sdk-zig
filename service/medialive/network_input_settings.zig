const HlsInputSettings = @import("hls_input_settings.zig").HlsInputSettings;
const MulticastInputSettings = @import("multicast_input_settings.zig").MulticastInputSettings;
const NetworkInputServerValidation = @import("network_input_server_validation.zig").NetworkInputServerValidation;

/// Network source to transcode. Must be accessible to the Elemental Live node
/// that is running the live event through a network connection.
pub const NetworkInputSettings = struct {
    /// Specifies HLS input settings when the uri is for a HLS manifest.
    hls_input_settings: ?HlsInputSettings,

    /// Specifies multicast input settings when the uri is for a multicast event.
    multicast_input_settings: ?MulticastInputSettings,

    /// Check HTTPS server certificates. When set to checkCryptographyOnly,
    /// cryptography in the certificate will be checked, but not the server's name.
    /// Certain subdomains (notably S3 buckets that use dots in the bucket name) do
    /// not strictly match the corresponding certificate's wildcard pattern and
    /// would otherwise cause the event to error. This setting is ignored for
    /// protocols that do not use https.
    server_validation: ?NetworkInputServerValidation,

    pub const json_field_names = .{
        .hls_input_settings = "HlsInputSettings",
        .multicast_input_settings = "MulticastInputSettings",
        .server_validation = "ServerValidation",
    };
};
