const std = @import("std");

pub const AnswerReason = enum {
    out_of_scope,
    business_priorities,
    architecture_constraints,
    other,
    none,

    pub const json_field_names = .{
        .out_of_scope = "OUT_OF_SCOPE",
        .business_priorities = "BUSINESS_PRIORITIES",
        .architecture_constraints = "ARCHITECTURE_CONSTRAINTS",
        .other = "OTHER",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .out_of_scope => "OUT_OF_SCOPE",
            .business_priorities => "BUSINESS_PRIORITIES",
            .architecture_constraints => "ARCHITECTURE_CONSTRAINTS",
            .other => "OTHER",
            .none => "NONE",
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
