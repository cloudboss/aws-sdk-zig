const std = @import("std");

pub const FieldType = enum {
    text,
    number,
    boolean,
    date_time,
    single_select,
    url,
    user,

    pub const json_field_names = .{
        .text = "Text",
        .number = "Number",
        .boolean = "Boolean",
        .date_time = "DateTime",
        .single_select = "SingleSelect",
        .url = "Url",
        .user = "User",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "Text",
            .number => "Number",
            .boolean => "Boolean",
            .date_time => "DateTime",
            .single_select => "SingleSelect",
            .url => "Url",
            .user => "User",
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
