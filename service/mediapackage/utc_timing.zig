const std = @import("std");

pub const UtcTiming = enum {
    none,
    http_head,
    http_iso,
    http_xsdate,

    pub const json_field_names = .{
        .none = "NONE",
        .http_head = "HTTP-HEAD",
        .http_iso = "HTTP-ISO",
        .http_xsdate = "HTTP-XSDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .http_head => "HTTP-HEAD",
            .http_iso => "HTTP-ISO",
            .http_xsdate => "HTTP-XSDATE",
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
