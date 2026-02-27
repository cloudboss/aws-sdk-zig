const ConversationLevelTestResultItem = @import("conversation_level_test_result_item.zig").ConversationLevelTestResultItem;

/// The test set results data at the conversation level.
pub const ConversationLevelTestResults = struct {
    /// The item list in the test set results data at the conversation level.
    items: []const ConversationLevelTestResultItem,

    pub const json_field_names = .{
        .items = "items",
    };
};
