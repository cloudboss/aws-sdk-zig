const GlobalAuroraUngracefulBehavior = @import("global_aurora_ungraceful_behavior.zig").GlobalAuroraUngracefulBehavior;

/// Configuration for an Aurora global database execution block in ungraceful
/// mode.
pub const GlobalAuroraUngraceful = struct {
    /// The ungraceful behavior. The only valid value is `failover`, which calls
    /// `FailoverGlobalCluster` with `AllowDataLoss` set to `true` and might cause
    /// data loss.
    ungraceful: ?GlobalAuroraUngracefulBehavior = null,

    pub const json_field_names = .{
        .ungraceful = "ungraceful",
    };
};
