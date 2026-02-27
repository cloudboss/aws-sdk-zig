/// Contains information about the test set that is exported.
pub const TestSetExportSpecification = struct {
    /// The unique identifier of the test set.
    test_set_id: []const u8,

    pub const json_field_names = .{
        .test_set_id = "testSetId",
    };
};
