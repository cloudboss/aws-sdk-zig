const SrtListenerDecryption = @import("srt_listener_decryption.zig").SrtListenerDecryption;

/// Settings for SRT Listener input.
pub const SrtListenerSettings = struct {
    decryption: ?SrtListenerDecryption = null,

    /// The preferred latency (in milliseconds) for implementing packet loss and
    /// recovery. Range 120-15000.
    minimum_latency: ?i32 = null,

    /// The stream ID, if the upstream system uses this identifier.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .minimum_latency = "MinimumLatency",
        .stream_id = "StreamId",
    };
};
