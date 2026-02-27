/// A date range for filtering machine learning products by their last modified
/// date.
pub const MachineLearningProductLastModifiedDateFilterDateRange = struct {
    /// The start date (inclusive) of the date range. The operation returns machine
    /// learning products with last modified dates on or after this date.
    after_value: ?[]const u8,

    /// The end date (inclusive) of the date range. The operation returns machine
    /// learning products with last modified dates on or before this date.
    before_value: ?[]const u8,

    pub const json_field_names = .{
        .after_value = "AfterValue",
        .before_value = "BeforeValue",
    };
};
