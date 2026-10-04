const std = @import("std");

/// The scope of analysis to perform on the bot.
///
/// Valid values include:
///
/// * `BotLocale`
pub const AnalysisScope = enum {
    bot_locale,

    pub const json_field_names = .{
        .bot_locale = "BotLocale",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bot_locale => "BotLocale",
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
