const DatastorePartitions = @import("datastore_partitions.zig").DatastorePartitions;
const FileFormatConfiguration = @import("file_format_configuration.zig").FileFormatConfiguration;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;
const DatastoreStorage = @import("datastore_storage.zig").DatastoreStorage;

/// Information about a data store.
pub const Datastore = struct {
    /// The ARN of the data store.
    arn: ?[]const u8 = null,

    /// When the data store was created.
    creation_time: ?i64 = null,

    /// Contains information about the partition dimensions in a data store.
    datastore_partitions: ?DatastorePartitions = null,

    /// Contains the configuration information of file formats. IoT Analytics data
    /// stores support JSON and [Parquet](https://parquet.apache.org/).
    ///
    /// The default file format is JSON. You can specify only one format.
    ///
    /// You can't change the file format after you create the data store.
    file_format_configuration: ?FileFormatConfiguration = null,

    /// The last time when a new message arrived in the data store.
    ///
    /// IoT Analytics updates this value at most once per minute for Amazon Simple
    /// Storage Service one data store. Hence, the `lastMessageArrivalTime` value is
    /// an approximation.
    ///
    /// This feature only applies to messages that arrived in the data store after
    /// October 23, 2020.
    last_message_arrival_time: ?i64 = null,

    /// The last time the data store was updated.
    last_update_time: ?i64 = null,

    /// The name of the data store.
    name: ?[]const u8 = null,

    /// How long, in days, message data is kept for the data store. When
    /// `customerManagedS3` storage is selected, this parameter is ignored.
    retention_period: ?RetentionPeriod = null,

    /// The status of a data store:
    ///
    /// **CREATING**
    ///
    /// The data store is being created.
    ///
    /// **ACTIVE**
    ///
    /// The data store has been created and can be used.
    ///
    /// **DELETING**
    ///
    /// The data store is being deleted.
    status: ?DatastoreStatus = null,

    /// Where data in a data store is stored.. You can choose `serviceManagedS3`
    /// storage, `customerManagedS3` storage, or `iotSiteWiseMultiLayerStorage`
    /// storage. The default is `serviceManagedS3`. You can't change the choice of
    /// Amazon S3 storage after your data store is created.
    storage: ?DatastoreStorage = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .datastore_partitions = "datastorePartitions",
        .file_format_configuration = "fileFormatConfiguration",
        .last_message_arrival_time = "lastMessageArrivalTime",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .retention_period = "retentionPeriod",
        .status = "status",
        .storage = "storage",
    };
};
