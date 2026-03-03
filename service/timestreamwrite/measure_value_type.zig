const std = @import("std");

pub const MeasureValueType = enum {
    double,
    bigint,
    varchar,
    boolean,
    timestamp,
    multi,

    pub const json_field_names = .{
        .double = "DOUBLE",
        .bigint = "BIGINT",
        .varchar = "VARCHAR",
        .boolean = "BOOLEAN",
        .timestamp = "TIMESTAMP",
        .multi = "MULTI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .double => "DOUBLE",
            .bigint => "BIGINT",
            .varchar => "VARCHAR",
            .boolean => "BOOLEAN",
            .timestamp => "TIMESTAMP",
            .multi => "MULTI",
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
