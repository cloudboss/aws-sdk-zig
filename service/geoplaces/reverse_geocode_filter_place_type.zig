const std = @import("std");

pub const ReverseGeocodeFilterPlaceType = enum {
    locality,
    intersection,
    street,
    point_address,
    interpolated_address,

    pub const json_field_names = .{
        .locality = "Locality",
        .intersection = "Intersection",
        .street = "Street",
        .point_address = "PointAddress",
        .interpolated_address = "InterpolatedAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .locality => "Locality",
            .intersection => "Intersection",
            .street => "Street",
            .point_address => "PointAddress",
            .interpolated_address => "InterpolatedAddress",
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
