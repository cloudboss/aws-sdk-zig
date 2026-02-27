const MessageBasedTrigger = @import("message_based_trigger.zig").MessageBasedTrigger;
const TimeBasedTrigger = @import("time_based_trigger.zig").TimeBasedTrigger;
const TokenBasedTrigger = @import("token_based_trigger.zig").TokenBasedTrigger;

/// Condition that triggers memory processing.
pub const TriggerCondition = union(enum) {
    /// Message based trigger configuration.
    message_based_trigger: ?MessageBasedTrigger,
    /// Time based trigger configuration.
    time_based_trigger: ?TimeBasedTrigger,
    /// Token based trigger configuration.
    token_based_trigger: ?TokenBasedTrigger,

    pub const json_field_names = .{
        .message_based_trigger = "messageBasedTrigger",
        .time_based_trigger = "timeBasedTrigger",
        .token_based_trigger = "tokenBasedTrigger",
    };
};
