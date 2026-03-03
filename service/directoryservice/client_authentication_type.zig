const std = @import("std");

pub const ClientAuthenticationType = enum {
    smart_card,
    smart_card_or_password,

    pub const json_field_names = .{
        .smart_card = "SmartCard",
        .smart_card_or_password = "SmartCardOrPassword",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .smart_card => "SmartCard",
            .smart_card_or_password => "SmartCardOrPassword",
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
