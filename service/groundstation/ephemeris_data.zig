const AzElEphemeris = @import("az_el_ephemeris.zig").AzElEphemeris;
const OEMEphemeris = @import("oem_ephemeris.zig").OEMEphemeris;
const TLEEphemeris = @import("tle_ephemeris.zig").TLEEphemeris;

/// Ephemeris data.
pub const EphemerisData = union(enum) {
    az_el: ?AzElEphemeris,
    oem: ?OEMEphemeris,
    tle: ?TLEEphemeris,

    pub const json_field_names = .{
        .az_el = "azEl",
        .oem = "oem",
        .tle = "tle",
    };
};
