const std = @import("std");

pub const ParameterType = enum {
    smallint,
    integer,
    bigint,
    decimal,
    real,
    double_precision,
    boolean,
    char,
    varchar,
    date,
    timestamp,
    timestamptz,
    time,
    timetz,
    varbyte,
    binary,
    byte,
    character,
    double,
    float,
    int,
    long,
    numeric,
    short,
    string,
    timestamp_ltz,
    timestamp_ntz,
    tinyint,

    pub const json_field_names = .{
        .smallint = "SMALLINT",
        .integer = "INTEGER",
        .bigint = "BIGINT",
        .decimal = "DECIMAL",
        .real = "REAL",
        .double_precision = "DOUBLE_PRECISION",
        .boolean = "BOOLEAN",
        .char = "CHAR",
        .varchar = "VARCHAR",
        .date = "DATE",
        .timestamp = "TIMESTAMP",
        .timestamptz = "TIMESTAMPTZ",
        .time = "TIME",
        .timetz = "TIMETZ",
        .varbyte = "VARBYTE",
        .binary = "BINARY",
        .byte = "BYTE",
        .character = "CHARACTER",
        .double = "DOUBLE",
        .float = "FLOAT",
        .int = "INT",
        .long = "LONG",
        .numeric = "NUMERIC",
        .short = "SHORT",
        .string = "STRING",
        .timestamp_ltz = "TIMESTAMP_LTZ",
        .timestamp_ntz = "TIMESTAMP_NTZ",
        .tinyint = "TINYINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .smallint => "SMALLINT",
            .integer => "INTEGER",
            .bigint => "BIGINT",
            .decimal => "DECIMAL",
            .real => "REAL",
            .double_precision => "DOUBLE_PRECISION",
            .boolean => "BOOLEAN",
            .char => "CHAR",
            .varchar => "VARCHAR",
            .date => "DATE",
            .timestamp => "TIMESTAMP",
            .timestamptz => "TIMESTAMPTZ",
            .time => "TIME",
            .timetz => "TIMETZ",
            .varbyte => "VARBYTE",
            .binary => "BINARY",
            .byte => "BYTE",
            .character => "CHARACTER",
            .double => "DOUBLE",
            .float => "FLOAT",
            .int => "INT",
            .long => "LONG",
            .numeric => "NUMERIC",
            .short => "SHORT",
            .string => "STRING",
            .timestamp_ltz => "TIMESTAMP_LTZ",
            .timestamp_ntz => "TIMESTAMP_NTZ",
            .tinyint => "TINYINT",
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
