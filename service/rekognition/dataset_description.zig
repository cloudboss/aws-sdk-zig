const DatasetStats = @import("dataset_stats.zig").DatasetStats;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;
const DatasetStatusMessageCode = @import("dataset_status_message_code.zig").DatasetStatusMessageCode;

/// A description for a dataset. For more information, see DescribeDataset.
///
/// The status fields `Status`, `StatusMessage`, and `StatusMessageCode`
/// reflect the last operation on the dataset.
pub const DatasetDescription = struct {
    /// The Unix timestamp for the time and date that the dataset was created.
    creation_timestamp: ?i64,

    /// The status message code for the dataset.
    dataset_stats: ?DatasetStats,

    /// The Unix timestamp for the date and time that the dataset was last updated.
    last_updated_timestamp: ?i64,

    /// The status of the dataset.
    status: ?DatasetStatus,

    /// The status message for the dataset.
    status_message: ?[]const u8,

    /// The status message code for the dataset operation. If a service error
    /// occurs, try the
    /// API call again later. If a client error occurs, check the input parameters
    /// to the dataset
    /// API call that failed.
    status_message_code: ?DatasetStatusMessageCode,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .dataset_stats = "DatasetStats",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .status = "Status",
        .status_message = "StatusMessage",
        .status_message_code = "StatusMessageCode",
    };
};
