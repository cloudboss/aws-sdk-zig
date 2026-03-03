const std = @import("std");

/// Data type of a column.
pub const ColumnDataType = enum {
    string,
    char,
    integer,
    tinyint,
    smallint,
    bigint,
    float,
    double,
    date,
    datetime,
    boolean,
    binary,

    pub const json_field_names = .{
        .string = "STRING",
        .char = "CHAR",
        .integer = "INTEGER",
        .tinyint = "TINYINT",
        .smallint = "SMALLINT",
        .bigint = "BIGINT",
        .float = "FLOAT",
        .double = "DOUBLE",
        .date = "DATE",
        .datetime = "DATETIME",
        .boolean = "BOOLEAN",
        .binary = "BINARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .char => "CHAR",
            .integer => "INTEGER",
            .tinyint => "TINYINT",
            .smallint => "SMALLINT",
            .bigint => "BIGINT",
            .float => "FLOAT",
            .double => "DOUBLE",
            .date => "DATE",
            .datetime => "DATETIME",
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
