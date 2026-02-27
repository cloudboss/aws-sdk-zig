const DocumentDbUngracefulBehavior = @import("document_db_ungraceful_behavior.zig").DocumentDbUngracefulBehavior;

/// Configuration for handling failures when performing operations on DocumentDB
/// global clusters.
pub const DocumentDbUngraceful = struct {
    /// The settings for ungraceful execution.
    ungraceful: ?DocumentDbUngracefulBehavior,

    pub const json_field_names = .{
        .ungraceful = "ungraceful",
    };
};
