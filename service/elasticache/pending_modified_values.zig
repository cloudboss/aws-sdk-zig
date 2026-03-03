const AuthTokenUpdateStatus = @import("auth_token_update_status.zig").AuthTokenUpdateStatus;
const PendingLogDeliveryConfiguration = @import("pending_log_delivery_configuration.zig").PendingLogDeliveryConfiguration;
const ScaleConfig = @import("scale_config.zig").ScaleConfig;
const TransitEncryptionMode = @import("transit_encryption_mode.zig").TransitEncryptionMode;

/// A group of settings that are applied to the cluster in the future, or that
/// are
/// currently being applied.
pub const PendingModifiedValues = struct {
    /// The auth token status
    auth_token_status: ?AuthTokenUpdateStatus = null,

    /// A list of cache node IDs that are being removed (or will be removed) from
    /// the cluster.
    /// A node ID is a 4-digit numeric identifier (0001, 0002, etc.).
    cache_node_ids_to_remove: ?[]const []const u8 = null,

    /// The cache node type that this cluster or replication group is scaled to.
    cache_node_type: ?[]const u8 = null,

    /// The new cache engine version that the cluster runs.
    engine_version: ?[]const u8 = null,

    /// The log delivery configurations being modified
    log_delivery_configurations: ?[]const PendingLogDeliveryConfiguration = null,

    /// The new number of cache nodes for the cluster.
    ///
    /// For clusters running Valkey or Redis OSS, this value must be 1. For clusters
    /// running Memcached, this
    /// value must be between 1 and 40.
    num_cache_nodes: ?i32 = null,

    /// The scaling configuration changes that are pending for the Memcached
    /// cluster.
    scale_config: ?ScaleConfig = null,

    /// A flag that enables in-transit encryption when set to true.
    transit_encryption_enabled: ?bool = null,

    /// A setting that allows you to migrate your clients to use in-transit
    /// encryption, with
    /// no downtime.
    transit_encryption_mode: ?TransitEncryptionMode = null,
};
