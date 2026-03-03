const std = @import("std");

pub const FlowAssociationResourceType = enum {
    sms_phone_number,
    inbound_email,
    outbound_email,
    analytics_connector,
    whatsapp_messaging_phone_number,

    pub const json_field_names = .{
        .sms_phone_number = "SMS_PHONE_NUMBER",
        .inbound_email = "INBOUND_EMAIL",
        .outbound_email = "OUTBOUND_EMAIL",
        .analytics_connector = "ANALYTICS_CONNECTOR",
        .whatsapp_messaging_phone_number = "WHATSAPP_MESSAGING_PHONE_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sms_phone_number => "SMS_PHONE_NUMBER",
            .inbound_email => "INBOUND_EMAIL",
            .outbound_email => "OUTBOUND_EMAIL",
            .analytics_connector => "ANALYTICS_CONNECTOR",
            .whatsapp_messaging_phone_number => "WHATSAPP_MESSAGING_PHONE_NUMBER",
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
