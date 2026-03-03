const StatisticalIssueStatus = @import("statistical_issue_status.zig").StatisticalIssueStatus;

/// Entity that comprises information on categorical values in data.
pub const CategoricalValues = struct {
    /// Indicates the number of categories in the data.
    number_of_category: ?i32 = null,

    /// Indicates whether there is a potential data issue related to categorical
    /// values.
    status: StatisticalIssueStatus,

    pub const json_field_names = .{
        .number_of_category = "NumberOfCategory",
        .status = "Status",
    };
};
