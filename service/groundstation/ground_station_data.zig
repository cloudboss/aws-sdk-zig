/// Information about the ground station data.
pub const GroundStationData = struct {
    /// ID of a ground station.
    ground_station_id: ?[]const u8 = null,

    /// Name of a ground station.
    ground_station_name: ?[]const u8 = null,

    /// Ground station Region.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .ground_station_id = "groundStationId",
        .ground_station_name = "groundStationName",
        .region = "region",
    };
};
