const std = @import("std");

pub const InputColumnDataType = enum {
    string,
    integer,
    decimal,
    datetime,
    bit,
    boolean,
    json,
    semistruct,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .decimal = "DECIMAL",
        .datetime = "DATETIME",
        .bit = "BIT",
        .boolean = "BOOLEAN",
        .json = "JSON",
        .semistruct = "SEMISTRUCT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .integer => "INTEGER",
            .decimal => "DECIMAL",
            .datetime => "DATETIME",
            .bit => "BIT",
            .boolean => "BOOLEAN",
            .json => "JSON",
            .semistruct => "SEMISTRUCT",
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
