const std = @import("std");

pub const Type = enum {
    relationship,
    string,
    long,
    boolean,
    integer,
    double,
    list,
    map,

    pub const json_field_names = .{
        .relationship = "RELATIONSHIP",
        .string = "STRING",
        .long = "LONG",
        .boolean = "BOOLEAN",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .list = "LIST",
        .map = "MAP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .relationship => "RELATIONSHIP",
            .string => "STRING",
            .long => "LONG",
            .boolean => "BOOLEAN",
            .integer => "INTEGER",
            .double => "DOUBLE",
            .list => "LIST",
            .map => "MAP",
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
