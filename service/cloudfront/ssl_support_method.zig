const std = @import("std");

pub const SSLSupportMethod = enum {
    sni_only,
    vip,
    static_ip,

    pub const json_field_names = .{
        .sni_only = "sni-only",
        .vip = "vip",
        .static_ip = "static-ip",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sni_only => "sni-only",
            .vip => "vip",
            .static_ip => "static-ip",
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
