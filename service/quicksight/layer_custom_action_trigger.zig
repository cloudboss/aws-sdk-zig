const std = @import("std");

pub const LayerCustomActionTrigger = enum {
    data_point_click,
    data_point_menu,

    pub const json_field_names = .{
        .data_point_click = "DATA_POINT_CLICK",
        .data_point_menu = "DATA_POINT_MENU",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_point_click => "DATA_POINT_CLICK",
            .data_point_menu => "DATA_POINT_MENU",
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
