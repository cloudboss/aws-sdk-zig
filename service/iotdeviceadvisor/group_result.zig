const TestCaseRun = @import("test_case_run.zig").TestCaseRun;

/// Show Group Result.
pub const GroupResult = struct {
    /// Group result ID.
    group_id: ?[]const u8,

    /// Group Result Name.
    group_name: ?[]const u8,

    /// Tests under Group Result.
    tests: ?[]const TestCaseRun,

    pub const json_field_names = .{
        .group_id = "groupId",
        .group_name = "groupName",
        .tests = "tests",
    };
};
