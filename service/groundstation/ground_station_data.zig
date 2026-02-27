/// Information about the ground station data.
pub const GroundStationData = struct {
    /// UUID of a ground station.
    ground_station_id: ?[]const u8,

    /// Name of a ground station.
    ground_station_name: ?[]const u8,

    /// Ground station Region.
    region: ?[]const u8,

    pub const json_field_names = .{
        .ground_station_id = "groundStationId",
        .ground_station_name = "groundStationName",
        .region = "region",
    };
};
