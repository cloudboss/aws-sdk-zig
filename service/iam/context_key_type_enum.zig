const std = @import("std");

pub const ContextKeyTypeEnum = enum {
    string,
    string_list,
    numeric,
    numeric_list,
    boolean,
    boolean_list,
    ip,
    ip_list,
    binary,
    binary_list,
    date,
    date_list,

    pub const json_field_names = .{
        .string = "string",
        .string_list = "stringList",
        .numeric = "numeric",
        .numeric_list = "numericList",
        .boolean = "boolean",
        .boolean_list = "booleanList",
        .ip = "ip",
        .ip_list = "ipList",
        .binary = "binary",
        .binary_list = "binaryList",
        .date = "date",
        .date_list = "dateList",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "string",
            .string_list => "stringList",
            .numeric => "numeric",
            .numeric_list => "numericList",
            .boolean => "boolean",
            .boolean_list => "booleanList",
            .ip => "ip",
            .ip_list => "ipList",
            .binary => "binary",
            .binary_list => "binaryList",
            .date => "date",
            .date_list => "dateList",
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
