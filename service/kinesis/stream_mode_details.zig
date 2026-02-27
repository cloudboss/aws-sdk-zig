const StreamMode = @import("stream_mode.zig").StreamMode;

/// Specifies the capacity mode to which you want to set your data stream.
/// Currently, in
/// Kinesis Data Streams, you can choose between an **on-demand** capacity mode
/// and a **provisioned** capacity mode for your data streams.
pub const StreamModeDetails = struct {
    /// Specifies the capacity mode to which you want to set your data stream.
    /// Currently, in
    /// Kinesis Data Streams, you can choose between an **on-demand** capacity mode
    /// and a **provisioned** capacity mode for your data streams.
    stream_mode: StreamMode,

    pub const json_field_names = .{
        .stream_mode = "StreamMode",
    };
};
