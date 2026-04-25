/// Program track settings for TLEEphemeris.
pub const TleProgramTrackSettings = struct {
    /// Unique identifier of the TLE ephemeris.
    ephemeris_id: []const u8,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};
