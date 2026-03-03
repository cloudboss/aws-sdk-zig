const std = @import("std");

pub const GeoSpatialDataRole = enum {
    country,
    state,
    county,
    city,
    postcode,
    longitude,
    latitude,

    pub const json_field_names = .{
        .country = "COUNTRY",
        .state = "STATE",
        .county = "COUNTY",
        .city = "CITY",
        .postcode = "POSTCODE",
        .longitude = "LONGITUDE",
        .latitude = "LATITUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .country => "COUNTRY",
            .state => "STATE",
            .county => "COUNTY",
            .city => "CITY",
            .postcode => "POSTCODE",
            .longitude => "LONGITUDE",
            .latitude => "LATITUDE",
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
