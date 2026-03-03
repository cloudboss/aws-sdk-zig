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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
