const std = @import("std");

pub const AutocompleteFilterPlaceType = enum {
    locality,
    postal_code,
    street,
    intersection,
    point_address,
    interpolated_address,
    country,
    region,

    pub const json_field_names = .{
        .locality = "Locality",
        .postal_code = "PostalCode",
        .street = "Street",
        .intersection = "Intersection",
        .point_address = "PointAddress",
        .interpolated_address = "InterpolatedAddress",
        .country = "Country",
        .region = "Region",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .locality => "Locality",
            .postal_code => "PostalCode",
            .street => "Street",
            .intersection => "Intersection",
            .point_address => "PointAddress",
            .interpolated_address => "InterpolatedAddress",
            .country => "Country",
            .region => "Region",
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
