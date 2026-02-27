const aws = @import("aws");

const GeofenceGeometry = @import("geofence_geometry.zig").GeofenceGeometry;

/// Contains a list of geofences stored in a given geofence collection.
///
/// The returned geometry will always match the geometry format used when the
/// geofence was created.
pub const ListGeofenceResponseEntry = struct {
    /// The timestamp for when the geofence was stored in a geofence collection in
    /// [ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The geofence identifier.
    geofence_id: []const u8,

    /// User defined properties of the geofence. A property is a key-value pair
    /// stored with the geofence and added to any geofence event triggered with that
    /// geofence.
    ///
    /// Format: `"key" : "value"`
    geofence_properties: ?[]const aws.map.StringMapEntry,

    /// Contains the geofence geometry details describing the position of the
    /// geofence. Can be a circle, a polygon, or a multipolygon.
    geometry: GeofenceGeometry,

    /// Identifies the state of the geofence. A geofence will hold one of the
    /// following states:
    ///
    /// * `ACTIVE` — The geofence has been indexed by the system.
    /// * `PENDING` — The geofence is being processed by the system.
    /// * `FAILED` — The geofence failed to be indexed by the system.
    /// * `DELETED` — The geofence has been deleted from the system index.
    /// * `DELETING` — The geofence is being deleted from the system index.
    status: []const u8,

    /// The timestamp for when the geofence was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .geofence_id = "GeofenceId",
        .geofence_properties = "GeofenceProperties",
        .geometry = "Geometry",
        .status = "Status",
        .update_time = "UpdateTime",
    };
};
