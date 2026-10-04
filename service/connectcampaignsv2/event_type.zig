const std = @import("std");

/// Enumeration of Customer Profiles event type
pub const EventType = enum {
    campaign_email,
    campaign_sms,
    campaign_telephony,
    campaign_orchestration,
    campaign_whats_app,
    campaign_web_notification,

    pub const json_field_names = .{
        .campaign_email = "Campaign-Email",
        .campaign_sms = "Campaign-SMS",
        .campaign_telephony = "Campaign-Telephony",
        .campaign_orchestration = "Campaign-Orchestration",
        .campaign_whats_app = "Campaign-WhatsApp",
        .campaign_web_notification = "Campaign-WebNotification",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .campaign_email => "Campaign-Email",
            .campaign_sms => "Campaign-SMS",
            .campaign_telephony => "Campaign-Telephony",
            .campaign_orchestration => "Campaign-Orchestration",
            .campaign_whats_app => "Campaign-WhatsApp",
            .campaign_web_notification => "Campaign-WebNotification",
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
