const std = @import("std");

pub const ChannelType = enum {
    facebook,
    slack,
    twilio_sms,
    kik,

    pub const json_field_names = .{
        .facebook = "Facebook",
        .slack = "Slack",
        .twilio_sms = "Twilio-Sms",
        .kik = "Kik",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .facebook => "Facebook",
            .slack => "Slack",
            .twilio_sms => "Twilio-Sms",
            .kik => "Kik",
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
