const std = @import("std");

pub const HarnessBedrockApiFormat = enum {
    /// Use the Bedrock Converse Stream API format.
    converse_stream,
    /// Use the Responses API format.
    responses,
    /// Use the Chat Completions API format.
    chat_completions,

    pub const json_field_names = .{
        .converse_stream = "converse_stream",
        .responses = "responses",
        .chat_completions = "chat_completions",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .converse_stream => "converse_stream",
            .responses => "responses",
            .chat_completions => "chat_completions",
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
