const IntentClassificationTestResultItem = @import("intent_classification_test_result_item.zig").IntentClassificationTestResultItem;

/// Information for the results of the intent classification test.
pub const IntentClassificationTestResults = struct {
    /// A list of the results for the intent classification test.
    items: []const IntentClassificationTestResultItem,

    pub const json_field_names = .{
        .items = "items",
    };
};
