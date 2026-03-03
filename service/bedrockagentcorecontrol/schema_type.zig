const std = @import("std");

pub const SchemaType = enum {
    string,
    number,
    object,
    array,
    boolean,
    integer,

    pub const json_field_names = .{
        .string = "string",
        .number = "number",
        .object = "object",
        .array = "array",
        .boolean = "boolean",
        .integer = "integer",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "string",
            .number => "number",
            .object => "object",
            .array => "array",
            .boolean => "boolean",
            .integer => "integer",
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
