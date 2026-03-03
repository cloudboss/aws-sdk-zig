const std = @import("std");

pub const RegistrationTypeFilterName = enum {
    supported_association_resource_type,
    supported_association_iso_country_code,

    pub const json_field_names = .{
        .supported_association_resource_type = "supported-association-resource-type",
        .supported_association_iso_country_code = "supported-association-iso-country-code",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .supported_association_resource_type => "supported-association-resource-type",
            .supported_association_iso_country_code => "supported-association-iso-country-code",
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
