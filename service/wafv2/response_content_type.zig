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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
