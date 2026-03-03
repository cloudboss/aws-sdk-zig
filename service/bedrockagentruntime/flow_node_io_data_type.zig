const std = @import("std");

pub const FlowNodeIODataType = enum {
    string,
    number,
    boolean,
    object,
    array,

    pub const json_field_names = .{
        .string = "String",
        .number = "Number",
        .boolean = "Boolean",
        .object = "Object",
        .array = "Array",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "String",
            .number => "Number",
            .boolean => "Boolean",
            .object => "Object",
            .array => "Array",
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
