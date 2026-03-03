const std = @import("std");

pub const DocumentAttributeValueType = enum {
    string_value,
    string_list_value,
    long_value,
    date_value,

    pub const json_field_names = .{
        .string_value = "STRING_VALUE",
        .string_list_value = "STRING_LIST_VALUE",
        .long_value = "LONG_VALUE",
        .date_value = "DATE_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string_value => "STRING_VALUE",
            .string_list_value => "STRING_LIST_VALUE",
            .long_value => "LONG_VALUE",
            .date_value => "DATE_VALUE",
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
