const DataLakeUpdateException = @import("data_lake_update_exception.zig").DataLakeUpdateException;
const DataLakeStatus = @import("data_lake_status.zig").DataLakeStatus;

/// The status of the last `UpdateDataLake` or `DeleteDataLake` API
/// request. This is set to Completed after the configuration is updated, or
/// removed if
/// deletion of the data lake is successful.
pub const DataLakeUpdateStatus = struct {
    /// The details of the last `UpdateDataLake`or `DeleteDataLake` API
    /// request which failed.
    exception: ?DataLakeUpdateException = null,

    /// The unique ID for the last `UpdateDataLake` or `DeleteDataLake` API
    /// request.
    request_id: ?[]const u8 = null,

    /// The status of the last `UpdateDataLake` or `DeleteDataLake` API
    /// request that was requested.
    status: ?DataLakeStatus = null,

    pub const json_field_names = .{
        .exception = "exception",
        .request_id = "requestId",
        .status = "status",
    };
};
