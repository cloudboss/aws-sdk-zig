const std = @import("std");

pub const AliasAttributeType = enum {
    phone_number,
    email,
    preferred_username,

    pub const json_field_names = .{
        .phone_number = "phone_number",
        .email = "email",
        .preferred_username = "preferred_username",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .phone_number => "phone_number",
            .email => "email",
            .preferred_username => "preferred_username",
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
