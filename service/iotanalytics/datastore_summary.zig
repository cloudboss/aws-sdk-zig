const DatastorePartitions = @import("datastore_partitions.zig").DatastorePartitions;
const DatastoreStorageSummary = @import("datastore_storage_summary.zig").DatastoreStorageSummary;
const FileFormatType = @import("file_format_type.zig").FileFormatType;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

/// A summary of information about a data store.
pub const DatastoreSummary = struct {
    /// When the data store was created.
    creation_time: ?i64,

    /// The name of the data store.
    datastore_name: ?[]const u8,

    /// Contains information about the partition dimensions in a data store.
    datastore_partitions: ?DatastorePartitions,

    /// Where data in a data store is stored.
    datastore_storage: ?DatastoreStorageSummary,

    /// The file format of the data in the data store.
    file_format_type: ?FileFormatType,

    /// The last time when a new message arrived in the data store.
    ///
    /// IoT Analytics updates this value at most once per minute for Amazon Simple
    /// Storage Service one data store. Hence, the `lastMessageArrivalTime` value is
    /// an approximation.
    ///
    /// This feature only applies to messages that arrived in the data store after
    /// October 23, 2020.
    last_message_arrival_time: ?i64,

    /// The last time the data store was updated.
    last_update_time: ?i64,

    /// The status of the data store.
    status: ?DatastoreStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .datastore_name = "datastoreName",
        .datastore_partitions = "datastorePartitions",
        .datastore_storage = "datastoreStorage",
        .file_format_type = "fileFormatType",
        .last_message_arrival_time = "lastMessageArrivalTime",
        .last_update_time = "lastUpdateTime",
        .status = "status",
    };
};
