const EphemerisType = @import("ephemeris_type.zig").EphemerisType;

/// Ephemeris data for a contact.
pub const EphemerisResponseData = struct {
    /// Unique identifier of the ephemeris. Appears only for custom ephemerides.
    ephemeris_id: ?[]const u8,

    /// Type of ephemeris.
    ephemeris_type: EphemerisType,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
        .ephemeris_type = "ephemerisType",
    };
};
