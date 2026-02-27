const LastSyncStatus = @import("last_sync_status.zig").LastSyncStatus;

/// Provides details about the product's connection sync and contains the
/// following sub-fields.
///
/// * `LastSyncTime`
///
/// * `LastSyncStatus`
///
/// * `LastSyncStatusMessage`
///
/// * `LastSuccessfulSyncTime`
///
/// * `LastSuccessfulSyncProvisioningArtifactID`
pub const LastSync = struct {
    /// The ProvisioningArtifactID of the ProvisioningArtifact created from the
    /// latest successful sync.
    last_successful_sync_provisioning_artifact_id: ?[]const u8,

    /// The time of the latest successful sync from the source repo artifact to the
    /// Service Catalog product.
    last_successful_sync_time: ?i64,

    /// The current status of the sync. Responses include `SUCCEEDED` or `FAILED`.
    last_sync_status: ?LastSyncStatus,

    /// The sync's status message.
    last_sync_status_message: ?[]const u8,

    /// The time of the last attempted sync from the repository to the Service
    /// Catalog product.
    last_sync_time: ?i64,

    pub const json_field_names = .{
        .last_successful_sync_provisioning_artifact_id = "LastSuccessfulSyncProvisioningArtifactId",
        .last_successful_sync_time = "LastSuccessfulSyncTime",
        .last_sync_status = "LastSyncStatus",
        .last_sync_status_message = "LastSyncStatusMessage",
        .last_sync_time = "LastSyncTime",
    };
};
