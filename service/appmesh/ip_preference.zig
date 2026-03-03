const std = @import("std");

pub const IpPreference = enum {
    i_pv_6_preferred,
    i_pv_4_preferred,
    i_pv_4_only,
    i_pv_6_only,

    pub const json_field_names = .{
        .i_pv_6_preferred = "IPv6_PREFERRED",
        .i_pv_4_preferred = "IPv4_PREFERRED",
        .i_pv_4_only = "IPv4_ONLY",
        .i_pv_6_only = "IPv6_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .i_pv_6_preferred => "IPv6_PREFERRED",
            .i_pv_4_preferred => "IPv4_PREFERRED",
            .i_pv_4_only => "IPv4_ONLY",
            .i_pv_6_only => "IPv6_ONLY",
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
