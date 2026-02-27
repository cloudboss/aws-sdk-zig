/// Filter for selecting contacts that use a specific AzElEphemeris.
pub const AzElEphemerisFilter = struct {
    /// Unique identifier of the azimuth elevation ephemeris.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};
