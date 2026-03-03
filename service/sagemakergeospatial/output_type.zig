const std = @import("std");

pub const OutputType = enum {
    /// INT32
    int32,
    /// FLOAT32
    float32,
    /// INT16
    int16,
    /// FLOAT64
    float64,
    /// UINT16
    uint16,

    pub const json_field_names = .{
        .int32 = "INT32",
        .float32 = "FLOAT32",
        .int16 = "INT16",
        .float64 = "FLOAT64",
        .uint16 = "UINT16",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int32 => "INT32",
            .float32 => "FLOAT32",
            .int16 => "INT16",
            .float64 => "FLOAT64",
            .uint16 => "UINT16",
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
