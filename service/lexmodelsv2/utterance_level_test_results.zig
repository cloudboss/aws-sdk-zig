const UtteranceLevelTestResultItem = @import("utterance_level_test_result_item.zig").UtteranceLevelTestResultItem;

/// Contains information about the utterances in the results of the test set
/// execution.
pub const UtteranceLevelTestResults = struct {
    /// Contains information about an utterance in the results of the test set
    /// execution.
    items: []const UtteranceLevelTestResultItem,

    pub const json_field_names = .{
        .items = "items",
    };
};
