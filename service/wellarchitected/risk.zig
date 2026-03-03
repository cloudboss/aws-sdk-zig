const std = @import("std");

/// The risk for a given workload, lens review, pillar, or question.
pub const Risk = enum {
    unanswered,
    high,
    medium,
    none,
    not_applicable,

    pub const json_field_names = .{
        .unanswered = "UNANSWERED",
        .high = "HIGH",
        .medium = "MEDIUM",
        .none = "NONE",
        .not_applicable = "NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unanswered => "UNANSWERED",
            .high => "HIGH",
            .medium => "MEDIUM",
            .none => "NONE",
            .not_applicable => "NOT_APPLICABLE",
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
