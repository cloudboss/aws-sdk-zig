const DataViewDestinationTypeParams = @import("data_view_destination_type_params.zig").DataViewDestinationTypeParams;
const DataViewErrorInfo = @import("data_view_error_info.zig").DataViewErrorInfo;
const DataViewStatus = @import("data_view_status.zig").DataViewStatus;

/// Structure for the summary of a Dataview.
pub const DataViewSummary = struct {
    /// Time range to use for the Dataview. The value is determined as epoch time in
    /// milliseconds. For example, the value for Monday, November 1, 2021 12:00:00
    /// PM UTC is specified as 1635768000000.
    as_of_timestamp: ?i64,

    /// The flag to indicate Dataview should be updated automatically.
    auto_update: bool = false,

    /// The timestamp at which the Dataview was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    create_time: i64 = 0,

    /// Th unique identifier for the Dataview Dataset.
    dataset_id: ?[]const u8,

    /// The ARN identifier of the Dataview.
    data_view_arn: ?[]const u8,

    /// The unique identifier for the Dataview.
    data_view_id: ?[]const u8,

    /// Information about the Dataview destination.
    destination_type_properties: ?DataViewDestinationTypeParams,

    /// The structure with error messages.
    error_info: ?DataViewErrorInfo,

    /// The last time that a Dataview was modified. The value is determined as epoch
    /// time in milliseconds. For example, the value for Monday, November 1, 2021
    /// 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_time: i64 = 0,

    /// Ordered set of column names used to partition data.
    partition_columns: ?[]const []const u8,

    /// Columns to be used for sorting the data.
    sort_columns: ?[]const []const u8,

    /// The status of a Dataview creation.
    ///
    /// * `RUNNING` – Dataview creation is running.
    ///
    /// * `STARTING` – Dataview creation is starting.
    ///
    /// * `FAILED` – Dataview creation has failed.
    ///
    /// * `CANCELLED` – Dataview creation has been cancelled.
    ///
    /// * `TIMEOUT` – Dataview creation has timed out.
    ///
    /// * `SUCCESS` – Dataview creation has succeeded.
    ///
    /// * `PENDING` – Dataview creation is pending.
    ///
    /// * `FAILED_CLEANUP_FAILED` – Dataview creation failed and resource cleanup
    ///   failed.
    status: ?DataViewStatus,

    pub const json_field_names = .{
        .as_of_timestamp = "asOfTimestamp",
        .auto_update = "autoUpdate",
        .create_time = "createTime",
        .dataset_id = "datasetId",
        .data_view_arn = "dataViewArn",
        .data_view_id = "dataViewId",
        .destination_type_properties = "destinationTypeProperties",
        .error_info = "errorInfo",
        .last_modified_time = "lastModifiedTime",
        .partition_columns = "partitionColumns",
        .sort_columns = "sortColumns",
        .status = "status",
    };
};
