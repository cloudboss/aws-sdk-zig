const std = @import("std");

pub const PhoneNumberProductType = enum {
    business_calling,
    voice_connector,
    sip_media_application_dial_in,

    pub const json_field_names = .{
        .business_calling = "BusinessCalling",
        .voice_connector = "VoiceConnector",
        .sip_media_application_dial_in = "SipMediaApplicationDialIn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .business_calling => "BusinessCalling",
            .voice_connector => "VoiceConnector",
            .sip_media_application_dial_in => "SipMediaApplicationDialIn",
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
