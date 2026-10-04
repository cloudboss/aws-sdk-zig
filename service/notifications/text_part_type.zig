const std = @import("std");

pub const TextPartType = enum {
    localized_text,
    plain_text,
    url,
    portable_text,

    pub const json_field_names = .{
        .localized_text = "LOCALIZED_TEXT",
        .plain_text = "PLAIN_TEXT",
        .url = "URL",
        .portable_text = "PORTABLE_TEXT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .localized_text => "LOCALIZED_TEXT",
            .plain_text => "PLAIN_TEXT",
            .url => "URL",
            .portable_text => "PORTABLE_TEXT",
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
