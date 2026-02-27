const BatchItemError = @import("batch_item_error.zig").BatchItemError;

/// Contains error details for each device that failed to evaluate its position
/// against the geofences in a given geofence collection.
pub const BatchEvaluateGeofencesError = struct {
    /// The device associated with the position evaluation error.
    device_id: []const u8,

    /// Contains details associated to the batch error.
    @"error": BatchItemError,

    /// Specifies a timestamp for when the error occurred in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    sample_time: i64,

    pub const json_field_names = .{
        .device_id = "DeviceId",
        .@"error" = "Error",
        .sample_time = "SampleTime",
    };
};
