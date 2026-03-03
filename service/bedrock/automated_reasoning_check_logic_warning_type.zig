const std = @import("std");

pub const AutomatedReasoningCheckLogicWarningType = enum {
    always_true,
    always_false,

    pub const json_field_names = .{
        .always_true = "ALWAYS_TRUE",
        .always_false = "ALWAYS_FALSE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .always_true => "ALWAYS_TRUE",
            .always_false => "ALWAYS_FALSE",
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
