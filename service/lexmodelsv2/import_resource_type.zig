const std = @import("std");

pub const ImportResourceType = enum {
    bot,
    bot_locale,
    custom_vocabulary,
    test_set,

    pub const json_field_names = .{
        .bot = "Bot",
        .bot_locale = "BotLocale",
        .custom_vocabulary = "CustomVocabulary",
        .test_set = "TestSet",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bot => "Bot",
            .bot_locale => "BotLocale",
            .custom_vocabulary => "CustomVocabulary",
            .test_set => "TestSet",
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
