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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
