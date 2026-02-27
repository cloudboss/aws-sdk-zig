const EphemerisSource = @import("ephemeris_source.zig").EphemerisSource;

/// Metadata describing a particular ephemeris.
pub const EphemerisMetaData = struct {
    /// UUID of a customer-provided ephemeris.
    ///
    /// This field is not populated for default ephemerides from Space Track.
    ephemeris_id: ?[]const u8,

    /// The epoch of a default, ephemeris from Space Track in UTC.
    ///
    /// This field is not populated for customer-provided ephemerides.
    epoch: ?i64,

    /// A name string associated with the ephemeris. Used as a human-readable
    /// identifier for the ephemeris.
    ///
    /// A name is only returned for customer-provider ephemerides that have a name
    /// associated.
    name: ?[]const u8,

    /// The `EphemerisSource` that generated a given ephemeris.
    source: EphemerisSource,

    pub const json_field_names = .{
        .ephemeris_id = "ephemerisId",
        .epoch = "epoch",
        .name = "name",
        .source = "source",
    };
};
