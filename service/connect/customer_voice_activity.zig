/// Information about customer’s voice activity.
pub const CustomerVoiceActivity = struct {
    /// Timestamp that measures the end of the customer greeting from an outbound
    /// voice call.
    greeting_end_timestamp: ?i64,

    /// Timestamp that measures the beginning of the customer greeting from an
    /// outbound voice call.
    greeting_start_timestamp: ?i64,

    pub const json_field_names = .{
        .greeting_end_timestamp = "GreetingEndTimestamp",
        .greeting_start_timestamp = "GreetingStartTimestamp",
    };
};
