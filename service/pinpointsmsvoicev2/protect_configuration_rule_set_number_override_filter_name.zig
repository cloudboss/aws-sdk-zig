const std = @import("std");

pub const ProtectConfigurationRuleSetNumberOverrideFilterName = enum {
    iso_country_code,
    destination_phone_number_begins_with,
    action,
    expires_before,
    expires_after,
    created_before,
    created_after,

    pub const json_field_names = .{
        .iso_country_code = "iso-country-code",
        .destination_phone_number_begins_with = "destination-phone-number-begins-with",
        .action = "action",
        .expires_before = "expires-before",
        .expires_after = "expires-after",
        .created_before = "created-before",
        .created_after = "created-after",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iso_country_code => "iso-country-code",
            .destination_phone_number_begins_with => "destination-phone-number-begins-with",
            .action => "action",
            .expires_before => "expires-before",
            .expires_after => "expires-after",
            .created_before => "created-before",
            .created_after => "created-after",
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
