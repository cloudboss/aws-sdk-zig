const std = @import("std");

pub const ContentPolicyFilterType = enum {
    prompt_attack,
    jailbreak,
    hate,
    insults,
    sexual,
    violence,
    misconduct,

    pub const json_field_names = .{
        .prompt_attack = "PROMPT_ATTACK",
        .jailbreak = "JAILBREAK",
        .hate = "HATE",
        .insults = "INSULTS",
        .sexual = "SEXUAL",
        .violence = "VIOLENCE",
        .misconduct = "MISCONDUCT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prompt_attack => "PROMPT_ATTACK",
            .jailbreak => "JAILBREAK",
            .hate => "HATE",
            .insults => "INSULTS",
            .sexual => "SEXUAL",
            .violence => "VIOLENCE",
            .misconduct => "MISCONDUCT",
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
