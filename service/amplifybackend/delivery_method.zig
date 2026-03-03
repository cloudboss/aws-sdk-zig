const std = @import("std");

/// The type of verification message to send.
pub const DeliveryMethod = enum {
    email,
    sms,

    pub const json_field_names = .{
        .email = "EMAIL",
        .sms = "SMS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email => "EMAIL",
            .sms => "SMS",
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
