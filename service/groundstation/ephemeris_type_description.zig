const EphemerisDescription = @import("ephemeris_description.zig").EphemerisDescription;

pub const EphemerisTypeDescription = union(enum) {
    az_el: ?EphemerisDescription,
    oem: ?EphemerisDescription,
    tle: ?EphemerisDescription,

    pub const json_field_names = .{
        .az_el = "azEl",
        .oem = "oem",
        .tle = "tle",
    };
};
