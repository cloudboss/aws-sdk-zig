const std = @import("std");

pub const parameterTypeType = enum {
    string,
    string_list,
    number,
    number_list,
    arn,
    arn_list,

    pub const json_field_names = .{
        .string = "String",
        .string_list = "StringList",
        .number = "Number",
        .number_list = "NumberList",
        .arn = "Arn",
        .arn_list = "ArnList",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string => "String",
            .string_list => "StringList",
            .number => "Number",
            .number_list => "NumberList",
            .arn => "Arn",
            .arn_list => "ArnList",
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
