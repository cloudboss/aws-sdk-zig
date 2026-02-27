/// Program track settings for AzElEphemeris.
pub const AzElProgramTrackSettings = struct {
    /// Unique identifier of the azimuth elevation ephemeris.
    ephemeris_id: []const u8,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};
