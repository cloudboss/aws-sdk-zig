const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tle => "TLE",
            .oem => "OEM",
            .az_el => "AZ_EL",
            .service_managed => "SERVICE_MANAGED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
