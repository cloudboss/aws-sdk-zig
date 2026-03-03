const SyncMetadataStatus = @import("sync_metadata_status.zig").SyncMetadataStatus;
const HypervisorState = @import("hypervisor_state.zig").HypervisorState;

/// These are the details of the specified hypervisor. A hypervisor is hardware,
/// software, or firmware that creates and manages virtual machines, and
/// allocates
/// resources to them.
pub const HypervisorDetails = struct {
    /// The server host of the hypervisor. This can be either an IP address or
    /// a fully-qualified domain name (FQDN).
    host: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the hypervisor.
    hypervisor_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS
    /// used to encrypt the hypervisor.
    kms_key_arn: ?[]const u8 = null,

    /// This is the time when the most recent successful sync
    /// of metadata occurred.
    last_successful_metadata_sync_time: ?i64 = null,

    /// This is the most recent status for the indicated metadata sync.
    latest_metadata_sync_status: ?SyncMetadataStatus = null,

    /// This is the most recent status for the indicated metadata sync.
    latest_metadata_sync_status_message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the group of gateways within
    /// the requested log.
    log_group_arn: ?[]const u8 = null,

    /// This is the name of the specified hypervisor.
    name: ?[]const u8 = null,

    /// This is the current state of the specified hypervisor.
    ///
    /// The possible states are `PENDING`, `ONLINE`,
    /// `OFFLINE`, or `ERROR`.
    state: ?HypervisorState = null,

    pub const json_field_names = .{
        .host = "Host",
        .hypervisor_arn = "HypervisorArn",
        .kms_key_arn = "KmsKeyArn",
        .last_successful_metadata_sync_time = "LastSuccessfulMetadataSyncTime",
        .latest_metadata_sync_status = "LatestMetadataSyncStatus",
        .latest_metadata_sync_status_message = "LatestMetadataSyncStatusMessage",
        .log_group_arn = "LogGroupArn",
        .name = "Name",
        .state = "State",
    };
};
