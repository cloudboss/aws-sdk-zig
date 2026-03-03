const std = @import("std");

pub const QAResultType = enum {
    dashboard_visual,
    generated_answer,
    no_answer,

    pub const json_field_names = .{
        .dashboard_visual = "DASHBOARD_VISUAL",
        .generated_answer = "GENERATED_ANSWER",
        .no_answer = "NO_ANSWER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dashboard_visual => "DASHBOARD_VISUAL",
            .generated_answer => "GENERATED_ANSWER",
            .no_answer => "NO_ANSWER",
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
