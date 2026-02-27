const aws = @import("aws");

const FilesLimit = @import("files_limit.zig").FilesLimit;
const FilterExpression = @import("filter_expression.zig").FilterExpression;
const DatasetParameter = @import("dataset_parameter.zig").DatasetParameter;

/// Represents a set of options that define how DataBrew selects files for a
/// given Amazon S3
/// path in a dataset.
pub const PathOptions = struct {
    /// If provided, this structure imposes a limit on a number of files that should
    /// be selected.
    files_limit: ?FilesLimit,

    /// If provided, this structure defines a date range for matching Amazon S3
    /// objects based on their
    /// LastModifiedDate attribute in Amazon S3.
    last_modified_date_condition: ?FilterExpression,

    /// A structure that maps names of parameters used in the Amazon S3 path of a
    /// dataset to their definitions.
    parameters: ?[]const aws.map.MapEntry(DatasetParameter),

    pub const json_field_names = .{
        .files_limit = "FilesLimit",
        .last_modified_date_condition = "LastModifiedDateCondition",
        .parameters = "Parameters",
    };
};
