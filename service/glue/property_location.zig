const std = @import("std");

pub const PropertyLocation = enum {
    header,
    body,
    query_param,
    path,

    pub const json_field_names = .{
        .header = "HEADER",
        .body = "BODY",
        .query_param = "QUERY_PARAM",
        .path = "PATH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .header => "HEADER",
            .body => "BODY",
            .query_param => "QUERY_PARAM",
            .path => "PATH",
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
