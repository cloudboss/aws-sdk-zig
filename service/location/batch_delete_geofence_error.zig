const BatchItemError = @import("batch_item_error.zig").BatchItemError;

/// Contains error details for each geofence that failed to delete from the
/// geofence collection.
pub const BatchDeleteGeofenceError = struct {
    /// Contains details associated to the batch error.
    @"error": BatchItemError,

    /// The geofence associated with the error message.
    geofence_id: []const u8,

    pub const json_field_names = .{
        .@"error" = "Error",
        .geofence_id = "GeofenceId",
    };
};
