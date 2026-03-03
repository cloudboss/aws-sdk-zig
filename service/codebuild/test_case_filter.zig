/// A filter used to return specific types of test cases. In order to pass the
/// filter, the
/// report must meet all of the filter properties.
pub const TestCaseFilter = struct {
    /// A keyword that is used to filter on the `name` or the `prefix`
    /// of the test cases. Only test cases where the keyword is a substring of the
    /// `name` or the `prefix` will be returned.
    keyword: ?[]const u8 = null,

    /// The status used to filter test cases. A `TestCaseFilter` can have one
    /// status. Valid values are:
    ///
    /// * `SUCCEEDED`
    ///
    /// * `FAILED`
    ///
    /// * `ERROR`
    ///
    /// * `SKIPPED`
    ///
    /// * `UNKNOWN`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .keyword = "keyword",
        .status = "status",
    };
};
