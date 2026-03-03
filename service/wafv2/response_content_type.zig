const std = @import("std");

pub const ResponseContentType = enum {
    text_plain,
    text_html,
    application_json,

    pub const json_field_names = .{
        .text_plain = "TEXT_PLAIN",
        .text_html = "TEXT_HTML",
        .application_json = "APPLICATION_JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text_plain => "TEXT_PLAIN",
            .text_html => "TEXT_HTML",
            .application_json => "APPLICATION_JSON",
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
