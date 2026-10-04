const std = @import("std");

pub const PropertyDataType = enum {
    string,
    integer,
    double,
    boolean,
    @"struct",
    video,
    annotation,
    json,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .boolean = "BOOLEAN",
        .@"struct" = "STRUCT",
        .video = "VIDEO",
        .annotation = "ANNOTATION",
        .json = "JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .integer => "INTEGER",
            .double => "DOUBLE",
            .boolean => "BOOLEAN",
            .@"struct" => "STRUCT",
            .video => "VIDEO",
            .annotation => "ANNOTATION",
            .json => "JSON",
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
