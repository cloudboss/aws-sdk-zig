const std = @import("std");

pub const RetrievalResultContentColumnType = enum {
    blob,
    boolean,
    double,
    null,
    long,
    string,

    pub const json_field_names = .{
        .blob = "BLOB",
        .boolean = "BOOLEAN",
        .double = "DOUBLE",
        .null = "NULL",
        .long = "LONG",
        .string = "STRING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blob => "BLOB",
            .boolean => "BOOLEAN",
            .double => "DOUBLE",
            .null => "NULL",
            .long => "LONG",
            .string => "STRING",
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
