const std = @import("std");

pub const StepParameterType = enum {
    int,
    float,
    string,
    path,
    chunk_int,

    pub const json_field_names = .{
        .int = "INT",
        .float = "FLOAT",
        .string = "STRING",
        .path = "PATH",
        .chunk_int = "CHUNK_INT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int => "INT",
            .float => "FLOAT",
            .string => "STRING",
            .path => "PATH",
            .chunk_int => "CHUNK_INT",
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
