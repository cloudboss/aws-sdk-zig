const TestSetIntentDiscrepancyItem = @import("test_set_intent_discrepancy_item.zig").TestSetIntentDiscrepancyItem;
const TestSetSlotDiscrepancyItem = @import("test_set_slot_discrepancy_item.zig").TestSetSlotDiscrepancyItem;

/// Contains details about the errors in the test set discrepancy report
pub const TestSetDiscrepancyErrors = struct {
    /// Contains information about discrepancies found for intents between the test
    /// set and the bot.
    intent_discrepancies: []const TestSetIntentDiscrepancyItem,

    /// Contains information about discrepancies found for slots between the test
    /// set and the bot.
    slot_discrepancies: []const TestSetSlotDiscrepancyItem,

    pub const json_field_names = .{
        .intent_discrepancies = "intentDiscrepancies",
        .slot_discrepancies = "slotDiscrepancies",
    };
};
