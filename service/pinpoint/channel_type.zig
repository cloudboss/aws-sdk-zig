const std = @import("std");

pub const ChannelType = enum {
    push,
    gcm,
    apns,
    apns_sandbox,
    apns_voip,
    apns_voip_sandbox,
    adm,
    sms,
    voice,
    email,
    baidu,
    custom,
    in_app,

    pub const json_field_names = .{
        .push = "PUSH",
        .gcm = "GCM",
        .apns = "APNS",
        .apns_sandbox = "APNS_SANDBOX",
        .apns_voip = "APNS_VOIP",
        .apns_voip_sandbox = "APNS_VOIP_SANDBOX",
        .adm = "ADM",
        .sms = "SMS",
        .voice = "VOICE",
        .email = "EMAIL",
        .baidu = "BAIDU",
        .custom = "CUSTOM",
        .in_app = "IN_APP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .push => "PUSH",
            .gcm => "GCM",
            .apns => "APNS",
            .apns_sandbox => "APNS_SANDBOX",
            .apns_voip => "APNS_VOIP",
            .apns_voip_sandbox => "APNS_VOIP_SANDBOX",
            .adm => "ADM",
            .sms => "SMS",
            .voice => "VOICE",
            .email => "EMAIL",
            .baidu => "BAIDU",
            .custom => "CUSTOM",
            .in_app => "IN_APP",
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
