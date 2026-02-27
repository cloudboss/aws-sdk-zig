const NodeSignalValue = @import("node_signal_value.zig").NodeSignalValue;

/// A signal to a camera node to start or stop processing video.
pub const NodeSignal = struct {
    /// The camera node's name, from the application manifest.
    node_instance_id: []const u8,

    /// The signal value.
    signal: NodeSignalValue,

    pub const json_field_names = .{
        .node_instance_id = "NodeInstanceId",
        .signal = "Signal",
    };
};
