const HarnessStopReason = @import("harness_stop_reason.zig").HarnessStopReason;

/// Event indicating the end of a message.
pub const HarnessMessageStopEvent = struct {
    /// The reason the agent stopped generating.
    stop_reason: HarnessStopReason,

    pub const json_field_names = .{
        .stop_reason = "stopReason",
    };
};
