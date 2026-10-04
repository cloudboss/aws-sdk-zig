const std = @import("std");

pub const OriginAccessControlSigningBehaviors = enum {
    never,
    always,
    no_override,
    always_amz_auth,

    pub const json_field_names = .{
        .never = "never",
        .always = "always",
        .no_override = "no-override",
        .always_amz_auth = "always-amz-auth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .never => "never",
            .always => "always",
            .no_override => "no-override",
            .always_amz_auth => "always-amz-auth",
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
