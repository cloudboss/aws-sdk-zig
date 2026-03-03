const AuthTokenUpdateStatus = @import("auth_token_update_status.zig").AuthTokenUpdateStatus;
const PendingAutomaticFailoverStatus = @import("pending_automatic_failover_status.zig").PendingAutomaticFailoverStatus;
const ClusterMode = @import("cluster_mode.zig").ClusterMode;
const PendingLogDeliveryConfiguration = @import("pending_log_delivery_configuration.zig").PendingLogDeliveryConfiguration;
const ReshardingStatus = @import("resharding_status.zig").ReshardingStatus;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;
const UserGroupsUpdateStatus = @import("user_groups_update_status.zig").UserGroupsUpdateStatus;

/// The settings to be applied to the Valkey or Redis OSS replication group,
/// either immediately or
/// during the next maintenance window.
pub const ReplicationGroupPendingModifiedValues = struct {
    /// The auth token status
    auth_token_status: ?AuthTokenUpdateStatus = null,

    /// Indicates the status of automatic failover for this Valkey or Redis OSS
    /// replication group.
    automatic_failover_status: ?PendingAutomaticFailoverStatus = null,

    /// Enabled or Disabled. To modify cluster mode from Disabled to Enabled, you
    /// must first
    /// set the cluster mode to Compatible. Compatible mode allows your Valkey or
    /// Redis OSS clients to connect
    /// using both cluster mode enabled and cluster mode disabled. After you migrate
    /// all Valkey or Redis OSS
    /// clients to use cluster mode enabled, you can then complete cluster mode
    /// configuration
    /// and set the cluster mode to Enabled.
    cluster_mode: ?ClusterMode = null,

    /// The log delivery configurations being modified
    log_delivery_configurations: ?[]const PendingLogDeliveryConfiguration = null,

    /// The primary cluster ID that is applied immediately (if
    /// `--apply-immediately` was specified), or during the next maintenance
    /// window.
    primary_cluster_id: ?[]const u8 = null,

    /// The status of an online resharding operation.
    resharding: ?ReshardingStatus = null,

    /// A flag that enables in-transit encryption when set to true.
    transit_encryption_enabled: ?bool = null,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    transit_encryption_mode: ?TransitEncryptionMode = null,

    /// The user group being modified.
    user_groups: ?UserGroupsUpdateStatus = null,
};
