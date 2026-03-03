const std = @import("std");

pub const SheetImageScalingType = enum {
    scale_to_width,
    scale_to_height,
    scale_to_container,
    scale_none,

    pub const json_field_names = .{
        .scale_to_width = "SCALE_TO_WIDTH",
        .scale_to_height = "SCALE_TO_HEIGHT",
        .scale_to_container = "SCALE_TO_CONTAINER",
        .scale_none = "SCALE_NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scale_to_width => "SCALE_TO_WIDTH",
            .scale_to_height => "SCALE_TO_HEIGHT",
            .scale_to_container => "SCALE_TO_CONTAINER",
            .scale_none => "SCALE_NONE",
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
