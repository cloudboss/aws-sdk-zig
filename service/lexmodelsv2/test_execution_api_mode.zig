const std = @import("std");

pub const TestExecutionApiMode = enum {
    streaming,
    non_streaming,

    pub const json_field_names = .{
        .streaming = "Streaming",
        .non_streaming = "NonStreaming",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .streaming => "Streaming",
            .non_streaming => "NonStreaming",
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
