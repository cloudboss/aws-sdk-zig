const TumblingWindow = @import("tumbling_window.zig").TumblingWindow;

/// Contains a time interval window used for data aggregate computations (for
/// example,
/// average, sum, count, and so on).
pub const MetricWindow = struct {
    /// The tumbling time interval window.
    tumbling: ?TumblingWindow,

    pub const json_field_names = .{
        .tumbling = "tumbling",
    };
};
