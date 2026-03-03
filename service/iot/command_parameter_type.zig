const std = @import("std");

pub const CommandParameterType = enum {
    string,
    integer,
    double,
    long,
    unsignedlong,
    boolean,
    binary,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .double = "DOUBLE",
        .long = "LONG",
        .unsignedlong = "UNSIGNEDLONG",
        .boolean = "BOOLEAN",
        .binary = "BINARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .integer => "INTEGER",
            .double => "DOUBLE",
            .long => "LONG",
            .unsignedlong => "UNSIGNEDLONG",
            .boolean => "BOOLEAN",
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
