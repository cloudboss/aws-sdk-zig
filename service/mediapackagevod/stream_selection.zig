const StreamOrder = @import("stream_order.zig").StreamOrder;

/// A StreamSelection configuration.
pub const StreamSelection = struct {
    /// The maximum video bitrate (bps) to include in output.
    max_video_bits_per_second: ?i32 = null,

    /// The minimum video bitrate (bps) to include in output.
    min_video_bits_per_second: ?i32 = null,

    /// A directive that determines the order of streams in the output.
    stream_order: ?StreamOrder = null,

    pub const json_field_names = .{
        .max_video_bits_per_second = "MaxVideoBitsPerSecond",
        .min_video_bits_per_second = "MinVideoBitsPerSecond",
        .stream_order = "StreamOrder",
    };
};
