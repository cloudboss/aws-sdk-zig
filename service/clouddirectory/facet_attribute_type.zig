const std = @import("std");

pub const FacetAttributeType = enum {
    string,
    binary,
    boolean,
    number,
    datetime,
    variant,

    pub const json_field_names = .{
        .string = "STRING",
        .binary = "BINARY",
        .boolean = "BOOLEAN",
        .number = "NUMBER",
        .datetime = "DATETIME",
        .variant = "VARIANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "STRING",
            .binary => "BINARY",
            .boolean => "BOOLEAN",
            .number => "NUMBER",
            .datetime => "DATETIME",
            .variant => "VARIANT",
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
