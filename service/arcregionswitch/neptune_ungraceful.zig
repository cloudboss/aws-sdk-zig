const NeptuneUngracefulBehavior = @import("neptune_ungraceful_behavior.zig").NeptuneUngracefulBehavior;

/// Configuration for handling failures when performing operations on Neptune
/// global databases.
pub const NeptuneUngraceful = struct {
    /// The settings for ungraceful execution.
    ungraceful: ?NeptuneUngracefulBehavior = null,

    pub const json_field_names = .{
        .ungraceful = "ungraceful",
    };
};
