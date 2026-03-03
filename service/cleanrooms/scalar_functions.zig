const std = @import("std");

pub const ScalarFunctions = enum {
    abs,
    cast,
    ceiling,
    coalesce,
    convert,
    current_date,
    dateadd,
    extract,
    floor,
    getdate,
    ln,
    log,
    lower,
    round,
    rtrim,
    sqrt,
    substring,
    to_char,
    to_date,
    to_number,
    to_timestamp,
    trim,
    trunc,
    upper,

    pub const json_field_names = .{
        .abs = "ABS",
        .cast = "CAST",
        .ceiling = "CEILING",
        .coalesce = "COALESCE",
        .convert = "CONVERT",
        .current_date = "CURRENT_DATE",
        .dateadd = "DATEADD",
        .extract = "EXTRACT",
        .floor = "FLOOR",
        .getdate = "GETDATE",
        .ln = "LN",
        .log = "LOG",
        .lower = "LOWER",
        .round = "ROUND",
        .rtrim = "RTRIM",
        .sqrt = "SQRT",
        .substring = "SUBSTRING",
        .to_char = "TO_CHAR",
        .to_date = "TO_DATE",
        .to_number = "TO_NUMBER",
        .to_timestamp = "TO_TIMESTAMP",
        .trim = "TRIM",
        .trunc = "TRUNC",
        .upper = "UPPER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .abs => "ABS",
            .cast => "CAST",
            .ceiling => "CEILING",
            .coalesce => "COALESCE",
            .convert => "CONVERT",
            .current_date => "CURRENT_DATE",
            .dateadd => "DATEADD",
            .extract => "EXTRACT",
            .floor => "FLOOR",
            .getdate => "GETDATE",
            .ln => "LN",
            .log => "LOG",
            .lower => "LOWER",
            .round => "ROUND",
            .rtrim => "RTRIM",
            .sqrt => "SQRT",
            .substring => "SUBSTRING",
            .to_char => "TO_CHAR",
            .to_date => "TO_DATE",
            .to_number => "TO_NUMBER",
            .to_timestamp => "TO_TIMESTAMP",
            .trim => "TRIM",
            .trunc => "TRUNC",
            .upper => "UPPER",
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
