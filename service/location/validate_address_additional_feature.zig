const std = @import("std");

pub const ValidateAddressAdditionalFeature = enum {
    position,
    country_specific_attributes,

    pub const json_field_names = .{
        .position = "Position",
        .country_specific_attributes = "CountrySpecificAttributes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .position => "Position",
            .country_specific_attributes => "CountrySpecificAttributes",
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
