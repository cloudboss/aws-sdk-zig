const EphemerisMetaData = @import("ephemeris_meta_data.zig").EphemerisMetaData;

/// Item in a list of satellites.
pub const SatelliteListItem = struct {
    /// The current ephemeris being used to compute the trajectory of the satellite.
    current_ephemeris: ?EphemerisMetaData = null,

    /// A list of ground stations to which the satellite is on-boarded.
    ground_stations: ?[]const []const u8 = null,

    /// NORAD satellite ID number.
    norad_satellite_id: i32 = 0,

    /// ARN of a satellite.
    satellite_arn: ?[]const u8 = null,

    /// UUID of a satellite.
    satellite_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_ephemeris = "currentEphemeris",
        .ground_stations = "groundStations",
        .norad_satellite_id = "noradSatelliteID",
        .satellite_arn = "satelliteArn",
        .satellite_id = "satelliteId",
    };
};
