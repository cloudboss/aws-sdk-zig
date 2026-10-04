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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
