const std = @import("std");

pub const ProxyMode = enum {
    none,
    proxy_protocol_v2_enforced,

    pub const json_field_names = .{
        .none = "NONE",
        .proxy_protocol_v2_enforced = "PROXY_PROTOCOL_V2_ENFORCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .proxy_protocol_v2_enforced => "PROXY_PROTOCOL_V2_ENFORCED",
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
