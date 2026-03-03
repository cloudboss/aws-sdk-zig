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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
