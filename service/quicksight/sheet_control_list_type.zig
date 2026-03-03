const std = @import("std");

pub const SheetControlListType = enum {
    multi_select,
    single_select,

    pub const json_field_names = .{
        .multi_select = "MULTI_SELECT",
        .single_select = "SINGLE_SELECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multi_select => "MULTI_SELECT",
            .single_select => "SINGLE_SELECT",
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
