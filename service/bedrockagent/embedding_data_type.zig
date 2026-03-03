const std = @import("std");

/// Bedrock models embedding data type. Can be either float32 or binary.
pub const EmbeddingDataType = enum {
    float32,
    binary,

    pub const json_field_names = .{
        .float32 = "FLOAT32",
        .binary = "BINARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .float32 => "FLOAT32",
            .binary => "BINARY",
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
