const DeltaTime = @import("delta_time.zig").DeltaTime;

/// Information that is used to filter message data, to segregate it according
/// to the
/// timeframe in which it arrives.
pub const QueryFilter = struct {
    /// Used to limit data to that which has arrived since the last execution of the
    /// action.
    delta_time: ?DeltaTime,

    pub const json_field_names = .{
        .delta_time = "deltaTime",
    };
};
