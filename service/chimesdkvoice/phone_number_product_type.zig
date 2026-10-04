const std = @import("std");

pub const PhoneNumberProductType = enum {
    voice_connector,
    sip_media_application_dial_in,

    pub const json_field_names = .{
        .voice_connector = "VoiceConnector",
        .sip_media_application_dial_in = "SipMediaApplicationDialIn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .voice_connector => "VoiceConnector",
            .sip_media_application_dial_in => "SipMediaApplicationDialIn",
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
