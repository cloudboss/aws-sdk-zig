const std = @import("std");

pub const ReverseGeocodeFilterPlaceType = enum {
    locality,
    intersection,
    street,
    point_address,
    interpolated_address,
    secondary_address,
    point_of_interest,

    pub const json_field_names = .{
        .locality = "Locality",
        .intersection = "Intersection",
        .street = "Street",
        .point_address = "PointAddress",
        .interpolated_address = "InterpolatedAddress",
        .secondary_address = "SecondaryAddress",
        .point_of_interest = "PointOfInterest",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .locality => "Locality",
            .intersection => "Intersection",
            .street => "Street",
            .point_address => "PointAddress",
            .interpolated_address => "InterpolatedAddress",
            .secondary_address => "SecondaryAddress",
            .point_of_interest => "PointOfInterest",
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
