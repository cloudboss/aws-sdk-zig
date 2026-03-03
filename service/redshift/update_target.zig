const SupportedOperation = @import("supported_operation.zig").SupportedOperation;

/// A maintenance track that you can switch the current track to.
pub const UpdateTarget = struct {
    /// The cluster version for the new maintenance track.
    database_version: ?[]const u8 = null,

    /// The name of the new maintenance track.
    maintenance_track_name: ?[]const u8 = null,

    /// A list of operations supported by the maintenance track.
    supported_operations: ?[]const SupportedOperation = null,
};
