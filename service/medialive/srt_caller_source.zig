const SrtCallerDecryption = @import("srt_caller_decryption.zig").SrtCallerDecryption;

/// The configuration for a source that uses SRT as the connection protocol. In
/// terms of establishing the connection, MediaLive is always caller and the
/// upstream system is always the listener. In terms of transmission of the
/// source content, MediaLive is always the receiver and the upstream system is
/// always the sender.
pub const SrtCallerSource = struct {
    decryption: ?SrtCallerDecryption = null,

    /// The preferred latency (in milliseconds) for implementing packet loss and
    /// recovery. Packet recovery is a key feature of SRT.
    minimum_latency: ?i32 = null,

    /// The IP address at the upstream system (the listener) that MediaLive (the
    /// caller) connects to.
    srt_listener_address: ?[]const u8 = null,

    /// The port at the upstream system (the listener) that MediaLive (the caller)
    /// connects to.
    srt_listener_port: ?[]const u8 = null,

    /// The stream ID, if the upstream system uses this identifier.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .minimum_latency = "MinimumLatency",
        .srt_listener_address = "SrtListenerAddress",
        .srt_listener_port = "SrtListenerPort",
        .stream_id = "StreamId",
    };
};
