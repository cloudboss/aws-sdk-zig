const GlobalAuroraUngracefulBehavior = @import("global_aurora_ungraceful_behavior.zig").GlobalAuroraUngracefulBehavior;

/// Configuration for handling failures when performing operations on Aurora
/// global databases.
pub const GlobalAuroraUngraceful = struct {
    /// The settings for ungraceful execution.
    ungraceful: ?GlobalAuroraUngracefulBehavior = null,

    pub const json_field_names = .{
        .ungraceful = "ungraceful",
    };
};
