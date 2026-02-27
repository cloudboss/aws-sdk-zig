const MessageBasedTriggerInput = @import("message_based_trigger_input.zig").MessageBasedTriggerInput;
const TimeBasedTriggerInput = @import("time_based_trigger_input.zig").TimeBasedTriggerInput;
const TokenBasedTriggerInput = @import("token_based_trigger_input.zig").TokenBasedTriggerInput;

/// Condition that triggers memory processing.
pub const TriggerConditionInput = union(enum) {
    /// Message based trigger configuration.
    message_based_trigger: ?MessageBasedTriggerInput,
    /// Time based trigger configuration.
    time_based_trigger: ?TimeBasedTriggerInput,
    /// Token based trigger configuration.
    token_based_trigger: ?TokenBasedTriggerInput,

    pub const json_field_names = .{
        .message_based_trigger = "messageBasedTrigger",
        .time_based_trigger = "timeBasedTrigger",
        .token_based_trigger = "tokenBasedTrigger",
    };
};
