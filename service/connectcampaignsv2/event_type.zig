const std = @import("std");

/// Enumeration of Customer Profiles event type
pub const EventType = enum {
    campaign_email,
    campaign_sms,
    campaign_telephony,
    campaign_orchestration,

    pub const json_field_names = .{
        .campaign_email = "Campaign-Email",
        .campaign_sms = "Campaign-SMS",
        .campaign_telephony = "Campaign-Telephony",
        .campaign_orchestration = "Campaign-Orchestration",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .campaign_email => "Campaign-Email",
            .campaign_sms => "Campaign-SMS",
            .campaign_telephony => "Campaign-Telephony",
            .campaign_orchestration => "Campaign-Orchestration",
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
