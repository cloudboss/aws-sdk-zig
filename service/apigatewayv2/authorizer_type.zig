const std = @import("std");

/// The authorizer type. Specify REQUEST for a Lambda function using incoming
/// request parameters. Specify JWT to use JSON Web Tokens (supported only for
/// HTTP APIs).
pub const AuthorizerType = enum {
    request,
    jwt,

    pub const json_field_names = .{
        .request = "REQUEST",
        .jwt = "JWT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request => "REQUEST",
            .jwt => "JWT",
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
