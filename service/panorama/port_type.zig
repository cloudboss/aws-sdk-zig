const std = @import("std");

pub const PortType = enum {
    boolean,
    string,
    int32,
    float32,
    media,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .string = "STRING",
        .int32 = "INT32",
        .float32 = "FLOAT32",
        .media = "MEDIA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .boolean => "BOOLEAN",
            .string => "STRING",
            .int32 => "INT32",
            .float32 => "FLOAT32",
            .media => "MEDIA",
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
