const std = @import("std");

pub const DataLakeDatasetSchemaFieldType = enum {
    int,
    double,
    string,
    timestamp,
    long,

    pub const json_field_names = .{
        .int = "INT",
        .double = "DOUBLE",
        .string = "STRING",
        .timestamp = "TIMESTAMP",
        .long = "LONG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .int => "INT",
            .double => "DOUBLE",
            .string => "STRING",
            .timestamp => "TIMESTAMP",
            .long => "LONG",
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
