pub const ForecastedGeofenceEventType = enum {
    /// This event type signifies that a device is forecasted to enter the geofence
    enter,
    /// This event type signifies that a device is forecasted to exit the geofence
    exit,
    /// This event type signifies that a device is stationary in the geofence and an
    /// exit/enter cannot be forecasted
    idle,

    pub const json_field_names = .{
        .enter = "ENTER",
        .exit = "EXIT",
        .idle = "IDLE",
    };
};
