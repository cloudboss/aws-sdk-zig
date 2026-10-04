const std = @import("std");

pub const AgentOutputMessageType = enum {
    initial_greeting,
    normal,
    user_confirmation_request,
    complete,
    @"error",
    options,
    choices,

    pub const json_field_names = .{
        .initial_greeting = "INITIAL_GREETING",
        .normal = "normal",
        .user_confirmation_request = "confirmation",
        .complete = "complete",
        .@"error" = "error",
        .options = "options",
        .choices = "choices",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initial_greeting => "INITIAL_GREETING",
            .normal => "normal",
            .user_confirmation_request => "confirmation",
            .complete => "complete",
            .@"error" => "error",
            .options => "options",
            .choices => "choices",
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
