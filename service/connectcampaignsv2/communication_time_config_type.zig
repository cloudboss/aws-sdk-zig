const std = @import("std");

/// The type of campaign communication time config
pub const CommunicationTimeConfigType = enum {
    telephony,
    sms,
    email,
    whatsapp,

    pub const json_field_names = .{
        .telephony = "TELEPHONY",
        .sms = "SMS",
        .email = "EMAIL",
        .whatsapp = "WHATSAPP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .telephony => "TELEPHONY",
            .sms => "SMS",
            .email => "EMAIL",
            .whatsapp => "WHATSAPP",
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
