/// Contains information about discrepancy in a slot information between the
/// test set and the bot.
pub const TestSetSlotDiscrepancyItem = struct {
    /// The error message for a discrepancy for an intent between the test set and
    /// the bot.
    error_message: []const u8,

    /// The name of the intent associated with the slot in the discrepancy report.
    intent_name: []const u8,

    /// The name of the slot in the discrepancy report.
    slot_name: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .intent_name = "intentName",
        .slot_name = "slotName",
    };
};
