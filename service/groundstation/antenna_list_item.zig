/// An antenna at a ground station.
pub const AntennaListItem = struct {
    /// Name of the antenna.
    antenna_name: []const u8,

    /// Name of the ground station the antenna is associated with.
    ground_station_name: []const u8,

    /// Region of the antenna.
    region: []const u8,

    pub const json_field_names = .{
        .antenna_name = "antennaName",
        .ground_station_name = "groundStationName",
        .region = "region",
    };
};
