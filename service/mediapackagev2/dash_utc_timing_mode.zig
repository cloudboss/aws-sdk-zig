const std = @import("std");

pub const DashUtcTimingMode = enum {
    http_head,
    http_iso,
    http_xsdate,
    utc_direct,

    pub const json_field_names = .{
        .http_head = "HTTP_HEAD",
        .http_iso = "HTTP_ISO",
        .http_xsdate = "HTTP_XSDATE",
        .utc_direct = "UTC_DIRECT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .http_head => "HTTP_HEAD",
            .http_iso => "HTTP_ISO",
            .http_xsdate => "HTTP_XSDATE",
            .utc_direct => "UTC_DIRECT",
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
