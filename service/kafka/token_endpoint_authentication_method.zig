const std = @import("std");

/// How client credentials are sent to the identity provider's token endpoint.
pub const TokenEndpointAuthenticationMethod = enum {
    post,
    basic,
    none,

    pub const json_field_names = .{
        .post = "POST",
        .basic = "BASIC",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .post => "POST",
            .basic => "BASIC",
            .none => "NONE",
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
