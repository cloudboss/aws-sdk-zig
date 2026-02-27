const SlotResolutionTestResultItemCounts = @import("slot_resolution_test_result_item_counts.zig").SlotResolutionTestResultItemCounts;

/// Information about the success and failure rate of slot resolution
/// in the results of a test execution.
pub const SlotResolutionTestResultItem = struct {
    /// A result for slot resolution in the results of a test execution.
    result_counts: SlotResolutionTestResultItemCounts,

    /// The name of the slot.
    slot_name: []const u8,

    pub const json_field_names = .{
        .result_counts = "resultCounts",
        .slot_name = "slotName",
    };
};
