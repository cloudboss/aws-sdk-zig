const std = @import("std");

pub const DimensionValueSource = enum {
    message_tag,
    email_header,
    link_tag,

    pub const json_field_names = .{
        .message_tag = "messageTag",
        .email_header = "emailHeader",
        .link_tag = "linkTag",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .message_tag => "messageTag",
            .email_header => "emailHeader",
            .link_tag => "linkTag",
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
