const aws = @import("aws");

const TestCaseEntryPoint = @import("test_case_entry_point.zig").TestCaseEntryPoint;
const TestCaseStatus = @import("test_case_status.zig").TestCaseStatus;

/// Contains information about a test case.
pub const TestCase = struct {
    /// The Amazon Resource Name (ARN) of the test case.
    arn: ?[]const u8 = null,

    /// The JSON string that represents the content of the test.
    content: ?[]const u8 = null,

    /// The description of the test case.
    description: ?[]const u8 = null,

    /// Defines the starting point for the test, including channel type and
    /// parameters.
    entry_point: ?TestCaseEntryPoint = null,

    /// The identifier of the test case.
    id: ?[]const u8 = null,

    /// Defines the test attributes for precise data representation. The value must
    /// be a valid JSON string.
    initialization_data: ?[]const u8 = null,

    /// The region in which the test case was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The time at which the test case was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the test case.
    name: ?[]const u8 = null,

    /// Indicates the test status as either SAVED or PUBLISHED.
    status: ?TestCaseStatus = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The SHA256 hash of the test case content.
    test_case_sha_256: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .content = "Content",
        .description = "Description",
        .entry_point = "EntryPoint",
        .id = "Id",
        .initialization_data = "InitializationData",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .test_case_sha_256 = "TestCaseSha256",
    };
};
