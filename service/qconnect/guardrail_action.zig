const std = @import("std");

/// The outcome of a guardrail assessment.
pub const GuardrailAction = enum {
    none,
    blocked,
    masked,

    pub const json_field_names = .{
        .none = "NONE",
        .blocked = "BLOCKED",
        .masked = "MASKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .blocked => "BLOCKED",
            .masked => "MASKED",
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
