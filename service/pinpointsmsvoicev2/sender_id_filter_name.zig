const std = @import("std");

pub const SenderIdFilterName = enum {
    sender_id,
    iso_country_code,
    message_type,
    deletion_protection_enabled,
    registered,

    pub const json_field_names = .{
        .sender_id = "sender-id",
        .iso_country_code = "iso-country-code",
        .message_type = "message-type",
        .deletion_protection_enabled = "deletion-protection-enabled",
        .registered = "registered",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sender_id => "sender-id",
            .iso_country_code => "iso-country-code",
            .message_type => "message-type",
            .deletion_protection_enabled => "deletion-protection-enabled",
            .registered => "registered",
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
