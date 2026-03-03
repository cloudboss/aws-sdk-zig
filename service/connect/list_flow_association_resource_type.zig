const std = @import("std");

pub const ListFlowAssociationResourceType = enum {
    whatsapp_messaging_phone_number,
    voice_phone_number,
    inbound_email,
    outbound_email,
    analytics_connector,

    pub const json_field_names = .{
        .whatsapp_messaging_phone_number = "WHATSAPP_MESSAGING_PHONE_NUMBER",
        .voice_phone_number = "VOICE_PHONE_NUMBER",
        .inbound_email = "INBOUND_EMAIL",
        .outbound_email = "OUTBOUND_EMAIL",
        .analytics_connector = "ANALYTICS_CONNECTOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .whatsapp_messaging_phone_number => "WHATSAPP_MESSAGING_PHONE_NUMBER",
            .voice_phone_number => "VOICE_PHONE_NUMBER",
            .inbound_email => "INBOUND_EMAIL",
            .outbound_email => "OUTBOUND_EMAIL",
            .analytics_connector => "ANALYTICS_CONNECTOR",
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
