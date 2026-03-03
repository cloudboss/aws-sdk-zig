const std = @import("std");

pub const ScalarType = enum {
    varchar,
    boolean,
    bigint,
    double,
    timestamp,
    date,
    time,
    interval_day_to_second,
    interval_year_to_month,
    unknown,
    integer,

    pub const json_field_names = .{
        .varchar = "VARCHAR",
        .boolean = "BOOLEAN",
        .bigint = "BIGINT",
        .double = "DOUBLE",
        .timestamp = "TIMESTAMP",
        .date = "DATE",
        .time = "TIME",
        .interval_day_to_second = "INTERVAL_DAY_TO_SECOND",
        .interval_year_to_month = "INTERVAL_YEAR_TO_MONTH",
        .unknown = "UNKNOWN",
        .integer = "INTEGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .varchar => "VARCHAR",
            .boolean => "BOOLEAN",
            .bigint => "BIGINT",
            .double => "DOUBLE",
            .timestamp => "TIMESTAMP",
            .date => "DATE",
            .time => "TIME",
            .interval_day_to_second => "INTERVAL_DAY_TO_SECOND",
            .interval_year_to_month => "INTERVAL_YEAR_TO_MONTH",
            .unknown => "UNKNOWN",
            .integer => "INTEGER",
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
