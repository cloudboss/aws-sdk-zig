const std = @import("std");

pub const ContentBlockType = enum {
    text,
    image,
    embedded_resource,
    resource_link,

    pub const json_field_names = .{
        .text = "text",
        .image = "image",
        .embedded_resource = "resource",
        .resource_link = "resource_link",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "text",
            .image => "image",
            .embedded_resource => "resource",
            .resource_link => "resource_link",
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
