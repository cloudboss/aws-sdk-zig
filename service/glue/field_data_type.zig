const std = @import("std");

pub const FieldDataType = enum {
    int,
    smallint,
    bigint,
    float,
    long,
    date,
    boolean,
    map,
    array,
    string,
    timestamp,
    decimal,
    byte,
    short,
    double,
    @"struct",
    binary,
    @"union",

    pub const json_field_names = .{
        .int = "INT",
        .smallint = "SMALLINT",
        .bigint = "BIGINT",
        .float = "FLOAT",
        .long = "LONG",
        .date = "DATE",
        .boolean = "BOOLEAN",
        .map = "MAP",
        .array = "ARRAY",
        .string = "STRING",
        .timestamp = "TIMESTAMP",
        .decimal = "DECIMAL",
        .byte = "BYTE",
        .short = "SHORT",
        .double = "DOUBLE",
        .@"struct" = "STRUCT",
        .binary = "BINARY",
        .@"union" = "UNION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int => "INT",
            .smallint => "SMALLINT",
            .bigint => "BIGINT",
            .float => "FLOAT",
            .long => "LONG",
            .date => "DATE",
            .boolean => "BOOLEAN",
            .map => "MAP",
            .array => "ARRAY",
            .string => "STRING",
            .timestamp => "TIMESTAMP",
            .decimal => "DECIMAL",
            .byte => "BYTE",
            .short => "SHORT",
            .double => "DOUBLE",
            .@"struct" => "STRUCT",
            .binary => "BINARY",
            .@"union" => "UNION",
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
