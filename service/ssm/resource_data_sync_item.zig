const LastResourceDataSyncStatus = @import("last_resource_data_sync_status.zig").LastResourceDataSyncStatus;
const ResourceDataSyncS3Destination = @import("resource_data_sync_s_3_destination.zig").ResourceDataSyncS3Destination;
const ResourceDataSyncSourceWithState = @import("resource_data_sync_source_with_state.zig").ResourceDataSyncSourceWithState;

/// Information about a resource data sync configuration, including its current
/// status and last
/// successful sync.
pub const ResourceDataSyncItem = struct {
    /// The status reported by the last sync.
    last_status: ?LastResourceDataSyncStatus,

    /// The last time the sync operations returned a status of `SUCCESSFUL` (UTC).
    last_successful_sync_time: ?i64,

    /// The status message details reported by the last sync.
    last_sync_status_message: ?[]const u8,

    /// The last time the configuration attempted to sync (UTC).
    last_sync_time: ?i64,

    /// Configuration information for the target S3 bucket.
    s_3_destination: ?ResourceDataSyncS3Destination,

    /// The date and time the configuration was created (UTC).
    sync_created_time: ?i64,

    /// The date and time the resource data sync was changed.
    sync_last_modified_time: ?i64,

    /// The name of the resource data sync.
    sync_name: ?[]const u8,

    /// Information about the source where the data was synchronized.
    sync_source: ?ResourceDataSyncSourceWithState,

    /// The type of resource data sync. If `SyncType` is `SyncToDestination`,
    /// then the resource data sync synchronizes data to an S3 bucket. If the
    /// `SyncType` is
    /// `SyncFromSource` then the resource data sync synchronizes data from
    /// Organizations or from
    /// multiple Amazon Web Services Regions.
    sync_type: ?[]const u8,

    pub const json_field_names = .{
        .last_status = "LastStatus",
        .last_successful_sync_time = "LastSuccessfulSyncTime",
        .last_sync_status_message = "LastSyncStatusMessage",
        .last_sync_time = "LastSyncTime",
        .s_3_destination = "S3Destination",
        .sync_created_time = "SyncCreatedTime",
        .sync_last_modified_time = "SyncLastModifiedTime",
        .sync_name = "SyncName",
        .sync_source = "SyncSource",
        .sync_type = "SyncType",
    };
};
