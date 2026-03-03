const TestCaseRun = @import("test_case_run.zig").TestCaseRun;

/// Show Group Result.
pub const GroupResult = struct {
    /// Group result ID.
    group_id: ?[]const u8 = null,

    /// Group Result Name.
    group_name: ?[]const u8 = null,

    /// Tests under Group Result.
    tests: ?[]const TestCaseRun = null,

    pub const json_field_names = .{
        .group_id = "groupId",
        .group_name = "groupName",
        .tests = "tests",
    };
};
