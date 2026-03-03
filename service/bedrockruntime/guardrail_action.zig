const std = @import("std");

pub const GuardrailAction = enum {
    none,
    guardrail_intervened,

    pub const json_field_names = .{
        .none = "NONE",
        .guardrail_intervened = "GUARDRAIL_INTERVENED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .guardrail_intervened => "GUARDRAIL_INTERVENED",
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
