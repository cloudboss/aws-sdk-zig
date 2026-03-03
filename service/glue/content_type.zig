const std = @import("std");

pub const ContentType = enum {
    application_json,
    url_encoded,

    pub const json_field_names = .{
        .application_json = "APPLICATION_JSON",
        .url_encoded = "URL_ENCODED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application_json => "APPLICATION_JSON",
            .url_encoded => "URL_ENCODED",
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
