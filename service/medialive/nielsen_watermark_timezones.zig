const std = @import("std");

/// Nielsen Watermark Timezones
pub const NielsenWatermarkTimezones = enum {
    america_puerto_rico,
    us_alaska,
    us_arizona,
    us_central,
    us_eastern,
    us_hawaii,
    us_mountain,
    us_pacific,
    us_samoa,
    utc,

    pub const json_field_names = .{
        .america_puerto_rico = "AMERICA_PUERTO_RICO",
        .us_alaska = "US_ALASKA",
        .us_arizona = "US_ARIZONA",
        .us_central = "US_CENTRAL",
        .us_eastern = "US_EASTERN",
        .us_hawaii = "US_HAWAII",
        .us_mountain = "US_MOUNTAIN",
        .us_pacific = "US_PACIFIC",
        .us_samoa = "US_SAMOA",
        .utc = "UTC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .america_puerto_rico => "AMERICA_PUERTO_RICO",
            .us_alaska => "US_ALASKA",
            .us_arizona => "US_ARIZONA",
            .us_central => "US_CENTRAL",
            .us_eastern => "US_EASTERN",
            .us_hawaii => "US_HAWAII",
            .us_mountain => "US_MOUNTAIN",
            .us_pacific => "US_PACIFIC",
            .us_samoa => "US_SAMOA",
            .utc => "UTC",
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
