const std = @import("std");

pub const GlueRecordType = enum {
    date,
    string,
    timestamp,
    int,
    float,
    long,
    bigdecimal,
    byte,
    short,
    double,

    pub const json_field_names = .{
        .date = "DATE",
        .string = "STRING",
        .timestamp = "TIMESTAMP",
        .int = "INT",
        .float = "FLOAT",
        .long = "LONG",
        .bigdecimal = "BIGDECIMAL",
        .byte = "BYTE",
        .short = "SHORT",
        .double = "DOUBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .date => "DATE",
            .string => "STRING",
            .timestamp => "TIMESTAMP",
            .int => "INT",
            .float => "FLOAT",
            .long => "LONG",
            .bigdecimal => "BIGDECIMAL",
            .byte => "BYTE",
            .short => "SHORT",
            .double => "DOUBLE",
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
