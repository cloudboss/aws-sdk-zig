const std = @import("std");

pub const HarnessHookEventType = enum {
    before_tool_call,
    after_tool_call,
    before_invocation,
    after_invocation,

    pub const json_field_names = .{
        .before_tool_call = "before_tool_call",
        .after_tool_call = "after_tool_call",
        .before_invocation = "before_invocation",
        .after_invocation = "after_invocation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_tool_call => "before_tool_call",
            .after_tool_call => "after_tool_call",
            .before_invocation => "before_invocation",
            .after_invocation => "after_invocation",
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
