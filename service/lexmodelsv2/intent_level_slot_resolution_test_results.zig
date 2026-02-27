const IntentLevelSlotResolutionTestResultItem = @import("intent_level_slot_resolution_test_result_item.zig").IntentLevelSlotResolutionTestResultItem;

/// Indicates the success or failure of slots at the intent level.
pub const IntentLevelSlotResolutionTestResults = struct {
    /// Indicates the items for the slot level resolution for the intents.
    items: []const IntentLevelSlotResolutionTestResultItem,

    pub const json_field_names = .{
        .items = "items",
    };
};
