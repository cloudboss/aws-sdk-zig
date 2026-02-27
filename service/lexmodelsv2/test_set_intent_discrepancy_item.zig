/// Contains information about discrepancy in an intent information between the
/// test set and the
/// bot.
pub const TestSetIntentDiscrepancyItem = struct {
    /// The error message for a discrepancy for an intent between the test set and
    /// the bot.
    error_message: []const u8,

    /// The name of the intent in the discrepancy report.
    intent_name: []const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .intent_name = "intentName",
    };
};
