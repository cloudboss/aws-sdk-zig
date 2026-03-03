const SrtCallerDecryptionRequest = @import("srt_caller_decryption_request.zig").SrtCallerDecryptionRequest;

/// Configures the connection for a source that uses SRT as the connection
/// protocol. In terms of establishing the connection, MediaLive is always the
/// caller and the upstream system is always the listener. In terms of
/// transmission of the source content, MediaLive is always the receiver and the
/// upstream system is always the sender.
pub const SrtCallerSourceRequest = struct {
    decryption: ?SrtCallerDecryptionRequest = null,

    /// The preferred latency (in milliseconds) for implementing packet loss and
    /// recovery. Packet recovery is a key feature of SRT. Obtain this value from
    /// the operator at the upstream system.
    minimum_latency: ?i32 = null,

    /// The IP address at the upstream system (the listener) that MediaLive (the
    /// caller) will connect to.
    srt_listener_address: ?[]const u8 = null,

    /// The port at the upstream system (the listener) that MediaLive (the caller)
    /// will connect to.
    srt_listener_port: ?[]const u8 = null,

    /// This value is required if the upstream system uses this identifier because
    /// without it, the SRT handshake between MediaLive (the caller) and the
    /// upstream system (the listener) might fail.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .minimum_latency = "MinimumLatency",
        .srt_listener_address = "SrtListenerAddress",
        .srt_listener_port = "SrtListenerPort",
        .stream_id = "StreamId",
    };
};
