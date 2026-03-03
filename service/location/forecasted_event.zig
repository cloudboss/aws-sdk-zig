const aws = @import("aws");

const ForecastedGeofenceEventType = @import("forecasted_geofence_event_type.zig").ForecastedGeofenceEventType;

/// A forecasted event represents a geofence event in relation to the requested
/// device state, that may occur given the provided device state and time
/// horizon.
pub const ForecastedEvent = struct {
    /// The forecasted event identifier.
    event_id: []const u8,

    /// The event type, forecasting three states for which a device can be in
    /// relative to a geofence:
    ///
    /// `ENTER`: If a device is outside of a geofence, but would breach the fence if
    /// the device is moving at its current speed within time horizon window.
    ///
    /// `EXIT`: If a device is inside of a geofence, but would breach the fence if
    /// the device is moving at its current speed within time horizon window.
    ///
    /// `IDLE`: If a device is inside of a geofence, and the device is not moving.
    event_type: ForecastedGeofenceEventType,

    /// The forecasted time the device will breach the geofence in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    forecasted_breach_time: ?i64 = null,

    /// The geofence identifier pertaining to the forecasted event.
    geofence_id: []const u8,

    /// The geofence properties.
    geofence_properties: ?[]const aws.map.StringMapEntry = null,

    /// Indicates if the device is located within the geofence.
    is_device_in_geofence: bool,

    /// The closest distance from the device's position to the geofence.
    nearest_distance: f64 = 0,

    pub const json_field_names = .{
        .event_id = "EventId",
        .event_type = "EventType",
        .forecasted_breach_time = "ForecastedBreachTime",
        .geofence_id = "GeofenceId",
        .geofence_properties = "GeofenceProperties",
        .is_device_in_geofence = "IsDeviceInGeofence",
        .nearest_distance = "NearestDistance",
    };
};
