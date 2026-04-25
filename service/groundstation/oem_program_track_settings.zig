/// Program track settings for OEMEphemeris.
pub const OemProgramTrackSettings = struct {
    /// Unique identifier of the OEM ephemeris.
    ephemeris_id: []const u8,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
    };
};
