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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
