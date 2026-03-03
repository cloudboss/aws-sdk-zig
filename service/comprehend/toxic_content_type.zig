const std = @import("std");

pub const ToxicContentType = enum {
    graphic,
    harassment_or_abuse,
    hate_speech,
    insult,
    profanity,
    sexual,
    violence_or_threat,

    pub const json_field_names = .{
        .graphic = "GRAPHIC",
        .harassment_or_abuse = "HARASSMENT_OR_ABUSE",
        .hate_speech = "HATE_SPEECH",
        .insult = "INSULT",
        .profanity = "PROFANITY",
        .sexual = "SEXUAL",
        .violence_or_threat = "VIOLENCE_OR_THREAT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .graphic => "GRAPHIC",
            .harassment_or_abuse => "HARASSMENT_OR_ABUSE",
            .hate_speech => "HATE_SPEECH",
            .insult => "INSULT",
            .profanity => "PROFANITY",
            .sexual => "SEXUAL",
            .violence_or_threat => "VIOLENCE_OR_THREAT",
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
