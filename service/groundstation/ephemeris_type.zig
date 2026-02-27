pub const EphemerisType = enum {
    tle,
    oem,
    az_el,
    service_managed,

    pub const json_field_names = .{
        .tle = "TLE",
        .oem = "OEM",
        .az_el = "AZ_EL",
        .service_managed = "SERVICE_MANAGED",
    };
};
