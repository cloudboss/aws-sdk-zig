const std = @import("std");

pub const RegistrationAssociationFilterName = enum {
    resource_type,
    iso_country_code,

    pub const json_field_names = .{
        .resource_type = "resource-type",
        .iso_country_code = "iso-country-code",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "resource-type",
            .iso_country_code => "iso-country-code",
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
