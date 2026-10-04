const std = @import("std");

pub const HarnessOpenAiApiFormat = enum {
    /// Use the Chat Completions API format.
    chat_completions,
    /// Use the Responses API format.
    responses,

    pub const json_field_names = .{
        .chat_completions = "chat_completions",
        .responses = "responses",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .chat_completions => "chat_completions",
            .responses => "responses",
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
