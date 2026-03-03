const std = @import("std");

pub const RawValueType = enum {
    double,
    boolean,
    string,
    integer,
    unknown,

    pub const json_field_names = .{
        .double = "D",
        .boolean = "B",
        .string = "S",
        .integer = "I",
        .unknown = "U",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .double => "D",
            .boolean => "B",
            .string => "S",
            .integer => "I",
            .unknown => "U",
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
