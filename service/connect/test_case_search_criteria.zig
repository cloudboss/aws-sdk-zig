const TestCaseStatus = @import("test_case_status.zig").TestCaseStatus;
const StringCondition = @import("string_condition.zig").StringCondition;

/// The search criteria to be used to return test cases.
pub const TestCaseSearchCriteria = struct {
    /// A list of conditions which would be applied together with an AND condition.
    and_conditions: ?[]const TestCaseSearchCriteria = null,

    /// A list of conditions which would be applied together with an OR condition.
    or_conditions: ?[]const TestCaseSearchCriteria = null,

    /// The status of the test case.
    status_condition: ?TestCaseStatus = null,

    /// A leaf node condition which can be used to specify a string condition.
    string_condition: ?StringCondition = null,

    pub const json_field_names = .{
        .and_conditions = "AndConditions",
        .or_conditions = "OrConditions",
        .status_condition = "StatusCondition",
        .string_condition = "StringCondition",
    };
};
