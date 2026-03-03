const std = @import("std");

pub const GuardrailContentFilterType = enum {
    sexual,
    violence,
    hate,
    insults,
    misconduct,
    prompt_attack,

    pub const json_field_names = .{
        .sexual = "SEXUAL",
        .violence = "VIOLENCE",
        .hate = "HATE",
        .insults = "INSULTS",
        .misconduct = "MISCONDUCT",
        .prompt_attack = "PROMPT_ATTACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sexual => "SEXUAL",
            .violence => "VIOLENCE",
            .hate => "HATE",
            .insults => "INSULTS",
            .misconduct => "MISCONDUCT",
            .prompt_attack => "PROMPT_ATTACK",
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
