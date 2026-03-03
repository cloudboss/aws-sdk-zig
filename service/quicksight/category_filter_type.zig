const std = @import("std");

pub const CategoryFilterType = enum {
    custom_filter,
    custom_filter_list,
    filter_list,

    pub const json_field_names = .{
        .custom_filter = "CUSTOM_FILTER",
        .custom_filter_list = "CUSTOM_FILTER_LIST",
        .filter_list = "FILTER_LIST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_filter => "CUSTOM_FILTER",
            .custom_filter_list => "CUSTOM_FILTER_LIST",
            .filter_list => "FILTER_LIST",
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
