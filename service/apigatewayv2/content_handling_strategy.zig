const std = @import("std");

/// Specifies how to handle response payload content type conversions. Supported
/// only for WebSocket APIs.
pub const ContentHandlingStrategy = enum {
    convert_to_binary,
    convert_to_text,

    pub const json_field_names = .{
        .convert_to_binary = "CONVERT_TO_BINARY",
        .convert_to_text = "CONVERT_TO_TEXT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .convert_to_binary => "CONVERT_TO_BINARY",
            .convert_to_text => "CONVERT_TO_TEXT",
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
