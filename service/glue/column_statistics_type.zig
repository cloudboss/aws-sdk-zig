const std = @import("std");

pub const ColumnStatisticsType = enum {
    boolean,
    date,
    decimal,
    double,
    long,
    string,
    binary,

    pub const json_field_names = .{
        .boolean = "BOOLEAN",
        .date = "DATE",
        .decimal = "DECIMAL",
        .double = "DOUBLE",
        .long = "LONG",
        .string = "STRING",
        .binary = "BINARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .boolean => "BOOLEAN",
            .date => "DATE",
            .decimal => "DECIMAL",
            .double => "DOUBLE",
            .long => "LONG",
            .string => "STRING",
            .binary => "BINARY",
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
