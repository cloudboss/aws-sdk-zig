const std = @import("std");

pub const ColumnDataType = enum {
    string,
    integer,
    decimal,
    datetime,

    pub const json_field_names = .{
        .string = "STRING",
        .integer = "INTEGER",
        .decimal = "DECIMAL",
        .datetime = "DATETIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .integer => "INTEGER",
            .decimal => "DECIMAL",
            .datetime => "DATETIME",
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
