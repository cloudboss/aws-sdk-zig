const std = @import("std");

pub const TransformTypeEnum = enum {
    host_header_rewrite,
    url_rewrite,

    pub const json_field_names = .{
        .host_header_rewrite = "host-header-rewrite",
        .url_rewrite = "url-rewrite",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .host_header_rewrite => "host-header-rewrite",
            .url_rewrite => "url-rewrite",
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
