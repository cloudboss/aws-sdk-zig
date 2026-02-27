const GroupResult = @import("group_result.zig").GroupResult;

/// Show each group result.
pub const TestResult = struct {
    /// Show each group of test results.
    groups: ?[]const GroupResult,

    pub const json_field_names = .{
        .groups = "groups",
    };
};
