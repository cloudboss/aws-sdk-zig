const TlsEncryption = @import("tls_encryption.zig").TlsEncryption;

/// The configuration settings for a router output that pushes a stream to a
/// destination using the RTMP (Real-Time Messaging Protocol) protocol, or RTMPS
/// (RTMP over TLS) when TLS encryption is specified. These settings include the
/// destination address and port, the application and stream names, and optional
/// TLS encryption configuration.
pub const RtmpPushRouterOutputConfiguration = struct {
    /// The name of the RTMP application on the destination server. Together with
    /// the stream name, the application name forms the RTMP URL path, in the
    /// pattern `rtmp://destinationAddress/applicationName/streamName`.
    application_name: []const u8,

    /// The IP address or hostname of the destination RTMP server that the router
    /// output pushes the stream to. Provide only the server address; specify the
    /// application and stream names separately.
    destination_address: []const u8,

    /// The TCP port on the destination RTMP server. For RTMP, valid values range
    /// from `1024` to `65535`. For RTMPS (RTMP over TLS), valid values are `443` or
    /// `1024` to `65535`. RTMP typically uses port `1935`, and RTMPS typically uses
    /// port `443`.
    destination_port: i32,

    /// The name of the RTMP stream that the output publishes to the destination
    /// application. The stream name forms the final segment of the RTMP URL path.
    stream_name: []const u8,

    /// The TLS encryption settings for the output. When you specify these settings,
    /// the output uses RTMPS (RTMP over TLS) to establish a secure, encrypted
    /// connection to the destination server.
    tls_encryption: ?TlsEncryption = null,

    pub const json_field_names = .{
        .application_name = "ApplicationName",
        .destination_address = "DestinationAddress",
        .destination_port = "DestinationPort",
        .stream_name = "StreamName",
        .tls_encryption = "TlsEncryption",
    };
};
