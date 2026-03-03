const aws = @import("aws");

const GeofenceGeometry = @import("geofence_geometry.zig").GeofenceGeometry;

/// Contains geofence geometry details.
pub const BatchPutGeofenceRequestEntry = struct {
    /// The identifier for the geofence to be stored in a given geofence collection.
    geofence_id: []const u8,

    /// Associates one of more properties with the geofence. A property is a
    /// key-value pair stored with the geofence and added to any geofence event
    /// triggered with that geofence.
    ///
    /// Format: `"key" : "value"`
    geofence_properties: ?[]const aws.map.StringMapEntry = null,

    /// Contains the details to specify the position of the geofence. Can be a
    /// circle, a polygon, or a multipolygon. `Polygon` and `MultiPolygon`
    /// geometries can be defined using their respective parameters, or encoded in
    /// Geobuf format using the `Geobuf` parameter. Including multiple geometry
    /// types in the same request will return a validation error.
    ///
    /// The geofence `Polygon` and `MultiPolygon` formats support a maximum of 1,000
    /// total vertices. The `Geobuf` format supports a maximum of 100,000 vertices.
    geometry: GeofenceGeometry,

    pub const json_field_names = .{
        .geofence_id = "GeofenceId",
        .geofence_properties = "GeofenceProperties",
        .geometry = "Geometry",
    };
};
