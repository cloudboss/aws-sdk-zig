const std = @import("std");

pub const PlaceType = enum {
    country,
    region,
    sub_region,
    locality,
    district,
    sub_district,
    postal_code,
    block,
    sub_block,
    intersection,
    street,
    point_of_interest,
    point_address,
    interpolated_address,
    secondary_address,
    inferred_secondary_address,

    pub const json_field_names = .{
        .country = "Country",
        .region = "Region",
        .sub_region = "SubRegion",
        .locality = "Locality",
        .district = "District",
        .sub_district = "SubDistrict",
        .postal_code = "PostalCode",
        .block = "Block",
        .sub_block = "SubBlock",
        .intersection = "Intersection",
        .street = "Street",
        .point_of_interest = "PointOfInterest",
        .point_address = "PointAddress",
        .interpolated_address = "InterpolatedAddress",
        .secondary_address = "SecondaryAddress",
        .inferred_secondary_address = "InferredSecondaryAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .country => "Country",
            .region => "Region",
            .sub_region => "SubRegion",
            .locality => "Locality",
            .district => "District",
            .sub_district => "SubDistrict",
            .postal_code => "PostalCode",
            .block => "Block",
            .sub_block => "SubBlock",
            .intersection => "Intersection",
            .street => "Street",
            .point_of_interest => "PointOfInterest",
            .point_address => "PointAddress",
            .interpolated_address => "InterpolatedAddress",
            .secondary_address => "SecondaryAddress",
            .inferred_secondary_address => "InferredSecondaryAddress",
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
