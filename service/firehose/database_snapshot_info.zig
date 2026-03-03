const FailureDescription = @import("failure_description.zig").FailureDescription;
const SnapshotRequestedBy = @import("snapshot_requested_by.zig").SnapshotRequestedBy;
const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

/// The structure that describes the snapshot information of a table in source
/// database endpoint that Firehose reads.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const DatabaseSnapshotInfo = struct {
    failure_description: ?FailureDescription = null,

    /// The identifier of the current snapshot of the table in source database
    /// endpoint.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    id: []const u8,

    /// The principal that sent the request to take the current snapshot on the
    /// table.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    requested_by: SnapshotRequestedBy,

    /// The timestamp when the current snapshot is taken on the table.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    request_timestamp: i64,

    /// The status of the current snapshot of the table.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    status: SnapshotStatus,

    /// The fully qualified name of the table in source database endpoint that
    /// Firehose reads.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    table: []const u8,

    pub const json_field_names = .{
        .failure_description = "FailureDescription",
        .id = "Id",
        .requested_by = "RequestedBy",
        .request_timestamp = "RequestTimestamp",
        .status = "Status",
        .table = "Table",
    };
};
