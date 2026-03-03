const std = @import("std");

pub const ROS2PrimitiveType = enum {
    bool,
    byte,
    char,
    float32,
    float64,
    int8,
    uint8,
    int16,
    uint16,
    int32,
    uint32,
    int64,
    uint64,
    string,
    wstring,

    pub const json_field_names = .{
        .bool = "BOOL",
        .byte = "BYTE",
        .char = "CHAR",
        .float32 = "FLOAT32",
        .float64 = "FLOAT64",
        .int8 = "INT8",
        .uint8 = "UINT8",
        .int16 = "INT16",
        .uint16 = "UINT16",
        .int32 = "INT32",
        .uint32 = "UINT32",
        .int64 = "INT64",
        .uint64 = "UINT64",
        .string = "STRING",
        .wstring = "WSTRING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bool => "BOOL",
            .byte => "BYTE",
            .char => "CHAR",
            .float32 => "FLOAT32",
            .float64 => "FLOAT64",
            .int8 => "INT8",
            .uint8 => "UINT8",
            .int16 => "INT16",
            .uint16 => "UINT16",
            .int32 => "INT32",
            .uint32 => "UINT32",
            .int64 => "INT64",
            .uint64 => "UINT64",
            .string => "STRING",
            .wstring => "WSTRING",
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
