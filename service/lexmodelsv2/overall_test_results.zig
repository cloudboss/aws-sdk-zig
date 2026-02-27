const OverallTestResultItem = @import("overall_test_result_item.zig").OverallTestResultItem;

/// Information about the overall test results.
pub const OverallTestResults = struct {
    /// A list of the overall test results.
    items: []const OverallTestResultItem,

    pub const json_field_names = .{
        .items = "items",
    };
};
