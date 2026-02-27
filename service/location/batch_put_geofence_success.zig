/// Contains a summary of each geofence that was successfully stored in a given
/// geofence collection.
pub const BatchPutGeofenceSuccess = struct {
    /// The timestamp for when the geofence was stored in a geofence collection in
    /// [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The geofence successfully stored in a geofence collection.
    geofence_id: []const u8,

    /// The timestamp for when the geofence was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .geofence_id = "GeofenceId",
        .update_time = "UpdateTime",
    };
};
