const std = @import("std");

pub const GuardrailContentFilterType = enum {
    insults,
    hate,
    sexual,
    violence,
    misconduct,
    prompt_attack,

    pub const json_field_names = .{
        .insults = "INSULTS",
        .hate = "HATE",
        .sexual = "SEXUAL",
        .violence = "VIOLENCE",
        .misconduct = "MISCONDUCT",
        .prompt_attack = "PROMPT_ATTACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insults => "INSULTS",
            .hate => "HATE",
            .sexual => "SEXUAL",
            .violence => "VIOLENCE",
            .misconduct => "MISCONDUCT",
            .prompt_attack => "PROMPT_ATTACK",
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
