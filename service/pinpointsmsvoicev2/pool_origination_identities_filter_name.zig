const std = @import("std");

pub const PoolOriginationIdentitiesFilterName = enum {
    iso_country_code,
    number_capability,

    pub const json_field_names = .{
        .iso_country_code = "iso-country-code",
        .number_capability = "number-capability",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iso_country_code => "iso-country-code",
            .number_capability => "number-capability",
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
