const std = @import("std");

pub const LayoutElementType = enum {
    visual,
    filter_control,
    parameter_control,
    text_box,
    image,

    pub const json_field_names = .{
        .visual = "VISUAL",
        .filter_control = "FILTER_CONTROL",
        .parameter_control = "PARAMETER_CONTROL",
        .text_box = "TEXT_BOX",
        .image = "IMAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .visual => "VISUAL",
            .filter_control => "FILTER_CONTROL",
            .parameter_control => "PARAMETER_CONTROL",
            .text_box => "TEXT_BOX",
            .image => "IMAGE",
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
