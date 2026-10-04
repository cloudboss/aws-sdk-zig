const RdsUngracefulBehavior = @import("rds_ungraceful_behavior.zig").RdsUngracefulBehavior;

/// The ungraceful execution settings for an Amazon RDS switchover read replica
/// execution block.
pub const RdsUngraceful = struct {
    /// The ungraceful behavior to perform if switching to ungraceful execution.
    ungraceful: ?RdsUngracefulBehavior = null,

    pub const json_field_names = .{
        .ungraceful = "ungraceful",
    };
};
